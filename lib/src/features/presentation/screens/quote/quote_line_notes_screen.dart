import 'package:commerce_flutter_sdk/src/core/colors/app_colors.dart';
import 'package:commerce_flutter_sdk/src/core/constants/localization_constants.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuoteLineNotesScreen extends StatefulWidget {
  const QuoteLineNotesScreen({
    super.key,
    required this.initialText,
  });

  final String? initialText;

  @override
  State<QuoteLineNotesScreen> createState() => _QuoteLineNotesScreenState();
}

class _QuoteLineNotesScreenState extends State<QuoteLineNotesScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OptiAppColors.backgroundWhite,
        title: Text(LocalizationConstants.lineNotes.localized()),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: LocalizationConstants.enterLineNotes
                                .localized(),
                          ),
                          scrollPadding: const EdgeInsets.all(20.0),
                          keyboardType: TextInputType.multiline,
                          maxLines: 99999,
                          autofocus: true,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              OrderBottomSectionWidget(
                actions: [
                  PrimaryButton(
                    isEnabled: controller.text.isNotEmpty &&
                        controller.text != widget.initialText,
                    text: LocalizationConstants.save.localized(),
                    onPressed: () {
                      context.pop(controller.text);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
