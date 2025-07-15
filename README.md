# Stripe Payment Integration in Flutter

### PaymentIntent: 
In Stripe, a PaymentIntent is an object that represents the entire process of collecting a payment from a customer from start to finish.

It defines the amount, currency, and the allowed payment methods such as cards, Apple Pay, or Google Pay.

Once the PaymentIntent is created on the backend, it is sent to the Flutter client app. The client then uses this intent to build a payment UI, allowing the user to enter their payment details.

The payment submitted by the user is linked directly to the PaymentIntent created earlier. This connection ensures the payment is tracked and processed correctly.
