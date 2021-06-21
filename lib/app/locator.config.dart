// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i8;
import 'package:tripletriocore/tripletriocore.dart' as _i11;

import '../core/models/product_service.dart' as _i16;
import '../core/models/search_service.dart' as _i17;
import '../services/access_controller_service.dart' as _i3;
import '../services/activity_service.dart' as _i4;
import '../services/adhoc_cart_service.dart' as _i5;
import '../services/api_service.dart' as _i6;
import '../services/customer_service.dart' as _i7;
import '../services/init_service.dart' as _i9;
import '../services/journey_service.dart' as _i10;
import '../services/logistics_service.dart' as _i12;
import '../services/order_service.dart' as _i13;
import '../services/payments_service.dart' as _i14;
import '../services/permission_service.dart' as _i15;
import '../services/stock_controller_service.dart' as _i18;
import '../services/stop_service.dart' as _i19;
import '../services/third_party_services_module.dart' as _i21;
import '../services/user_service.dart'
    as _i20; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i7.CustomerService>(
      () => thirdPartyServicesModule.customerService);
  gh.lazySingleton<_i8.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<_i9.InitService>(() => thirdPartyServicesModule.initService);
  gh.lazySingleton<_i10.JourneyService>(
      () => thirdPartyServicesModule.journeyService);
  gh.lazySingleton<_i11.LocationService>(
      () => thirdPartyServicesModule.locationService);
  gh.lazySingleton<_i12.LogisticsService>(
      () => thirdPartyServicesModule.logisticsService);
  gh.lazySingleton<_i8.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i13.OrderService>(
      () => thirdPartyServicesModule.orderService);
  gh.lazySingleton<_i14.PaymentsService>(() => _i14.PaymentsService());
  gh.lazySingleton<_i15.PermissionService>(() => _i15.PermissionService());
  gh.lazySingleton<_i16.ProductService>(() => _i16.ProductService());
  gh.lazySingleton<_i17.SearchService>(() => _i17.SearchService());
  gh.lazySingleton<_i8.SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<_i18.StockControllerService>(
      () => thirdPartyServicesModule.stockControlService);
  gh.lazySingleton<_i19.StopService>(() => _i19.StopService());
  gh.lazySingleton<_i20.UserService>(
      () => thirdPartyServicesModule.userService);
  return get;
}

class _$ThirdPartyServicesModule extends _i21.ThirdPartyServicesModule {
  @override
  _i3.AccessControlService get accessControlService =>
      _i3.AccessControlService();
  @override
  _i6.ApiService get appService => _i6.ApiService();
  @override
  _i7.CustomerService get customerService => _i7.CustomerService();
  @override
  _i8.DialogService get dialogService => _i8.DialogService();
  @override
  _i9.InitService get initService => _i9.InitService();
  @override
  _i10.JourneyService get journeyService => _i10.JourneyService();
  @override
  _i11.LocationService get locationService => _i11.LocationService();
  @override
  _i12.LogisticsService get logisticsService => _i12.LogisticsService();
  @override
  _i8.NavigationService get navigationService => _i8.NavigationService();
  @override
  _i13.OrderService get orderService => _i13.OrderService();
  @override
  _i8.SnackbarService get snackbarService => _i8.SnackbarService();
  @override
  _i18.StockControllerService get stockControlService =>
      _i18.StockControllerService();
  @override
  _i20.UserService get userService => _i20.UserService();
}
