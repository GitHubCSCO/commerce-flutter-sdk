import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/list_picker/list_picker_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ListPickerWidget extends StatelessWidget {
  final List<Object> items;

  const ListPickerWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListPickerCubit>(
      create: (context) => sl<ListPickerCubit>(),
      child: ListPicker(items: items),
    );
  }

}

class ListPicker extends StatelessWidget {

  final List<Object> items;

  const ListPicker({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    int pickerIndex = context.read<ListPickerCubit>().pickerIndex;
    return TextButton(onPressed: () {
      _selectCarrier(context, items, pickerIndex);
    }, child: Text(
      _getDescriptions(items[pickerIndex]),
      textAlign: TextAlign.center,
      style: OptiTextStyles.body,
    ));
  }

  void _selectCarrier(BuildContext context, List<Object> carriers, int index) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  child: const Text(LocalizationConstants.done)),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  onSelectedItemChanged: (int index) {
                    context.read<ListPickerCubit>().onPick(index);
                  },
                  children: carriers.map((Object option) {
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