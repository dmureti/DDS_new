import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/core/helper.dart';
import 'package:distributor/core/models/app_models.dart';
import 'package:distributor/services/access_controller_service.dart';
import 'package:distributor/services/activity_service.dart';
import 'package:distributor/services/adhoc_cart_service.dart';
import 'package:distributor/services/init_service.dart';
import 'package:distributor/services/journey_service.dart';

import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/permission_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:distributor/services/version_service.dart';
import 'package:distributor/traits/contextual_viewmodel.dart';
import 'package:distributor/ui/views/adhoc_sales/adhoc_sales_view.dart';

import 'package:distributor/ui/views/customers/customer_view.dart';
import 'package:distributor/ui/views/dashboard/dashboard_view.dart';
import 'package:distributor/ui/views/routes/route_listing_view.dart';
import 'package:distributor/ui/views/stock/stock_view.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class HomeViewModel extends ReactiveViewModel with ContextualViewmodel {
  PermissionService _permissionService = locator<PermissionService>();
  LogisticsService _logisticsService = locator<LogisticsService>();
  ActivityService _activityService = locator<ActivityService>();
  JourneyService _journeyService = locator<JourneyService>();
  AdhocCartService _adhocCartService = locator<AdhocCartService>();

  UserService _userService = locator<UserService>();
  NavigationService _navigationService = locator<NavigationService>();
  InitService _initService = locator<InitService>();
  AccessControlService _accessControlService = locator<AccessControlService>();

  final _versionService = locator<VersionService>();

  String get version => _versionService.version;

  HomeViewModel(int index) : _currentIndex = index;

  String get noOfUpdates => _activityService.noOfUpdates.toString();

  bool get showPendingStockTransactionsIconButton =>
      renderPendingStockTransactionsButton && currentIndex == 3;

  get enableJourneyTab => _accessControlService.enableJourneyTab;
  get enableHomeTab => _accessControlService.enableHomeTab;

  get enableAdhocTab => _accessControlService.enableAdhocView;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  DateTime get endDate => _endDate;
  DateTime get startDate => _startDate;

  setStartDate(DateTime dt) {
    _startDate = dt;
    notifyListeners();
  }

  setEndDate(DateTime dt) {
    _endDate = dt;
    notifyListeners();
  }

  refresh() async {
    setBusy(true);
    await _logisticsService.fetchJourneys();
    setBusy(false);
  }

  navigateToPasswordReset() async {
    await _navigationService.navigateTo(Routes.resetPasswordView);
  }

  navigateToChangePassword() async {
    await _navigationService.navigateTo(Routes.changePasswordView,
        arguments: ChangePasswordViewArguments(
            passwordChangeType: PasswordChangeType.user));
  }

  bool get hasActivityUpdate => _activityService.hasUpdate;

  DeliveryJourney get currentJourney => _logisticsService.currentJourney;

  bool get onTrip {
    if (hasJourney) {
      if (_logisticsService.currentJourney.journeyId != null) {
        return true;
      } else
        return false;
    } else {
      return false;
    }
  }

  AppEnv get appEnv => _initService.appEnv;

  User get user => _userService.user;

  logout() async {
    await _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }

  bool get hasJourney => _logisticsService.hasJourney;

  String _title = "Home";
  String get title => _title;

  Pages _pageToDisplay;
  Pages get pageToDisplay => _pageToDisplay;

  Widget _pageContent = DashboardView();
  Widget get pageContent => _pageContent;

  updatePageToDisplay(Pages page, String title) {
    _pageToDisplay = page;
    _title = title;
    _pageContent = buildPage();
    notifyListeners();
  }

  updateCurrentPage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  buildPage() {
    switch (_pageToDisplay) {
      case Pages.home:
        _pageContent = DashboardView();
        break;
      case Pages.adhoc:
        _pageContent = AdhocSalesView();
        break;
      case Pages.customers:
        _pageContent = CustomerView();
        break;
      case Pages.routes:
        _pageContent = RoutesListingView();
        break;
      case Pages.products:
        _pageContent = StockView();
        break;
      default:
        _pageContent = DashboardView();
        break;
    }
    return _pageContent;
  }

  bool get enableRouteTab => _accessControlService.enableJourneyTab;
  bool get enableProductTab => _accessControlService.enableStockTab;
  bool get enableCustomerTab => _accessControlService.enableCustomerTab;

  init() async {
    await _logisticsService.fetchJourneys();
    await _permissionService.init();
    //Check if the user has permissions before enabling this
    if (user.hasSalesChannel) {
      await fetchAdhocSales();
    }
    return;
  }

  void navigateToJourneyMapView() async {
    _navigationService.navigateTo(Routes.deliveryJourneyMapView,
        arguments:
            DeliveryJourneyMapViewArguments(deliveryJourney: currentJourney));
  }

  navigateToNotificationsView() async {
    _navigationService.navigateTo(Routes.notificationView);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_logisticsService, _journeyService, _activityService];

  navigateToHome(int index) {
    _navigationService.clearStackAndShow(Routes.homeView,
        arguments: HomeViewArguments(index: index));
  }

  int _currentIndex;
  int get currentIndex => _currentIndex;
  updateCurrentIndex(int val) {
    switch (val) {
      case 0: //Home
        // if(_accessControlService.enableJourneyTab){
        //   _currentIndex = val;
        //   notifyListeners();
        // }
        _currentIndex = val;
        notifyListeners();
        break;
      case 1: //Journey
        if (_accessControlService.enableJourneyTab) {
          _currentIndex = val;
          notifyListeners();
        }
        break;
      case 2: //Adhoc
        if (_accessControlService.enableAdhocView) {
          _currentIndex = val;
          notifyListeners();
        }
        break;
      case 3: // Stock Balance
        if (_accessControlService.enableStockTab) {
          _currentIndex = val;
          notifyListeners();
        }
        break;
      case 4: // Customers
        if (_accessControlService.enableCustomerTab) {
          _currentIndex = val;
          notifyListeners();
        }
        break;
    }
  }

  void navigateToAddAdhocSale() async {
    var result = await _navigationService.navigateTo(Routes.adhocSalesView);
    _startDate = DateTime.now();
    await fetchAdhocSales();
  }

  fetchAdhocSales({DateTime postingDate}) async {
    _adhocSalesList =
        await _adhocCartService.fetchAdhocSalesList(postingDate: postingDate);
    notifyListeners();
  }

  bool _sortAsc = true;
  bool get sortAsc => _sortAsc;
  toggleSortAsc() {
    _sortAsc = !_sortAsc;
    notifyListeners();
  }

  bool _hasFilter = false;
  bool get hasFilter => _hasFilter;
  toggleHasFilter() {
    _hasFilter = !_hasFilter;
    notifyListeners();
  }

  List<AdhocSale> _adhocSalesList = <AdhocSale>[];

  List<AdhocSale> _memento;
  List<AdhocSale> get memento => _memento;

  List<AdhocSale> get adhocSalesList {
    if (_adhocSalesList.isNotEmpty) {
      if (sortAsc) {
        _adhocSalesList.sort((a, b) {
          return b.transactionDate.compareTo(a.transactionDate);
        });
      } else {
        _adhocSalesList.sort((a, b) {
          return a.transactionDate.compareTo(b.transactionDate);
        });
      }
      _memento = _adhocSalesList;
      return _adhocSalesList;
    }
    return _adhocSalesList;
  }

  navigateToAdhocDetail(
      String referenceNo, String customerId, String baseType) async {
    var result = await _navigationService.navigateTo(
      Routes.adhocDetailView,
      arguments: AdhocDetailViewArguments(
          referenceNo: referenceNo, customerId: customerId, baseType: baseType),
    );
    _startDate = DateTime.now();
    await fetchAdhocSales();
  }

  commitDateSelection() async {
    await fetchAdhocSales(postingDate: startDate);
    _navigationService.popRepeated(1);
  }

  final formatter = DateFormat('yyyy-MM-dd');

  onStockBalancePopupSelected(value) {
    switch (value) {
      case 0:
        navigateToPendingTransactionsView();
        break;
      case 1:
        navigateToReturnStockView();
        break;
    }
  }
}
