import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/list_picker/list_picker_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ListPickerWidget extends StatelessWidget {

  final void Function(BuildContext context, Object item)? callback;
  final List<Object> items;
  final int? selectedIndex;

  const ListPickerWidget(
      {super.key, required this.items, this.selectedIndex, required this.callback});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListPickerCubit>(
      create: (context) => sl<ListPickerCubit>()..onInitialSelection(selectedIndex),
      child: ListPicker(items: items, callback: callback),
    );
  }

}

class ListPicker extends StatelessWidget {

  final void Function(BuildContext context, Object item)? callback;
  final List<Object> items;

  const ListPicker({super.key, required this.items, required this.callback});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListPickerCubit, ListPickerState>(
      listener: (context, state) {
        if (callback != null) {
          callback!(context, items[state.index]);
        }
      },
      builder: (_, state) {
        int pickerIndex = state.index;
        return TextButton(onPressed: () {
          _selectItem(context, items, pickerIndex);
        }, child: Text(
          _getDescriptions(items[pickerIndex]),
          textAlign: TextAlign.center,
          style: OptiTextStyles.body,
        ));
      },
    );
  }

  void _selectItem(BuildContext context, List<Object> items, int index) {
    int selectedIndex = index;
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext _) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<ListPickerCubit>().onPick(selectedIndex);
                  },
                  child: const Text(LocalizationConstants.done)),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    selectedIndex = index;
                  },
                  children: items.map((Object option) {
                    return Center(child: Text(_getDescriptions(option)));
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getDescriptions(Object item) {
    if (item is CarrierDto) {
      return item.description!;
    } else if (item is ShipViaDto) {
      return item.description!;
    } else {
      return '';
    }
  }

}