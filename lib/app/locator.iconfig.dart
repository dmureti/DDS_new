// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:distributor/services/third_party_services_module.dart';
import 'package:distributor/services/access_controller_service.dart';
import 'package:distributor/services/activity_service.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/cache_service.dart';
import 'package:distributor/services/customer_service.dart';
import 'package:distributor/core/models/data_order_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:distributor/core/models/data_filter_service.dart';
import 'package:distributor/services/init_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/order_service.dart';
import 'package:distributor/services/payments_service.dart';
import 'package:distributor/services/permission_service.dart';
import 'package:distributor/core/models/product_service.dart';
import 'package:distributor/core/models/search_service.dart';
import 'package:distributor/services/stock_controller_service.dart';
import 'package:distributor/services/stop_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<AccessControlService>(
      () => thirdPartyServicesModule.accessControlService);
  g.registerLazySingleton<ActivityService>(() => ActivityService());
  g.registerLazySingleton<ApiService>(
      () => thirdPartyServicesModule.appService);
  g.registerLazySingleton<CacheService>(
      () => thirdPartyServicesModule.cacheService);
  g.registerLazySingleton<CustomerService>(
      () => thirdPartyServicesModule.customerService);
  g.registerLazySingleton<DataOrderService>(() => DataOrderService());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<FilterService>(() => FilterService());
  g.registerLazySingleton<InitService>(
      () => thirdPartyServicesModule.initService);
  g.registerLazySingleton<JourneyService>(
      () => thirdPartyServicesModule.journeyService);
  g.registerLazySingleton<LocationService>(
      () => thirdPartyServicesModule.locationService);
  g.registerLazySingleton<LogisticsService>(
      () => thirdPartyServicesModule.logisticsService);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<OrderService>(
      () => thirdPartyServicesModule.orderService);
  g.registerLazySingleton<PaymentsService>(() => PaymentsService());
  g.registerLazySingleton<PermissionService>(() => PermissionService());
  g.registerLazySingleton<ProductService>(() => ProductService());
  g.registerLazySingleton<SearchService>(() => SearchService());
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  g.registerLazySingleton<StockControllerService>(
      () => thirdPartyServicesModule.stockControlService);
  g.registerLazySingleton<StopService>(() => StopService());
  g.registerLazySingleton<UserService>(
      () => thirdPartyServicesModule.userService);
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  AccessControlService get accessControlService => AccessControlService();
  @override
  ApiService get appService => ApiService();
  @override
  CacheService get cacheService => CacheService();
  @override
  CustomerService get customerService => CustomerService();
  @override
  DialogService get dialogService => DialogService();
  @override
  InitService get initService => InitService();
  @override
  JourneyService get journeyService => JourneyService();
  @override
  LocationService get locationService => LocationService();
  @override
  LogisticsService get logisticsService => LogisticsService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  OrderService get orderService => OrderService();
  @override
  SnackbarService get snackbarService => SnackbarService();
  @override
  StockControllerService get stockControlService => StockControllerService();
  @override
  UserService get userService => UserService();
}
