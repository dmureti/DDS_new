// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:distributor/ui/views/startup/startup_view.dart';
import 'package:distributor/ui/views/login/login_view.dart';
import 'package:distributor/ui/views/home/home_view.dart';
import 'package:distributor/ui/views/forgot_password/forgot_password_route.dart';
import 'package:distributor/ui/views/journey/journey_view.dart';
import 'package:distributor/ui/views/customers/customer_detail/customer_detail_view.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/ui/views/orders/create_order/create_sales_order_view.dart';
import 'package:distributor/ui/views/customer_location.dart';
import 'package:distributor/ui/views/orders/order_detail/order_detail_view.dart';
import 'package:distributor/ui/views/orders/order_confirmation/order_confirmation.dart';
import 'package:distributor/ui/widgets/smart_widgets/map_view/delivery_journey_map_view.dart';
import 'package:distributor/ui/views/notifications/notification_view.dart';
import 'package:distributor/ui/views/link_payment/link_payment_view.dart';
import 'package:distributor/core/models/payment_link.dart';
import 'package:distributor/ui/views/payment_reference/payment_reference_view.dart';
import 'package:distributor/src/ui/views/add_payment/add_payment_view.dart';
import 'package:distributor/src/ui/views/partial_delivery/partial_delivery_view.dart';
import 'package:distributor/src/ui/views/add_issue/add_issue_view.dart';
import 'package:distributor/src/ui/views/add_adhoc_sale/add_adhoc_sale_view.dart';

