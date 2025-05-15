// main.dart

import 'services/account_service_example.dart' as account_service_example;
import 'services/bill_to_service_example.dart' as bill_to_service_example;
import 'services/brand_service_example.dart' as brand_service_example;
import 'services/cart_service_example.dart' as cart_service_example;
import 'services/catalogpages_service_example.dart'
    as catalogpages_service_example;
import 'services/category_service_example.dart' as category_service_example;
import 'services/dashboard_panels_service_example.dart'
    as dashboard_panels_service_example;
import 'services/dealer_service_example.dart' as dealer_service_example;
import 'services/invoice_service_example.dart' as invoice_service_example;
import 'services/job_quote_service_example.dart' as job_quote_service_example;
import 'services/mobile_content_service_example.dart'
    as mobile_content_service_example;
import 'services/mobile_spire_content_service_example.dart'
    as mobile_spire_content_service_example;
import 'services/order_service_example.dart' as order_service_example;
import 'services/product_service_example.dart' as product_service_example;
import 'services/quote_service_example.dart' as quote_service_example;
import 'services/settings_service_example.dart' as settings_service_example;
import 'services/token_ex_config_service_example.dart'
    as token_ex_config_service_example;
import 'services/translation_service_example.dart'
    as translation_service_example;
import 'services/warehouse_service_example.dart' as warehouse_service_example;
import 'services/wish_list_service_example.dart' as wish_list_service_example;

void main() async {
  await Future(account_service_example.main);
  await Future(bill_to_service_example.main);
  await Future(brand_service_example.main);
  await Future(cart_service_example.main);
  await Future(catalogpages_service_example.main);
  await Future(category_service_example.main);
  await Future(dashboard_panels_service_example.main);
  await Future(dealer_service_example.main);
  await Future(invoice_service_example.main);
  await Future(job_quote_service_example.main);
  await Future(mobile_content_service_example.main);
  await Future(mobile_spire_content_service_example.main);
  await Future(order_service_example.main);
  await Future(product_service_example.main);
  await Future(quote_service_example.main);
  await Future(settings_service_example.main);
  await Future(token_ex_config_service_example.main);
  await Future(translation_service_example.main);
  await Future(warehouse_service_example.main);
  await Future(wish_list_service_example.main);
}
