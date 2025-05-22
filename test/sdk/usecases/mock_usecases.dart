import 'package:commerce_flutter_sdk/src/features/domain/usecases/domain_usecase/domain_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/login_usecase/login_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/logout_usecase/logout_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/shop_usecase/shop_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockShopUseCase extends Mock implements ShopUseCase {}

class MockDomainUsecase extends Mock implements DomainUsecase {}

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockLogoutUsecase extends Mock implements LogoutUsecase {}
