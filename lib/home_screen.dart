import 'package:flutter/material.dart';
import 'package:stripe_payment/services/stripe_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stripe Payment Demo"),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                StripeService.instance.makePayment();
              },
              child: Text('Purchase'),
            ),
          ],
        ),
      ),
    );
  }
}
