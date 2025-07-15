# Stripe Payment Integration in Flutter

### PaymentIntent: 
In Stripe, a PaymentIntent is an object that represents the entire process of collecting a payment from a customer from start to finish.

It defines the amount, currency, and the allowed payment methods such as cards, Apple Pay, or Google Pay.

Once the PaymentIntent is created on the backend, it is sent to the Flutter client app. The client then uses this intent to build a payment UI, allowing the user to enter their payment details.

The payment submitted by the user is linked directly to the PaymentIntent created earlier. This connection ensures the payment is tracked and processed correctly.

### Creating the PaymentIntent on the Server

The first step in the Stripe payment flow is to **create a PaymentIntent**, and this must always be done **on your own backend server**, not in the Flutter (frontend) app.

This is critical because your **Stripe Secret Key** is a sensitive credential and must **never be exposed to the client side**. If someone gains access to this key, they can perform unauthorized charges or misuse your Stripe account.

In an ideal setup:

1. Your Flutter app sends a request to your backend (Node.js, Python, Firebase Cloud Function, etc.).
2. The backend securely uses the **Stripe Secret Key** to create a PaymentIntent via Stripe's API.
3. The backend returns the `client_secret` of the PaymentIntent to the Flutter app.
4. The Flutter app then uses this `client_secret` to complete the payment process through the Stripe SDK.

By doing this, you ensure that:
- The user never sees your Stripe secret key.
- The creation logic is fully controlled and secure.
- You can also perform validations or attach metadata before creating the intent.

This server-side step is the **foundation** of a secure Stripe payment system and must always come before any client-side integration.
