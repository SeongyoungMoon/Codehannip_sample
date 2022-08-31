import 'dart:async';
import 'dart:io';
import 'package:code_hannip/providers/auth_provider.dart';
import 'package:code_hannip/services/firestore_path.dart';
import 'package:code_hannip/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_app_purchase/in_app_purchase.dart';


class ProviderModel with ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;
  bool available = true;
  StreamSubscription subscription;
  final String monthly_product = 'sub_test1';// todo: if apple: 'monthly_payment';
  //final String yearly_product = 'sub_test2';

  static DateTime _wadizStart;
  static DateTime _wadizEnd;
  static bool _isPurchased = false;
  static bool _isWadiz = false;

  bool get isPurchased => _isPurchased;
  bool get isWadiz => _isWadiz;
  DateTime get wadizStart => _wadizStart;
  DateTime get wadizEnd => _wadizEnd;

  set wadizStart(DateTime value) {
    _wadizStart = value;
    notifyListeners();
  }

  set wadizEnd(DateTime value) {
    _wadizEnd = value;
    notifyListeners();
  }

  set isPurchased(bool value) {
    _isPurchased = value;
    notifyListeners();
  }

  set isWadiz(bool value) {
    _isWadiz = value;
    notifyListeners();
  }

  List _purchases = [];
  List get purchases => _purchases;
  set purchases(List value) {
    _purchases = value;
    notifyListeners();
  }


  List _products = [];
  List get products => _products;
  set products(List value) {
    _products = value;
    notifyListeners();
  }

  void initialize() async {
    available = await _iap.isAvailable();
    if (available) {
      await _getProducts();
      //await _getProducts2();
      await _getPastPurchases();
      verifyPurchase();
      //verifyPurchase_yearly();
      subscription = _iap.purchaseUpdatedStream.listen((data) {
        purchases.addAll(data);
        verifyPurchase();
        //verifyPurchase_yearly();
      });
    }
  }

  void wadiz(bool purchased) {
    isPurchased = purchased;
    isWadiz = purchased;
  }

  static void wadizStatic(bool purchased) {
    _isPurchased = purchased;
    _isWadiz = purchased;
  }

  static void wadizStartSet(DateTime register) {
    _wadizStart = register;
  }

  static void wadizEndSet(DateTime until) {
    _wadizEnd = until;
  }

  static bool isWadizzz(){
    return _isWadiz;
  }

  void wadizStartSetInstance(DateTime register) {
    wadizStart = register;
  }

  void wadizEndSetInstance(DateTime until) {
    wadizEnd = until;
  }

  Future<DateTime> getWadizEnd(String email) async {
    var wadizEnd = DateTime.now();

    await _firestoreService.getData(path: FirestorePath.wadiz(email)).then((value) =>
    wadizEnd = value.data()['until'].toDate()
    );

    return wadizEnd;
  }

  Future<DateTime> getWadizStart(String email) async {
    var wadizStart = DateTime.now();

    await _firestoreService.getData(path: FirestorePath.wadiz(email)).then((value) =>
    wadizStart = value.data()['register'].toDate()
    );

    return wadizStart;
  }

  Future<void> verifyPurchase() async {
    if(!isWadiz){
      PurchaseDetails purchase = hasPurchased(monthly_product);

      if (purchase != null && purchase.status == PurchaseStatus.purchased) {

        if (purchase.pendingCompletePurchase) {
          await _iap.completePurchase(purchase);

          if (purchase != null && purchase.status == PurchaseStatus.purchased) {
            isPurchased = true;
          }
        }

      }
    }
  }

  /*void verifyPurchase_yearly() {
    PurchaseDetails purchase = hasPurchased(yearly_product);

    if (purchase != null && purchase.status == PurchaseStatus.purchased) {

      if (purchase.pendingCompletePurchase) {
        _iap.completePurchase(purchase);

        if (purchase != null && purchase.status == PurchaseStatus.purchased) {
          isPurchased = true;
        }
      }

    }
  }*/

  PurchaseDetails hasPurchased(String productID) {
    return purchases
        .firstWhere((purchase) => purchase.productID == productID, orElse: () => null);
  }

  Future<void> _getProducts() async {
    Set<String> ids = Set.from([monthly_product]);
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);
    products = response.productDetails;
  }

  /*Future<void> _getProducts2() async {
    Set<String> ids = Set.from([yearly_product]);
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);
    products = response.productDetails;
  }*/


  Future<void> _getPastPurchases() async {
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();
    for (PurchaseDetails purchase in response.pastPurchases) {
      if (Platform.isIOS) {
        _iap.consumePurchase(purchase);
      }
    } purchases = response.pastPurchases;

  }



}