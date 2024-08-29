import 'package:commerce_flutter_app/core/colors/app_colors.dart';
import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/asset_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/core/mixins/validator_mixin.dart';
import 'package:commerce_flutter_app/core/themes/theme.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/components/dialog.dart';
import 'package:commerce_flutter_app/features/presentation/components/input.dart';
import 'package:commerce_flutter_app/features/presentation/components/snackbar_coming_soon.dart';
import 'package:commerce_flutter_app/features/presentation/components/style.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/invoice_history/invoice_email/invoice_email_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/screens/base_screen.dart';
import 'package:commerce_flutter_app/features/presentation/widget/order_details_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InvoiceEmailScreen extends BaseStatelessWidget {
  final String invoiceNumber;

  const InvoiceEmailScreen({
    super.key,
    required this.invoiceNumber,
  });

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<InvoiceEmailCubit>()..initialize(),
      child: InvoiceEmailPage(invoiceNumber: invoiceNumber),
    );
  }

  @override
  AnalyticsEvent getAnalyticsEvent() {
    var viewScreenEvent = AnalyticsEvent(AnalyticsConstants.eventViewScreen,
            AnalyticsConstants.screenNameInvoiceEmail)
        .withProperty(
            name: AnalyticsConstants.screenNameInvoiceEmail,
            strValue: invoiceNumber);
    return viewScreenEvent;
  }
}

class InvoiceEmailPage extends StatefulWidget {
  final String invoiceNumber;

  const InvoiceEmailPage({
    super.key,
    required this.invoiceNumber,
  });

  @override
  State<InvoiceEmailPage> createState() => _InvoiceEmailPageState();
}

class _InvoiceEmailPageState extends State<InvoiceEmailPage>
    with ValidatorMixin {
  late final TextEditingController _emailToController;
  late final TextEditingController _emailFromController;
  late final TextEditingController _messageController;

  late final String subject;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _emailFromController = TextEditingController(
      text: context.read<InvoiceEmailCubit>().currentSession?.email ?? '',
    );

    _emailToController = TextEditingController();
    _messageController = TextEditingController();

    subject =
        '${LocalizationConstants.invoice.localized()}#${widget.invoiceNumber}';
  }

  @override
  void dispose() {
    _emailFromController.dispose();
    _emailToController.dispose();
    _messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvoiceEmailCubit, InvoiceEmailState>(
      listener: (context, state) {
        if (state is InvoiceEmailLoading) {
          showPleaseWait(context);
        }

        if (state is InvoiceEmailSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          CustomSnackBar.showSnackBarMessage(
            context,
            LocalizationConstants.emailSentSuccessfully.localized(),
          );
        }

        if (state is InvoiceEmailFailure) {
          Navigator.of(context, rootNavigator: true).pop();
          CustomSnackBar.showSnackBarMessage(
            context,
            state.message,
          );
        }
      },
      child: Scaffold(
        backgroundColor: OptiAppColors.backgroundGray,
        appBar: AppBar(
          backgroundColor: OptiAppColors.backgroundWhite,
          centerTitle: false,
          title: Text(
            LocalizationConstants.emailInvoice.localized(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2),
            child: Container(
              color: AppStyle.neutral75,
              height: 2,
            ),
          ),
        ),
        body: Container(
          color: OptiAppColors.backgroundWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                LocalizationConstants.attachment.localized(),
                                style: OptiTextStyles.body,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.asset(
                                      AssetConstants.pdfIcon,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'invoice_${widget.invoiceNumber}.pdf',
                                    style: OptiTextStyles.body,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Input(
                            controller: _emailToController,
                            label: LocalizationConstants.emailTo.localized(),
                            isRequired: true,
                            hintText: 'i.e. name@example.com',
                            validator: (value) => validateEmail(
                              _emailToController.text.trim(),
                            ),
                            onTapOutside: (_) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Input(
                            controller: _emailFromController,
                            label: LocalizationConstants.emailFrom.localized(),
                            isRequired: true,
                            onTapOutside: (_) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                            validator: (value) => validateEmail(
                              _emailFromController.text.trim(),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          AbsorbPointer(
                            absorbing: true,
                            child: Input(
                              label: LocalizationConstants.subject.localized(),
                              hintText: subject,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Input(
                            controller: _messageController,
                            label: LocalizationConstants.message.localized(),
                            onTapOutside: (_) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              OrderBottomSectionWidget(
                actions: [
                  PrimaryButton(
                    text: LocalizationConstants.send.localized(),
                    onPressed: () {
                      if (!(_formKey.currentState?.validate() ?? false)) {
                        return;
                      }

                      context.read<InvoiceEmailCubit>().sendEmail(
                            emailTo: _emailToController.text.trim(),
                            emailFrom: _emailFromController.text.trim(),
                            subject: subject,
                            message: _messageController.text,
                            invoiceNumber: widget.invoiceNumber,
                          );
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
