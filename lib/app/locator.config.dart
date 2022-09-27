// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i10;

import '../core/models/product_service.dart' as _i19;
import '../core/models/search_service.dart' as _i23;
import '../services/access_controller_service.dart' as _i3;
import '../services/activity_service.dart' as _i4;
import '../services/adhoc_cart_service.dart' as _i5;
import '../services/api_service.dart' as _i6;
import '../services/connectivity_service.dart' as _i7;
import '../services/crate_,management_service.dart' as _i8;
import '../services/customer_service.dart' as _i9;
import '../services/firestore_service.dart' as _i11;
import '../services/init_service.dart' as _i12;
import '../services/journey_service.dart' as _i13;
import '../services/location_repository.dart' as _i14;
import '../services/logistics_service.dart' as _i15;
import '../services/order_service.dart' as _i16;
import '../services/payments_service.dart' as _i17;
import '../services/permission_service.dart' as _i18;
import '../services/remote_config_service.dart' as _i20;
import '../services/remote_storage_repository.dart' as _i21;
import '../services/return_stock_service.dart' as _i22;
import '../services/stock_controller_service.dart' as _i24;
import '../services/stop_service.dart' as _i25;
import '../services/third_party_services_module.dart' as _i31;
import '../services/timeout_service.dart' as _i26;
import '../services/transaction_service.dart' as _i27;
import '../services/update_service.dart' as _i28;
import '../services/user_service.dart' as _i29;
import '../services/version_service.dart'
    as _i30; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i11.FirestoreService>(
      () => thirdPartyServicesModule.firestoreService);
  gh.lazySingleton<_i12.InitService>(
      () => thirdPartyServicesModule.initService);
  gh.lazySingleton<_i13.JourneyService>(
      () => thirdPartyServicesModule.journeyService);
  gh.lazySingleton<_i14.LocationRepository>(
      () => thirdPartyServicesModule.locationRepository);
  gh.lazySingleton<_i15.LogisticsService>(
      () => thirdPartyServicesModule.logisticsService);
  gh.lazySingleton<_i10.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i16.OrderService>(
      () => thirdPartyServicesModule.orderService);
  gh.lazySingleton<_i17.PaymentsService>(() => _i17.PaymentsService());
  gh.lazySingleton<_i18.PermissionService>(() => _i18.PermissionService());
  gh.lazySingleton<_i19.ProductService>(() => _i19.ProductService());
  gh.lazySingleton<_i20.RemoteConfigService>(
      () => thirdPartyServicesModule.remoteConfigService);
  gh.lazySingleton<_i21.RemoteStorageRepository>(
      () => thirdPartyServicesModule.remoteStorageRepository);
  gh.lazySingleton<_i22.ReturnStockService>(() => _i22.ReturnStockService());
  gh.lazySingleton<_i23.SearchService>(() => _i23.SearchService());
  gh.lazySingleton<_i10.SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  gh.lazySingleton<_i24.StockControllerService>(
      () => thirdPartyServicesModule.stockControlService);
  gh.lazySingleton<_i25.StopService>(() => _i25.StopService());
  gh.lazySingleton<_i26.TimeoutService>(() => _i26.TimeoutService());
  gh.lazySingleton<_i27.TransactionService>(
      () => thirdPartyServicesModule.transactionService);
  gh.lazySingleton<_i28.UpdateService>(() => _i28.UpdateService());
  gh.lazySingleton<_i29.UserService>(
      () => thirdPartyServicesModule.userService);
  gh.lazySingleton<_i30.VersionService>(() => _i30.VersionService());
  return get;
}

class _$ThirdPartyServicesModule extends _i31.ThirdPartyServicesModule {
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
  _i11.FirestoreService get firestoreService => _i11.FirestoreService();
  @override
  _i12.InitService get initService => _i12.InitService();
  @override
  _i13.JourneyService get journeyService => _i13.JourneyService();
  @override
  _i14.LocationRepository get locationRepository => _i14.LocationRepository();
  @override
  _i15.LogisticsService get logisticsService => _i15.LogisticsService();
  @override
  _i10.NavigationService get navigationService => _i10.NavigationService();
  @override
  _i16.OrderService get orderService => _i16.OrderService();
  @override
  _i20.RemoteConfigService get remoteConfigService =>
      _i20.RemoteConfigService();
  @override
  _i21.RemoteStorageRepository get remoteStorageRepository =>
      _i21.RemoteStorageRepository();
  @override
  _i10.SnackbarService get snackbarService => _i10.SnackbarService();
  @override
  _i24.StockControllerService get stockControlService =>
      _i24.StockControllerService();
  @override
  _i27.TransactionService get transactionService => _i27.TransactionService();
  @override
  _i29.UserService get userService => _i29.UserService();
}
