class WebsitePaths {
  static const shopWebsitePath = '/';
  static const cartWebsitePath = 'redirectto/CartPage';
  static const listsWebsitePath = 'redirectto/MyListsPage';
  static const listDetailsWebsitePath = 'redirectto/MyListDetailPage?id=%s';
  static const savedOrdersWebsitePath = 'redirectto/SavedOrderListPage';
  static const savedOrderDetailsWebsitePath =
      'redirectto/SavedOrderDetailPage?cartId=%s';
  static const orderApprovalWebsitePath = 'redirectto/OrderApprovalListPage';
  static const orderApprovalDetailsWebsitePath =
      'redirectto/OrderApprovalDetailPage?cartId=%s';
  static const brandsWebsitePath = 'redirectto/BrandsPage';
  static const accountWebsitePath = 'redirectto/myaccountpage';
  static const ordersPath = 'redirectto/OrdersPage';
  static const vmiOrdersPath =
      'redirectto/VmiOrdersPage?customerSequence=-1&vmiLocationId=%s';
  static const invoiceHistoryWebsitePath = 'redirectto/InvoicesPage';
  static const invoiceDetailWebsitePath =
      'redirectto/InvoiceDetailPage?invoiceNumber=%s';
  static const myQuotesWebsitePath = 'redirectto/RfqMyQuotesPage';
  static const jobQuotesWebsitePath = 'redirectto/RfqJobQuotesPage';
  static const myQuoteDetailsWebsitePath =
      'redirectto/RfqQuoteDetailsPage?quoteId=%s';
  static const jobQuoteDetailsWebsitePath =
      'redirectto/RfqJobQuoteDetailsPage?jobQuoteId=%s';
}

class PrintPaths {
  static const invoiceDetailPrintPath = 'Invoice/GetPdf?invoiceNumber=%s';
  static const orderDetailPrintPath =
      'Order/GetPdf?orderNumber=%s&stPostalCode=%s';
}
