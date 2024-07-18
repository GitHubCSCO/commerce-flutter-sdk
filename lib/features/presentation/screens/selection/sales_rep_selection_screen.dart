import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/selection/sales_rep_selection/sales_rep_selection_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/widget/selection_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SalesRepSelectionScreen extends StatelessWidget {
  final CatalogTypeSelectingParameter parameter;

  const SalesRepSelectionScreen({
    super.key,
    required this.parameter,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SalesRepSelectionCubit>()
        ..initialize(
          parameter: parameter,
        ),
      child: const SalesRepSelectionPage(),
    );
  }
}

class SalesRepSelectionPage extends StatelessWidget {
  const SalesRepSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OptiAppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: const Text(LocalizationConstants.selectSalesRep),
        centerTitle: false,
      ),
      body: BlocBuilder<SalesRepSelectionCubit, SalesRepSelectionState>(
        builder: (context, state) {
          if (state.status == SalesRepStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == SalesRepStatus.failiure) {
            return const Center(
              child: Text(LocalizationConstants.error),
            );
          }

          return _SalesRepListWidget(salesRepList: state.salesRepList ?? []);
        },
      ),
    );
  }
}

class _SalesRepListWidget extends StatefulWidget {
  final List<CatalogTypeDto> salesRepList;

  const _SalesRepListWidget({
    required this.salesRepList,
  });

  @override
  State<_SalesRepListWidget> createState() => __SalesRepListWidgetState();
}

class __SalesRepListWidgetState extends State<_SalesRepListWidget> {
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) {
      context.read<SalesRepSelectionCubit>().loadMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) {
      return false;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesRepSelectionCubit, SalesRepSelectionState>(
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            if (index >= (state.salesRepList?.length ?? 0) &&
                state.status == SalesRepStatus.moreLoading) {
              return const Padding(
                padding: EdgeInsets.all(10),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final salesRep = widget.salesRepList[index];
            return Container(
              color: OptiAppColors.backgroundWhite,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SelectionItemWidget(
                item: salesRep,
                label: salesRep.title ?? '',
                isSelected: salesRep.id == state.selectedId,
                onCallBack: (context, selectedSalesRep) {
                  context.read<SalesRepSelectionCubit>().setSelectedSalesRep(
                        selectedSalesRep: selectedSalesRep as CatalogTypeDto,
                      );

                  context.pop(selectedSalesRep);
                },
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: state.status == SalesRepStatus.moreLoading
              ? widget.salesRepList.length + 1
              : widget.salesRepList.length,
        );
      },
    );
  }
}