abstract class Routes {
  static const startupViewRoute = '/';
  static const loginViewRoute = '/login-view-route';
  static const homeViewRoute = '/home-view-route';
  static const forgotPasswordRoute = '/forgot-password-route';
  static const journeyViewRoute = '/journey-view-route';
  static const customerDetailViewRoute = '/customer-detail-view-route';
  static const createSalesOrderViewRoute = '/create-sales-order-view-route';
  static const customerLocationViewRoute = '/customer-location-view-route';
  static const orderDetailViewRoute = '/order-detail-view-route';
  static const orderConfirmationRoute = '/order-confirmation-route';
  static const deliveryJourneyMapView = '/delivery-journey-map-view';
  static const notificationViewRoute = '/notification-view-route';
  static const linkPaymentView = '/link-payment-view';
  static const paymentReferenceView = '/payment-reference-view';
  static const addPaymentView = '/add-payment-view';
  static const partialDeliveryView = '/partial-delivery-view';
  static const addIssueView = '/add-issue-view';
  static const adhocSaleView = '/adhoc-sale-view';
  static const all = {
    startupViewRoute,
    loginViewRoute,
    homeViewRoute,
    forgotPasswordRoute,
    journeyViewRoute,
    customerDetailViewRoute,
    createSalesOrderViewRoute,
    customerLocationViewRoute,
    orderDetailViewRoute,
    orderConfirmationRoute,
    deliveryJourneyMapView,
    notificationViewRoute,
    linkPaymentView,
    paymentReferenceView,
    addPaymentView,
    partialDeliveryView,
    addIssueView,
    adhocSaleView,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.startupViewRoute:
        if (hasInvalidArgs<StartupViewArguments>(args)) {
          return misTypedArgsRoute<StartupViewArguments>(args);
        }
        final typedArgs =
            args as StartupViewArguments ?? StartupViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => StartupView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.loginViewRoute:
        if (hasInvalidArgs<LoginViewArguments>(args)) {
          return misTypedArgsRoute<LoginViewArguments>(args);
        }
        final typedArgs = args as LoginViewArguments ?? LoginViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginView(
              key: typedArgs.key,
              email: typedArgs.email,
              password: typedArgs.password),
          settings: settings,
        );
      case Routes.homeViewRoute:
        if (hasInvalidArgs<HomeViewArguments>(args)) {
          return misTypedArgsRoute<HomeViewArguments>(args);
        }
        final typedArgs = args as HomeViewArguments ?? HomeViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              HomeView(key: typedArgs.key, index: typedArgs.index),
          settings: settings,
        );
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => ForgotPasswordRoute(),
          settings: settings,
        );
      case Routes.journeyViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => JourneyView(),
          settings: settings,
        );
      case Routes.customerDetailViewRoute:
        if (hasInvalidArgs<CustomerDetailViewArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<CustomerDetailViewArguments>(args);
        }
        final typedArgs = args as CustomerDetailViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => CustomerDetailView(
              customer: typedArgs.customer, key: typedArgs.key),
          settings: settings,
        );
      case Routes.createSalesOrderViewRoute:
        if (hasInvalidArgs<CreateSalesOrderViewArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<CreateSalesOrderViewArguments>(args);
        }
        final typedArgs = args as CreateSalesOrderViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => CreateSalesOrderView(
              customer: typedArgs.customer, key: typedArgs.key),
          settings: settings,
        );
      case Routes.customerLocationViewRoute:
        if (hasInvalidArgs<CustomerLocationArguments>(args)) {
          return misTypedArgsRoute<CustomerLocationArguments>(args);
        }
        final typedArgs =
            args as CustomerLocationArguments ?? CustomerLocationArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => CustomerLocation(customer: typedArgs.customer),
          settings: settings,
        );
      case Routes.orderDetailViewRoute:
        if (hasInvalidArgs<OrderDetailViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<OrderDetailViewArguments>(args);
        }
        final typedArgs = args as OrderDetailViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => OrderDetailView(
              salesOrder: typedArgs.salesOrder,
              deliveryJourney: typedArgs.deliveryJourney,
              stopId: typedArgs.stopId,
              key: typedArgs.key),
          settings: settings,
        );
      case Routes.orderConfirmationRoute:
        if (hasInvalidArgs<OrderConfirmationArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<OrderConfirmationArguments>(args);
        }
        final typedArgs = args as OrderConfirmationArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => OrderConfirmation(
              salesOrderRequest: typedArgs.salesOrderRequest,
              customer: typedArgs.customer,
              key: typedArgs.key),
          settings: settings,
        );
      case Routes.deliveryJourneyMapView:
        if (hasInvalidArgs<DeliveryJourneyMapViewArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<DeliveryJourneyMapViewArguments>(args);
        }
        final typedArgs = args as DeliveryJourneyMapViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => DeliveryJourneyMapView(
              deliveryJourney: typedArgs.deliveryJourney, key: typedArgs.key),
          settings: settings,
        );
      case Routes.notificationViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => NotificationView(),
          settings: settings,
        );
      case Routes.linkPaymentView:
        if (hasInvalidArgs<LinkPaymentViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<LinkPaymentViewArguments>(args);
        }
        final typedArgs = args as LinkPaymentViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => LinkPaymentView(
              customer: typedArgs.customer,
              paymentLink: typedArgs.paymentLink,
              key: typedArgs.key),
          settings: settings,
        );
      case Routes.paymentReferenceView:
        if (hasInvalidArgs<PaymentReferenceViewArguments>(args,
            isRequired: true)) {
          return misTypedArgsRoute<PaymentReferenceViewArguments>(args);
        }
        final typedArgs = args as PaymentReferenceViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => PaymentReferenceView(
              customer: typedArgs.customer, key: typedArgs.key),
          settings: settings,
        );
      case Routes.addPaymentView:
        if (hasInvalidArgs<AddPaymentViewArguments>(args)) {
          return misTypedArgsRoute<AddPaymentViewArguments>(args);
        }
        final typedArgs =
            args as AddPaymentViewArguments ?? AddPaymentViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              AddPaymentView(key: typedArgs.key, customer: typedArgs.customer),
          settings: settings,
        );
      case Routes.partialDeliveryView:
        if (hasInvalidArgs<PartialDeliveryViewArguments>(args)) {
          return misTypedArgsRoute<PartialDeliveryViewArguments>(args);
        }
        final typedArgs = args as PartialDeliveryViewArguments ??
            PartialDeliveryViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => PartialDeliveryView(
              key: typedArgs.key,
              salesOrder: typedArgs.salesOrder,
              deliveryJourney: typedArgs.deliveryJourney,
              stopId: typedArgs.stopId),
          settings: settings,
        );
      case Routes.addIssueView:
        if (hasInvalidArgs<AddIssueViewArguments>(args)) {
          return misTypedArgsRoute<AddIssueViewArguments>(args);
        }
        final typedArgs =
            args as AddIssueViewArguments ?? AddIssueViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              AddIssueView(key: typedArgs.key, customer: typedArgs.customer),
          settings: settings,
        );
      case Routes.adhocSaleView:
        if (hasInvalidArgs<AddAdhocSaleViewArguments>(args)) {
          return misTypedArgsRoute<AddAdhocSaleViewArguments>(args);
        }
        final typedArgs =
            args as AddAdhocSaleViewArguments ?? AddAdhocSaleViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddAdhocSaleView(
              key: typedArgs.key, customer: typedArgs.customer),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//StartupView arguments holder class
