import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_payment/consts.dart';

class StripeService {
  // Private Constructor
  StripeService._();
  // we can use this 'instance' to interact with our stripe service
  static final StripeService instance = StripeService._();

  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(10, "usd");
      // if null, exit out of function
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Shahzain Ahmed",
        ),
      );
      await _processPayment();
    } catch (e) {
      debugPrint("Payment error $e from makePayment()");
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio(); // Dio instance
      Map<String, dynamic> data = {
        // amount would be specified in cents, means if you want to charge $10, you should pass 1000 (100 cents is 1 dollar)
        'amount': _calculateAmount(amount),
        'currency': currency,
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.data != null) {
        debugPrint("Response from _createPaymentIntent() ${response.data}");
        return response.data['client_secret'];
      }
      return null;
    } catch (e) {
      debugPrint("Payment error $e from _createPaymentIntent()");
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      debugPrint("Payment successful");
    } catch (e) {
      debugPrint("Payment error $e from _processPayment()");
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
