import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

final freeTrialProductProvider = FutureProvider<ProductDetails?>((ref) async {
  final Set<String> productIds = <String>{
    'io.ideatestproject.mobile.1month3dayfreetrial',
  };

  final ProductDetailsResponse response =
      await InAppPurchase.instance.queryProductDetails(productIds);
  if (response.notFoundIDs.isNotEmpty) {
    return null;
  }

  return response.productDetails.first;
});
