class Customer {
  final String id;
  final String name;
  final String telephone;
  final String idType;
  final String idNumber;
  final String branch;
  final String route;
  final String area;
  final String category;
  final String gpsLocation;
  final String customerType;
  final String marketSegment;
  final String customerStatus;
  final String defaultPriceList;
  final String customerGroup;
  final String customerCode;
  final double creditLimit;
  final String termsOfPayment;
  final String paymentMode;

  Customer({
    this.creditLimit,
    this.termsOfPayment,
    this.paymentMode,
    this.customerCode,
    this.name,
    this.idNumber,
    this.id,
    this.customerGroup,
    this.telephone,
    this.idType,
    this.branch,
    this.customerType,
    this.route,
    this.area,
    this.category,
    this.defaultPriceList,
    this.gpsLocation,
    this.marketSegment,
    this.customerStatus,
  });

  Customer.fromJson(Map<String, dynamic> parsedjson)
      : id = parsedjson['id'],
        name = parsedjson['name'].toString() ?? '',
        telephone = parsedjson['telephone'] ?? '',
        idNumber = parsedjson['idNumber'] ?? '',
        idType = parsedjson['idType'] ?? '',
        branch = parsedjson['branch'] ?? '',
        route = parsedjson['route'] ?? '',
        area = parsedjson['area'] ?? '',
        creditLimit = parsedjson['creditLimit'] ?? 00.0,
        termsOfPayment = parsedjson['termsOfPayment'] ?? '',
        paymentMode = parsedjson['paymentMode'] ?? '',
        customerCode = parsedjson['customerCode'] ?? '',
        customerType = parsedjson['customerType'] ?? '',
        customerGroup = parsedjson['customerGroup'] ?? '',
        category = parsedjson['category'] ?? '',
        gpsLocation = parsedjson['gpsLocation'] ?? '',
        marketSegment = parsedjson['marketSegment'] ?? '',
        defaultPriceList = parsedjson['defaultPriceList'] ?? '',
        customerStatus = parsedjson['customerStatus'] ?? '';

  Customer.initial()
      : id = "",
        name = "",
        creditLimit = 0.0,
        termsOfPayment = "",
        paymentMode = "",
        customerType = "",
        telephone = "",
        idType = "",
        idNumber = "",
        branch = "",
        route = "",
        area = "",
        category = "",
        gpsLocation = "",
        marketSegment = "",
        defaultPriceList = "",
        customerCode = "",
        customerGroup = "",
        customerStatus = "";

//  Customer.toJson();
}
