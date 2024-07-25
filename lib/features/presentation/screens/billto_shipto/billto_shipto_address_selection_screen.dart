import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/context.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/enums/address_type.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/billto_shipto/address_selection/billto_shipto_address_selection_bloc.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillToShipToAddressSelectionEntity {

  BillTo? selectedBillTo;
  ShipTo? selectedShipTo;
  AddressType addressType;

  BillToShipToAddressSelectionEntity({this.selectedBillTo, this.selectedShipTo, required this.addressType});

}

class BillToShipToAddressSelectionScreen extends StatelessWidget {
  final BillToShipToAddressSelectionEntity billToShipToAddressSelectionEntity;

  const BillToShipToAddressSelectionScreen(
      {super.key, required this.billToShipToAddressSelectionEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BilltoShiptoAddressSelectionBloc>(
      create: (context) => sl<BilltoShiptoAddressSelectionBloc>()
        ..add(BilltoShiptoAddressLoadEvent(
            searchQuery: '', currentPage: 1, selectionEntity: billToShipToAddressSelectionEntity)),
      child: BillToShipToAddressSelectionPage(
        selectionEntity: billToShipToAddressSelectionEntity,
      ),
    );
  }
}

class BillToShipToAddressSelectionPage extends StatefulWidget {

  final BillToShipToAddressSelectionEntity selectionEntity;

  const BillToShipToAddressSelectionPage(
      {super.key, required this.selectionEntity});

  @override
  State<BillToShipToAddressSelectionPage> createState() =>
      _BillToShipToAddressSelectionPageState();
}

class _BillToShipToAddressSelectionPageState
    extends State<BillToShipToAddressSelectionPage> {
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectionEntity.addressType == AddressType.billTo
            ? LocalizationConstants.selectBillingAddress.localized()
            : LocalizationConstants.selectShippingAddress.localized()),
        backgroundColor: OptiAppColors.backgroundWhite,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Input(
              hintText: LocalizationConstants.search.localized(),
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  AssetConstants.iconClear,
                  semanticsLabel: 'search query clear icon',
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  textEditingController.clear();
                  context.read<BilltoShiptoAddressSelectionBloc>().add(
                      BilltoShiptoAddressLoadEvent(
                          searchQuery: '',
                          currentPage: 1,
                          selectionEntity: widget.selectionEntity));
                  context.closeKeyboard();
                },
              ),
              onTapOutside: (p0) => context.closeKeyboard(),
              textInputAction: TextInputAction.search,
              onSubmitted: (String query) {
                context.read<BilltoShiptoAddressSelectionBloc>().add(
                    BilltoShiptoAddressLoadEvent(
                        searchQuery: query,
                        currentPage: 1,
                        selectionEntity: widget.selectionEntity));
              },
              controller: textEditingController,
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: BlocBuilder<BilltoShiptoAddressSelectionBloc,
                BilltoShiptoAddressSelectionState>(
              builder: (context, state) {
                switch (state) {
                  case BilltoShiptoAddressSelectionInitial():
                  case BilltoShiptoAddressSelectionLoading():
                    return const Center(child: CircularProgressIndicator());
                  case BilltoShiptoAddressSelectionLoaded():
                    final list = state.list ?? [];
                    final selectedAddressId =
                        widget.selectionEntity.addressType ==
                                AddressType.billTo
                            ? widget.selectionEntity
                                .selectedBillTo?.id
                            : widget.selectionEntity
                                .selectedShipTo?.id;
                    return Container(
                      color: OptiAppColors.backgroundWhite,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.separated(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final address = list[index];
                          final isSelected =
                            address.id == selectedAddressId
                                  ? true
                                  : false;
                          return BillToShipToListItem(
                              address: address,
                              isSelected: isSelected,
                              onCallBack: _handleAddressSelection);
                        },
                        separatorBuilder: (context, index) => const Divider(
                          height: 0,
                          thickness: 0.3,
                        ),
                      ),
                    );
                  case BilltoShiptoAddressSelectionFailed():
                  default:
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverFillRemaining(
                          child: Center(
                            child: Text(LocalizationConstants.error.localized()),
                          ),
                        ),
                      ],
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleAddressSelection(BuildContext context, Address address) {
    if (widget.selectionEntity.addressType == AddressType.billTo) {
      setState(() {
        widget.selectionEntity.selectedBillTo = address as BillTo?;
      });
    } else {
      setState(() {
        widget.selectionEntity.selectedShipTo = address as ShipTo?;
      });
    }
    context.pop(address);
  }
}

class BillToShipToListItem extends StatelessWidget {
  final Address address;
  final bool isSelected;
  final void Function(BuildContext context, Address address)? onCallBack;

  const BillToShipToListItem(
      {super.key,
      required this.address,
      required this.isSelected,
      this.onCallBack});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onCallBack != null) {
          onCallBack!(context, address);
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        address.label ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: OptiTextStyles.body.copyWith(
                            fontWeight: isSelected
                                ? OptiTextStyles.bodyHighlightWeight
                                : OptiTextStyles.bodyWeight),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 2),
            Visibility(
              visible: isSelected,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(7),
                child: const Icon(
                  Icons.radio_button_checked,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
