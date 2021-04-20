import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/services/access_controller_service.dart';
import 'package:distributor/services/activity_service.dart';
import 'package:distributor/services/init_service.dart';
import 'package:distributor/services/journey_service.dart';

import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/permission_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:distributor/ui/views/adhoc_sales/adhoc_sales_view.dart';

import 'package:distributor/ui/views/customers/customer_view.dart';
import 'package:distributor/ui/views/dashboard/dashboard_view.dart';
import 'package:distributor/ui/views/routes/route_listing_view.dart';
import 'package:distributor/ui/views/stock/stock_view.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class HomeViewModel extends ReactiveViewModel {
  PermissionService _permissionService = locator<PermissionService>();
  LogisticsService _logisticsService = locator<LogisticsService>();
  ActivityService _activityService = locator<ActivityService>();
  JourneyService _journeyService = locator<JourneyService>();

  UserService _userService = locator<UserService>();
  NavigationService _navigationService = locator<NavigationService>();
  InitService _initService = locator<InitService>();
  AccessControlService _accessControlService = locator<AccessControlService>();

  HomeViewModel(int index) : _currentIndex = index;

  String get noOfUpdates => _activityService.noOfUpdates.toString();

  get enableJourneyTab => _accessControlService.enableJourneyTab;
  get enableHomeTab => _accessControlService.enableHomeTab;

  get enableAdhocTab => _accessControlService.enableAdhocView;

  refresh() async {
    setBusy(true);
    await _logisticsService.fetchJourneys();
    setBusy(false);
  }

  navigateToPasswordReset() async {
    await _navigationService.navigateTo(Routes.resetPasswordView);
  }

  navigateToChangePassword() async {
    await _navigationService.navigateTo(Routes.changePasswordView);
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
}
