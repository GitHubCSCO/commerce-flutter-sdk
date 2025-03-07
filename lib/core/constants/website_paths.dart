class WebsitePaths {
  static const shopWebsitePath = '/';
  static const cartWebsitePath = 'redirectto/mobileauth/CartPage';
  static const listsWebsitePath = 'redirectto/mobileauth/MyListsPage';
  static const listDetailsWebsitePath =
      'redirectto/mobileauth/MyListDetailPage?id=%s';
  static const savedOrdersWebsitePath =
      'redirectto/mobileauth/SavedOrderListPage';
  static const savedOrderDetailsWebsitePath =
      'redirectto/mobileauth/SavedOrderDetailPage?cartId=%s';
  static const orderApprovalWebsitePath =
      'redirectto/mobileauth/OrderApprovalListPage';
  static const orderApprovalDetailsWebsitePath =
      'redirectto/mobileauth/OrderApprovalDetailPage?cartId=%s';
  static const brandsWebsitePath = 'redirectto/mobileauth/BrandsPage';
  static const accountWebsitePath = 'redirectto/mobileauth/myaccountpage';
  static const ordersPath = 'redirectto/mobileauth/OrdersPage';
  static const vmiOrdersPath =
      'redirectto/mobileauth/VmiOrdersPage?customerSequence=-1&vmiLocationId=%s';
  static const invoiceHistoryWebsitePath = 'redirectto/mobileauth/InvoicesPage';
  static const invoiceDetailWebsitePath =
      'redirectto/mobileauth/InvoiceDetailPage?invoiceNumber=%s';
  static const myQuotesWebsitePath = 'redirectto/mobileauth/RfqMyQuotesPage';
  static const jobQuotesWebsitePath = 'redirectto/mobileauth/RfqJobQuotesPage';
  static const myQuoteDetailsWebsitePath =
      'redirectto/mobileauth/RfqQuoteDetailsPage?quoteId=%s';
  static const jobQuoteDetailsWebsitePath =
      'redirectto/mobileauth/RfqJobQuoteDetailsPage?jobQuoteId=%s';
  static const quoteRequestWebsitePath =
      'redirectto/mobileauth/QuoteRequestPage';
  static const savedPaymentsWebsitePath =
      'redirectto/mobileauth/MySavedPaymentsPage';
}

class PrintPaths {
  static const invoiceDetailPrintPath = 'Invoice/GetPdf?invoiceNumber=%s';
  static const orderDetailPrintPath =
      'Order/GetPdf?orderNumber=%s&stPostalCode=%s';
}
