import 'package:auto_route/auto_route_annotations.dart';
import 'package:distributor/src/ui/views/add_adhoc_sale/add_adhoc_sale_view.dart';
import 'package:distributor/src/ui/views/add_issue/add_issue_view.dart';
import 'package:distributor/src/ui/views/add_payment/add_payment_view.dart';
import 'package:distributor/src/ui/views/partial_delivery/partial_delivery_view.dart';
import 'package:distributor/ui/views/customer_location.dart';
import 'package:distributor/ui/views/customers/customer_detail/customer_detail_view.dart';
import 'package:distributor/ui/views/forgot_password/forgot_password_route.dart';
import 'package:distributor/ui/views/home/home_view.dart';
import 'package:distributor/ui/views/journey/journey_view.dart';
import 'package:distributor/ui/views/link_payment/link_payment_view.dart';

import 'package:distributor/ui/views/login/login_view.dart';
import 'package:distributor/ui/views/notifications/notification_view.dart';
import 'package:distributor/ui/views/orders/create_order/create_sales_order_view.dart';
import 'package:distributor/ui/views/orders/order_confirmation/order_confirmation.dart';
import 'package:distributor/ui/views/orders/order_detail/order_detail_view.dart';
import 'package:distributor/ui/views/payment_reference/payment_reference_view.dart';
import 'package:distributor/ui/views/startup/startup_view.dart';
import 'package:distributor/ui/widgets/smart_widgets/map_view/delivery_journey_map_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  StartupView startupViewRoute;
  LoginView loginViewRoute;
  HomeView homeViewRoute;
  ForgotPasswordRoute forgotPasswordRoute;
  JourneyView journeyViewRoute;
  CustomerDetailView customerDetailViewRoute;
  CreateSalesOrderView createSalesOrderViewRoute;
  CustomerLocation customerLocationViewRoute;
  OrderDetailView orderDetailViewRoute;
  OrderConfirmation orderConfirmationRoute;
  DeliveryJourneyMapView deliveryJourneyMapView;
  NotificationView notificationViewRoute;
  LinkPaymentView linkPaymentView;
  PaymentReferenceView paymentReferenceView;
  AddPaymentView addPaymentView;
  PartialDeliveryView partialDeliveryView;
  AddIssueView addIssueView;
  AddAdhocSaleView adhocSaleView;
}
