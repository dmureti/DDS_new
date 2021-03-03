// Will provide permission info to the respective services
import 'package:distributor/app/locator.dart';
import 'package:distributor/services/user_service.dart';

import 'package:tripletriocore/tripletriocore.dart';

class AccessControlService {
  UserService _userService = locator<UserService>();
  User get user => _userService.user;

  List<Authority> get authList => user.authorities;

  enableSignIn() {}
  bool get enableHomeTab {
    bool result = false;
    Authority authManageState = Authority(auth: 'DJ.CTRL');
    Authority authViewJourneyInfo = Authority(auth: 'DJ.VU');

    bool res1 = checkIfAuthExists(authList, authManageState);
    bool res2 = checkIfAuthExists(authList, authViewJourneyInfo);
    if (res1 || res2) {
      result = true;
    }
    return result;
  }

  bool checkIfAuthExists(List<Authority> authList, Authority authority) {
    bool result = false;
    authList.forEach((auth) {
      if (auth.auth == authority.auth) {
        result = true;
      }
    });
    return result;
  }

  // Listing Delivery Journeys
  // Required permissions delivery_journey.control" || "delivery_journey.view
  // Success : Return list of journeys
  // Default : View Display No journey assigned screen
  bool get enableJourneyTab {
    bool result = false;
    Authority authManageState = Authority(auth: 'DJ.CTRL');
    Authority authViewJourneyInfo = Authority(auth: 'DJ.VU');

    bool res1 = checkIfAuthExists(authList, authManageState);
    bool res2 = checkIfAuthExists(authList, authViewJourneyInfo);
    if (res1 || res2) {
      result = true;
    }
    return result;
  }

  // Show the delivery dashboard
  // Required permissions delivery_journey.control" || "delivery_journey.view
  // Success : Display delivery dashboard. Activate controls
  // Default : Display No journey assigned screen
  bool get enableDeliveryDashboard {
    Authority _authDeliveryJourneyControl =
        Authority(auth: 'delivery_journey.control');
    Authority _authDeliveryJourneyView =
        Authority(auth: 'delivery_journey.view');
    bool result = false;
    if (checkIfAuthExists(authList, _authDeliveryJourneyControl) ||
        (checkIfAuthExists(authList, _authDeliveryJourneyView))) {
      result = true;
    }
    return result;
  }

  /// Changing journey state
  /// Starting a journey
  /// Ending a journey
  /// Requires delivery_journey.control
  /// Success : Enable controls
  /// Default : Disable controls
  bool get enableJourneyControls {
    Authority _authDeliveryJourneyControl = Authority(auth: 'DN.INP');
    Authority _authDeliveryJourneyControl1 = Authority(auth: 'DN.AUTH');
    bool result = checkIfAuthExists(authList, _authDeliveryJourneyControl) ||
        checkIfAuthExists(authList, _authDeliveryJourneyControl1);
    return result;
  }

  /// Select delivery journey
  /// Requires delivery_journey.view
  /// Success : View the journey info.
  /// Default : Display no journey screen
  bool get viewJourneyInfo {
    bool result = checkIfAuthExists(authList, Authority(auth: 'SO.VU'));
    return result;
  }

  /// Stock balance tab enabled
  /// Requires virtual_stock_balance.view
  /// Success : Enable Tab, Navigate to stock balance, Fetch Stock balance
  /// Default : Disable stock balance tab
  bool get enableStockTab {
    Authority authViewStock = Authority(auth: 'VSB.VU');
    bool result = checkIfAuthExists(authList, authViewStock);
    return result;
  }

  /// Display Value of stock
  /// Requires virtual_stock_balance.view_cog
  /// Success : View value of stock
  /// Default : Hide the column
  bool get displayValueOfStockColumn {
    bool result = checkIfAuthExists(
        authList, Authority(auth: 'virtual_stock_balance.view_cog'));
    return result;
  }

  /// Enable customers tab
  /// Requires customer_static.view || customer_financial.view
  /// Success : Enable Tab, Navigate to Customers tab, Fetch customer data
  /// Default : Disable customers tab
  bool get enableCustomerTab {
    Authority authCustomerFinancial = Authority(auth: 'CUS.VU');
    Authority authCustomerStaticView = Authority(auth: 'CUF.VU');
    Authority authCustomerCUAVU = Authority(auth: 'CUA.VU');
    Authority authCustomerCUIVU = Authority(auth: 'CUI.VU');
    Authority authCustomerSOVU = Authority(auth: 'SO.VU');
    bool result = false;
    bool res1 = checkIfAuthExists(authList, authCustomerFinancial);
    bool res2 = checkIfAuthExists(authList, authCustomerStaticView);
    bool res3 = checkIfAuthExists(authList, authCustomerCUAVU);
    bool res4 = checkIfAuthExists(authList, authCustomerCUIVU);
    bool res5 = checkIfAuthExists(authList, authCustomerSOVU);
    if (res1 || res2 || res3 || res4 || res5) {
      result = true;
    }
    return result;
  }

  /// Enable orders tab
  /// Requires sales_order.view
  /// Success : Enable Tab, Navigate to tab, Fetch Orders
  /// Default : Disable tab
  bool get enableOrdersTab {
    bool result = checkIfAuthExists(authList, Authority(auth: 'SO.VU'));
    return result;
  }

  /// Enable place order button
  /// Requires sales_order.input || sales_order.create
  /// Success : Navigate to place sales order
  /// Default : Disable button
  bool enablePlaceOrderButton() {
    Authority authSalesOrderInput = Authority(auth: 'SO.INP');
    // Authority authSalesOrderCreate = Authority(auth: 'sales_order.create');
    bool result = false;
    bool res1 = checkIfAuthExists(authList, authSalesOrderInput);
    // bool res2 = checkIfAuthExists(authList, authSalesOrderCreate);
    if (res1) {
      result = true;
    }
    return result;
  }

  /// Enable Accounts tab
  /// Requires customer_account.view
  /// Success : Enable Tab, Navigate to Tab, Fetch Accounts
  /// Default : Disable button
  bool enableAccountsTab() {
    Authority authCustomerAccountView = Authority(auth: 'CUA.VU');
    bool result = checkIfAuthExists(authList, authCustomerAccountView);
    return result;
  }

  bool enableIssuesTab() {
    Authority authCustomerAccountView = Authority(auth: ' CUI.VU');
    bool result = checkIfAuthExists(authList, authCustomerAccountView);
    return result;
  }

  bool enableInfoTab() {
    Authority authCustomerAccountView = Authority(auth: 'CUS.VU');
    Authority authCustomerAccountView1 = Authority(auth: 'CUF.VU');
    bool result1 = checkIfAuthExists(authList, authCustomerAccountView);
    bool result2 = checkIfAuthExists(authList, authCustomerAccountView1);
    if (result2 || result1) {
      return true;
    } else {
      return false;
    }
  }

  bool get enableAdhocView {
    bool result = false;
    Authority adhocSale = Authority(auth: 'SIAS.INP');
    result = checkIfAuthExists(authList, adhocSale);
    return result;
  }
}
