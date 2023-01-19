// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i12;

import '../core/models/product_service.dart' as _i21;
import '../core/models/search_service.dart' as _i25;
import '../services/access_controller_service.dart' as _i3;
import '../services/activity_service.dart' as _i4;
import '../services/adhoc_cart_service.dart' as _i5;
import '../services/api_service.dart' as _i6;
import '../services/base_service.dart' as _i7;
import '../services/bootstrap_service.dart' as _i8;
import '../services/connectivity_service.dart' as _i9;
import '../services/crate_,management_service.dart' as _i10;
import '../services/customer_service.dart' as _i11;
import '../services/firestore_service.dart' as _i13;
import '../services/geofence_service.dart' as _i35;
import '../services/init_service.dart' as _i14;
import '../services/journey_service.dart' as _i15;
import '../services/location_repository.dart' as _i16;
import '../services/logistics_service.dart' as _i17;
import '../services/order_service.dart' as _i18;
import '../services/payments_service.dart' as _i19;
import '../services/permission_service.dart' as _i20;
import '../services/remote_config_service.dart' as _i22;
import '../services/remote_storage_repository.dart' as _i23;
import '../services/return_stock_service.dart' as _i24;
import '../services/stock_controller_service.dart' as _i26;
import '../services/stop_service.dart' as _i27;
import '../services/third_party_services_module.dart' as _i36;
import '../services/timeout_service.dart' as _i28;
import '../services/tracking_service.dart' as _i29;
import '../services/transaction_service.dart' as _i30;
import '../services/update_service.dart' as _i31;
import '../services/user_service.dart' as _i32;
import '../services/version_service.dart' as _i33;
import '../services/waypoint_service.dart'
    as _i34; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i7.BaseService>(() => _i7.BaseService());
  gh.lazySingleton<_i8.BootstrapService>(() => _i8.BootstrapService());
  gh.lazySingleton<_i9.ConnectivityService>(() => _i9.ConnectivityService());
  gh.lazySingleton<_i10.CrateManagementService>(
      () => thirdPartyServicesModule.crateManagementService);
  gh.lazySingleton<_i11.CustomerService>(
      () => thirdPartyServicesModule.customerService);
  gh.lazySingleton<_i12.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<_i13.FirestoreService>(
      () => thirdPartyServicesModule.firestoreService);
  gh.lazySingleton<_i14.InitService>(
      () => thirdPartyServicesModule.initService);
  gh.lazySingleton<_i15.JourneyService>(
      () => thirdPartyServicesModule.journeyService);
  gh.lazySingleton<_i16.LocationRepository>(
      () => thirdPartyServicesModule.locationRepository);
  gh.lazySingleton<_i17.LogisticsService>(
      () => thirdPartyServicesModule.logisticsService);
  gh.lazySingleton<_i12.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i18.OrderService>(
      () => thirdPartyServicesModule.orderService);
  gh.lazySingleton<_i19.PaymentsService>(() => _i19.PaymentsService());
  gh.lazySingleton<_i20.PermissionService>(() => _i20.PermissionService());
  gh.lazySingleton<_i21.ProductService>(() => _i21.ProductService());
  gh.lazySingleton<_i22.RemoteConfigService>(
      () => thirdPartyServicesModule.remoteConfigService);
  gh.lazySingleton<_i23.RemoteStorageRepository>(
      () => thirdPartyServicesModule.remoteStorageRepository);
  gh.lazySingleton<_i24.ReturnStockService>(() => _i24.ReturnStockService());
  gh.lazySingleton<_i25.SearchService>(() => _i25.SearchService());
  gh.lazySingleton<_i12.SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<_i26.StockControllerService>(
      () => thirdPartyServicesModule.stockControlService);
  gh.lazySingleton<_i27.StopService>(() => _i27.StopService());
  gh.lazySingleton<_i28.TimeoutService>(() => _i28.TimeoutService());
  gh.lazySingleton<_i29.TrackingService>(() => _i29.TrackingService());
  gh.lazySingleton<_i30.TransactionService>(
      () => thirdPartyServicesModule.transactionService);
  gh.lazySingleton<_i31.UpdateService>(() => _i31.UpdateService());
  gh.lazySingleton<_i32.UserService>(
      () => thirdPartyServicesModule.userService);
  gh.lazySingleton<_i33.VersionService>(() => _i33.VersionService());
  gh.lazySingleton<_i34.WaypointService>(
      () => thirdPartyServicesModule.waypointService);
  gh.singleton<_i35.GeoFenceService>(_i35.GeoFenceService());
  return get;
}

class _$ThirdPartyServicesModule extends _i36.ThirdPartyServicesModule {
  @override
  _i3.AccessControlService get accessControlService =>
      _i3.AccessControlService();
  @override
  _i6.ApiService get appService => _i6.ApiService();
  @override
  _i10.CrateManagementService get crateManagementService =>
      _i10.CrateManagementService();
  @override
  _i11.CustomerService get customerService => _i11.CustomerService();
  @override
  _i12.DialogService get dialogService => _i12.DialogService();
  @override
  _i13.FirestoreService get firestoreService => _i13.FirestoreService();
  @override
  _i14.InitService get initService => _i14.InitService();
  @override
  _i15.JourneyService get journeyService => _i15.JourneyService();
  @override
  _i16.LocationRepository get locationRepository => _i16.LocationRepository();
  @override
  _i17.LogisticsService get logisticsService => _i17.LogisticsService();
  @override
  _i12.NavigationService get navigationService => _i12.NavigationService();
  @override
  _i18.OrderService get orderService => _i18.OrderService();
  @override
  _i22.RemoteConfigService get remoteConfigService =>
      _i22.RemoteConfigService();
  @override
  _i23.RemoteStorageRepository get remoteStorageRepository =>
      _i23.RemoteStorageRepository();
  @override
  _i12.SnackbarService get snackbarService => _i12.SnackbarService();
  @override
  _i26.StockControllerService get stockControlService =>
      _i26.StockControllerService();
  @override
  _i30.TransactionService get transactionService => _i30.TransactionService();
  @override
  _i32.UserService get userService => _i32.UserService();
  @override
  _i34.WaypointService get waypointService => _i34.WaypointService();
}
