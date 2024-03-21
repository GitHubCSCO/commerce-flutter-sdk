import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';

class OrderUsecase extends BaseUseCase {
  Future<List<OrderEntity>?> getOrderHistory() async {
    // TODO - put proper implementation
    return Future.delayed(
      const Duration(seconds: 1),
      () => [
        OrderEntity(
          webOrderNumber: 'WEB001022',
          orderNumberLabel: '828288282',
          customerPO: 'X76332',
          stCompanyName: 'St. George',
          orderDate: DateTime.tryParse('2021-07-01'),
          orderGrandTotalDisplay: '\$14,000.00',
          statusDisplay: 'Pending',
          webOrderNumberLabel: 'Web Order #',
          poNumberLabel: 'PO #',
        ),
        OrderEntity(
          webOrderNumber: 'WEB001023',
          orderNumberLabel: '828288283',
          customerPO: 'X76333',
          stCompanyName: 'St. George',
          orderDate: DateTime.tryParse('2021-07-02'),
          orderGrandTotalDisplay: '\$15,000.00',
          statusDisplay: 'Pending',
          webOrderNumberLabel: 'Web Order #',
          poNumberLabel: 'PO #',
        ),
      ],
    );
  }
}
