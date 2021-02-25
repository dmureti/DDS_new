import 'package:distributor/services/access_controller_service.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/cache_service.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/init_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/order_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

@module
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
  @lazySingleton
  SnackbarService get snackbarService;
  @lazySingleton
  InitService get initService;
  @lazySingleton
  ApiService get appService;
  @lazySingleton
  UserService get userService;
  @lazySingleton
  CustomerService get customerService;
  @lazySingleton
  AccessControlService get accessControlService;
  @lazySingleton
  StockControllerService get stockControlService;
  @lazySingleton
  LogisticsService get logisticsService;
  @lazySingleton
  JourneyService get journeyService;
  @lazySingleton
  CacheService get cacheService;
  @lazySingleton
  OrderService get orderService;
  @lazySingleton
  LocationService get locationService;
}
