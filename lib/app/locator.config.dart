// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i10;
import 'package:tripletriocore/tripletriocore.dart' as _i13;

import '../core/models/product_service.dart' as _i18;
import '../core/models/search_service.dart' as _i20;
import '../services/access_controller_service.dart' as _i3;
import '../services/activity_service.dart' as _i4;
import '../services/adhoc_cart_service.dart' as _i5;
import '../services/api_service.dart' as _i6;
import '../services/connectivity_service.dart' as _i7;
import '../services/crate_,management_service.dart' as _i8;
import '../services/customer_service.dart' as _i9;
import '../services/init_service.dart' as _i11;
import '../services/journey_service.dart' as _i12;
import '../services/logistics_service.dart' as _i14;
import '../services/order_service.dart' as _i15;
import '../services/payments_service.dart' as _i16;
import '../services/permission_service.dart' as _i17;
import '../services/return_stock_service.dart' as _i19;
import '../services/stock_controller_service.dart' as _i21;
import '../services/stop_service.dart' as _i22;
import '../services/third_party_services_module.dart' as _i27;
import '../services/timeout_service.dart' as _i23;
import '../services/update_service.dart' as _i24;
import '../services/user_service.dart' as _i25;
import '../services/version_service.dart'
    as _i26; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i7.ConnectivityService>(() => _i7.ConnectivityService());
  gh.lazySingleton<_i8.CrateManagementService>(
      () => thirdPartyServicesModule.crateManagementService);
  gh.lazySingleton<_i9.CustomerService>(
      () => thirdPartyServicesModule.customerService);
  gh.lazySingleton<_i10.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<_i11.InitService>(
      () => thirdPartyServicesModule.initService);
  gh.lazySingleton<_i12.JourneyService>(
      () => thirdPartyServicesModule.journeyService);
  gh.lazySingleton<_i13.LocationService>(
      () => thirdPartyServicesModule.locationService);
  gh.lazySingleton<_i14.LogisticsService>(
      () => thirdPartyServicesModule.logisticsService);
  gh.lazySingleton<_i10.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i15.OrderService>(
      () => thirdPartyServicesModule.orderService);
  gh.lazySingleton<_i16.PaymentsService>(() => _i16.PaymentsService());
  gh.lazySingleton<_i17.PermissionService>(() => _i17.PermissionService());
  gh.lazySingleton<_i18.ProductService>(() => _i18.ProductService());
  gh.lazySingleton<_i19.ReturnStockService>(() => _i19.ReturnStockService());
  gh.lazySingleton<_i20.SearchService>(() => _i20.SearchService());
  gh.lazySingleton<_i10.SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<_i21.StockControllerService>(
      () => thirdPartyServicesModule.stockControlService);
  gh.lazySingleton<_i22.StopService>(() => _i22.StopService());
  gh.lazySingleton<_i23.TimeoutService>(() => _i23.TimeoutService());
  gh.lazySingleton<_i24.UpdateService>(() => _i24.UpdateService());
  gh.lazySingleton<_i25.UserService>(
      () => thirdPartyServicesModule.userService);
  gh.lazySingleton<_i26.VersionService>(() => _i26.VersionService());
  return get;
}

class _$ThirdPartyServicesModule extends _i27.ThirdPartyServicesModule {
  @override
  _i3.AccessControlService get accessControlService =>
      _i3.AccessControlService();
  @override
  _i6.ApiService get appService => _i6.ApiService();
  @override
  _i8.CrateManagementService get crateManagementService =>
      _i8.CrateManagementService();
  @override
  _i9.CustomerService get customerService => _i9.CustomerService();
  @override
  _i10.DialogService get dialogService => _i10.DialogService();
  @override
  _i11.InitService get initService => _i11.InitService();
  @override
  _i12.JourneyService get journeyService => _i12.JourneyService();
  @override
  _i13.LocationService get locationService => _i13.LocationService();
  @override
  _i14.LogisticsService get logisticsService => _i14.LogisticsService();
  @override
  _i10.NavigationService get navigationService => _i10.NavigationService();
  @override
  _i15.OrderService get orderService => _i15.OrderService();
  @override
  _i10.SnackbarService get snackbarService => _i10.SnackbarService();
  @override
  _i21.StockControllerService get stockControlService =>
      _i21.StockControllerService();
  @override
  _i25.UserService get userService => _i25.UserService();
}
