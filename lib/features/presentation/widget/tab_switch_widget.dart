import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:flutter/material.dart';

class TabSwitchWidget extends StatefulWidget {
  final String tabTitle0;
  final String tabTitle1;
  final Widget tabWidget0;
  final Widget tabWidget1;
  final int selectedIndex;
  final void Function(int)? onTabSelectionChange;

  const TabSwitchWidget(
      {super.key,
      required this.tabTitle0,
      required this.tabTitle1,
      required this.tabWidget0,
      required this.tabWidget1,
      this.selectedIndex = 0,
      this.onTabSelectionChange});

  @override
  State<TabSwitchWidget> createState() => _TabSwitchWidgetState();
}

class _TabSwitchWidgetState extends State<TabSwitchWidget> {
  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: OptiAppColors.backgroundGray,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildSelectableContainer(
                    text: widget.tabTitle0,
                    isSelected: selectedIndex == 0,
                    onTap: () {
                      if (selectedIndex != 0) {
                        widget.onTabSelectionChange?.call(0);
                        setState(() {
                          selectedIndex = 0;
                        });
                      }
                    },
                  ),
                  _buildSelectableContainer(
                    text: widget.tabTitle1,
                    isSelected: selectedIndex == 1,
                    onTap: () {
                      if (selectedIndex != 1) {
                        widget.onTabSelectionChange?.call(1);
                        setState(() {
                          selectedIndex = 1;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          child: selectedIndex == 0 ? widget.tabWidget0 : widget.tabWidget1,
        )
      ],
    );
  }

  Widget _buildSelectableContainer({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? OptiAppColors.backgroundWhite
                : OptiAppColors.backgroundGray,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                text,
                style: OptiTextStyles.subtitle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
