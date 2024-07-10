// ignore_for_file: unused_element

import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

enum InvoiceSortOrder implements SortOrderAttribute {
  /// TODO - make the groupTitle and title localized

  invoiceDateDescending(
    groupTitle: 'Date',
    title: 'Date \u2193',
    value: 'InvoiceDate DESC',
  ),

  invoiceDateAscending(
    groupTitle: 'Date',
    title: 'Date \u2191',
    value: 'InvoiceDate',
  ),

  invoiceNumberDescending(
    groupTitle: 'Invoice Number',
    title: 'Invoice Number \u2193',
    value: 'InvoiceNumber DESC',
  ),

  invoiceNumberAscending(
    groupTitle: 'Invoice Number',
    title: 'Invoice Number \u2191',
    value: 'InvoiceNumber',
  ),

  dueDateDescending(
    groupTitle: 'Due Date',
    title: 'Due Date \u2193',
    value: 'DueDate DESC',
  ),

  dueDateAscending(
    groupTitle: 'Due Date',
    title: 'Due Date \u2191',
    value: 'DueDate',
  ),

  stCompanyNameDescending(
    groupTitle: 'Ship To / Pick Up',
    title: 'Ship To / Pick Up \u2193',
    value: 'STCompanyName DESC',
  ),

  stCompanyNameAscending(
    groupTitle: 'Ship To / Pick Up',
    title: 'Ship To / Pick Up \u2191',
    value: 'STCompanyName',
  ),

  customerPODescending(
    groupTitle: 'PO Number',
    title: 'PO Number \u2193',
    value: 'CustomerPO DESC',
  ),

  customerPOAscending(
    groupTitle: 'PO Number',
    title: 'PO Number \u2191',
    value: 'CustomerPO',
  ),

  termsDescending(
    groupTitle: 'Terms',
    title: 'Terms \u2193',
    value: 'Terms DESC',
  ),

  termsAscending(
    groupTitle: 'Terms',
    title: 'Terms \u2191',
    value: 'Terms',
  ),

  invoiceTotalDescending(
    groupTitle: 'Total',
    title: 'Total \u2193',
    value: 'InvoiceTotal DESC',
  ),

  invoiceTotalAscending(
    groupTitle: 'Total',
    title: 'Total \u2191',
    value: 'InvoiceTotal',
  ),

  currentBalanceDescending(
    groupTitle: 'Balance',
    title: 'Balance \u2193',
    value: 'CurrentBalance DESC',
  ),

  currentBalanceAscending(
    groupTitle: 'Balance',
    title: 'Balance \u2191',
    value: 'CurrentBalance',
  ),
  ;

  const InvoiceSortOrder({
    required this.groupTitle,
    required this.title,
    required this.value,
    this.sortOrderOptions,
  });

  @override
  final String groupTitle;

  @override
  final String title;

  @override
  final String value;

  final SortOrderOptions? sortOrderOptions;

  @override
  SortOrderOptions? get sortOrderOption => sortOrderOptions;
}
