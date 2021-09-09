import 'package:auto_route/auto_route_annotations.dart';
import 'package:distributor/src/ui/views/add_adhoc_sale/add_adhoc_sale_view.dart';
import 'package:distributor/src/ui/views/add_issue/add_issue_view.dart';
import 'package:distributor/src/ui/views/add_payment/add_payment_view.dart';
import 'package:distributor/src/ui/views/adhoc_cart_view/adhoc_cart_view.dart';
import 'package:distributor/src/ui/views/adhoc_payment/adhoc_payment_view.dart';
import 'package:distributor/src/ui/views/partial_delivery/partial_delivery_view.dart';
import 'package:distributor/src/ui/views/delivery_note/delivery_note_view.dart';
import 'package:distributor/src/ui/views/reset_password/reset_password_view.dart';
import 'package:distributor/src/ui/views/change_password/change_password.dart';
import 'package:distributor/src/ui/views/stock_transaction/stock_transaction_list_view.dart';
import 'package:distributor/src/ui/views/stock_transfer/stock_transfer_view.dart';
import 'package:distributor/src/ui/views/voucher_detail/voucher_detail_view.dart';
import 'package:distributor/ui/views/customer_location.dart';
import 'package:distributor/ui/views/customers/customer_detail/customer_detail_view.dart';

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

import '../ui/views/link_payment/link_payment_view.dart';
import '../ui/views/login/login_view.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: JourneyView),
    MaterialRoute(page: CustomerDetailView),
    MaterialRoute(page: CreateSalesOrderView),
    MaterialRoute(page: CustomerLocation),
    MaterialRoute(page: OrderDetailView),
    MaterialRoute(page: OrderConfirmation),
    MaterialRoute(page: DeliveryJourneyMapView),
    MaterialRoute(page: NotificationView),
    MaterialRoute(page: LinkPaymentView),
    MaterialRoute(page: PaymentReferenceView),
    MaterialRoute(page: AddPaymentView),
    MaterialRoute(page: PartialDeliveryView),
    MaterialRoute(page: AddIssueView),
    MaterialRoute(page: AdhocCartView),
    MaterialRoute(page: AddAdhocSaleView),
    MaterialRoute(page: StockTransactionListView),
    MaterialRoute(page: AdhocPaymentView),
    MaterialRoute(page: DeliveryNoteView),
    MaterialRoute(page: ResetPasswordView),
    MaterialRoute(page: ChangePasswordView),
    MaterialRoute(page: StockTransferView),
    MaterialRoute(page: VoucherDetailView)
  ],
)
class $Router {}

// @MaterialAutoRouter()
// class $Router {
//   @initial
//   StartupView startupViewRoute;
//   LoginView loginViewRoute;
//   HomeView homeViewRoute;
//   ForgotPasswordRoute forgotPasswordRoute;
//   JourneyView journeyViewRoute;
//   CustomerDetailView customerDetailViewRoute;
//   CreateSalesOrderView createSalesOrderViewRoute;
//   CustomerLocation customerLocationViewRoute;
//   OrderDetailView orderDetailViewRoute;
//   OrderConfirmation orderConfirmationRoute;
//   DeliveryJourneyMapView deliveryJourneyMapView;
//   NotificationView notificationViewRoute;
//   LinkPaymentView linkPaymentView;
//   PaymentReferenceView paymentReferenceView;
//   AddPaymentView addPaymentView;
//   PartialDeliveryView partialDeliveryView;
//   AddIssueView addIssueView;
//   AddAdhocSaleView adhocSaleView;
// }
