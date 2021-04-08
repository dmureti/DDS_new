// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i10;
import 'package:tripletriocore/tripletriocore.dart' as _i14;

import '../core/models/data_filter_service.dart' as _i11;
import '../core/models/data_order_service.dart' as _i9;
import '../core/models/product_service.dart' as _i19;
import '../core/models/search_service.dart' as _i20;
import '../services/access_controller_service.dart' as _i3;
import '../services/activity_service.dart' as _i4;
import '../services/adhoc_cart_service.dart' as _i5;
import '../services/api_service.dart' as _i6;
import '../services/cache_service.dart' as _i7;
import '../services/customer_service.dart' as _i8;
import '../services/init_service.dart' as _i12;
import '../services/journey_service.dart' as _i13;
import '../services/logistics_service.dart' as _i15;
import '../services/order_service.dart' as _i16;
import '../services/payments_service.dart' as _i17;
import '../services/permission_service.dart' as _i18;
import '../services/stock_controller_service.dart' as _i21;
import '../services/stop_service.dart' as _i22;
import '../services/third_party_services_module.dart' as _i24;
import '../services/user_service.dart'
    as _i23; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<_i3.AccessControlService>(
      () => thirdPartyServicesModule.accessControlService);
  gh.lazySingleton<_i4.ActivityService>(() => _i4.ActivityService());
  gh.lazySingleton<_i5.AdhocCartService>(() => _i5.AdhocCartService());
  gh.lazySingleton<_i6.ApiService>(() => thirdPartyServicesModule.appService);
  gh.lazySingleton<_i7.CacheService>(
      () => thirdPartyServicesModule.cacheService);
  gh.lazySingleton<_i8.CustomerService>(
      () => thirdPartyServicesModule.customerService);
  gh.lazySingleton<_i9.DataOrderService>(() => _i9.DataOrderService());
  gh.lazySingleton<_i10.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<_i11.FilterService>(() => _i11.FilterService());
  gh.lazySingleton<_i12.InitService>(
      () => thirdPartyServicesModule.initService);
  gh.lazySingleton<_i13.JourneyService>(
      () => thirdPartyServicesModule.journeyService);
  gh.lazySingleton<_i14.LocationService>(
      () => thirdPartyServicesModule.locationService);
  gh.lazySingleton<_i15.LogisticsService>(
      () => thirdPartyServicesModule.logisticsService);
  gh.lazySingleton<_i10.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i16.OrderService>(
      () => thirdPartyServicesModule.orderService);
  gh.lazySingleton<_i17.PaymentsService>(() => _i17.PaymentsService());
  gh.lazySingleton<_i18.PermissionService>(() => _i18.PermissionService());
  gh.lazySingleton<_i19.ProductService>(() => _i19.ProductService());
  gh.lazySingleton<_i20.SearchService>(() => _i20.SearchService());
  gh.lazySingleton<_i10.SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<_i21.StockControllerService>(
      () => thirdPartyServicesModule.stockControlService);
  gh.lazySingleton<_i22.StopService>(() => _i22.StopService());
  gh.lazySingleton<_i23.UserService>(
      () => thirdPartyServicesModule.userService);
  return get;
}

class _$ThirdPartyServicesModule extends _i24.ThirdPartyServicesModule {
  @override
  _i3.AccessControlService get accessControlService =>
      _i3.AccessControlService();
  @override
  _i6.ApiService get appService => _i6.ApiService();
  @override
  _i7.CacheService get cacheService => _i7.CacheService();
  @override
  _i8.CustomerService get customerService => _i8.CustomerService();
  @override
  _i10.DialogService get dialogService => _i10.DialogService();
  @override
  _i12.InitService get initService => _i12.InitService();
  @override
  _i13.JourneyService get journeyService => _i13.JourneyService();
  @override
  _i14.LocationService get locationService => _i14.LocationService();
  @override
  _i15.LogisticsService get logisticsService => _i15.LogisticsService();
  @override
  _i10.NavigationService get navigationService => _i10.NavigationService();
  @override
  _i16.OrderService get orderService => _i16.OrderService();
  @override
  _i10.SnackbarService get snackbarService => _i10.SnackbarService();
  @override
  _i21.StockControllerService get stockControlService =>
      _i21.StockControllerService();
  @override
  _i23.UserService get userService => _i23.UserService();
}