class StartupViewArguments {
  final Key key;
  StartupViewArguments({this.key});
}

//LoginView arguments holder class
class LoginViewArguments {
  final Key key;
  final String email;
  final String password;
  LoginViewArguments({this.key, this.email, this.password});
}

//HomeView arguments holder class
class HomeViewArguments {
  final Key key;
  final int index;
  HomeViewArguments({this.key, this.index});
}

//CustomerDetailView arguments holder class
class CustomerDetailViewArguments {
  final Customer customer;
  final Key key;
  CustomerDetailViewArguments({@required this.customer, this.key});
}

//CreateSalesOrderView arguments holder class
class CreateSalesOrderViewArguments {
  final Customer customer;
  final Key key;
  CreateSalesOrderViewArguments({@required this.customer, this.key});
}

//CustomerLocation arguments holder class
class CustomerLocationArguments {
  final Customer customer;
  CustomerLocationArguments({this.customer});
}

//OrderDetailView arguments holder class
class OrderDetailViewArguments {
  final SalesOrder salesOrder;
  final DeliveryJourney deliveryJourney;
  final String stopId;
  final Key key;
  OrderDetailViewArguments(
      {this.salesOrder,
      @required this.deliveryJourney,
      @required this.stopId,
      this.key});
}

//OrderConfirmation arguments holder class
class OrderConfirmationArguments {
  final SalesOrderRequest salesOrderRequest;
  final Customer customer;
  final Key key;
  OrderConfirmationArguments(
      {@required this.salesOrderRequest, @required this.customer, this.key});
}

//DeliveryJourneyMapView arguments holder class
class DeliveryJourneyMapViewArguments {
  final DeliveryJourney deliveryJourney;
  final Key key;
  DeliveryJourneyMapViewArguments({@required this.deliveryJourney, this.key});
}

//LinkPaymentView arguments holder class
class LinkPaymentViewArguments {
  final Customer customer;
  final PaymentLink paymentLink;
  final Key key;
  LinkPaymentViewArguments(
      {@required this.customer, @required this.paymentLink, this.key});
}

//PaymentReferenceView arguments holder class
class PaymentReferenceViewArguments {
  final Customer customer;
  final Key key;
  PaymentReferenceViewArguments({@required this.customer, this.key});
}

//AddPaymentView arguments holder class
class AddPaymentViewArguments {
  final Key key;
  final Customer customer;
  AddPaymentViewArguments({this.key, this.customer});
}

//PartialDeliveryView arguments holder class
class PartialDeliveryViewArguments {
  final Key key;
  final SalesOrder salesOrder;
  final DeliveryJourney deliveryJourney;
  final String stopId;
  PartialDeliveryViewArguments(
      {this.key, this.salesOrder, this.deliveryJourney, this.stopId});
}

//AddIssueView arguments holder class
class AddIssueViewArguments {
  final Key key;
  final Customer customer;
  AddIssueViewArguments({this.key, this.customer});
}

//AddAdhocSaleView arguments holder class
class AddAdhocSaleViewArguments {
  final Key key;
  final Customer customer;
  AddAdhocSaleViewArguments({this.key, this.customer});
}
