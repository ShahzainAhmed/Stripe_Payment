# Stripe Payment Integration in Flutter

## Overview

This guide demonstrates how to integrate Stripe payments within a Flutter application using the official `flutter_stripe` package. It covers the correct approach of creating a PaymentIntent on the backend, as well as a temporary frontend-based flow for learning purposes.

---

## What is a PaymentIntent?

In Stripe, a `PaymentIntent` is an object that represents the entire process of collecting a payment from a customer.

It defines:
- The amount to be charged
- The currency
- Supported payment methods (e.g., credit/debit cards, Apple Pay, Google Pay)

After a PaymentIntent is created on the backend, its `client_secret` is sent to the frontend (Flutter) app. The client then uses this to display a payment sheet, allowing the user to securely enter their payment details.

---

## Creating the PaymentIntent on the Server (Recommended Approach)

Creating the PaymentIntent must **always be done on a secure backend**, not on the frontend. This is to ensure your **Stripe Secret Key** is never exposed.

### Recommended Flow

1. The Flutter app sends a request to your backend (Node.js, Python, Firebase, etc.).
2. The backend uses the **Stripe Secret Key** to create a PaymentIntent via Stripe’s API.
3. The backend returns the `client_secret` of the PaymentIntent.
4. The Flutter app uses this `client_secret` to initialize and present the Stripe Payment Sheet.

### Why This Is Important

- Keeps your secret keys secure.
- Prevents unauthorized access or fraudulent use.
- Allows you to perform additional validation or logic before creating the intent.

---

## Warning: Avoid Creating PaymentIntents on the Client Side

Creating a PaymentIntent directly in Flutter (client side) is **not secure** and must **never** be done in production.

For this tutorial only, the logic is shown in Flutter **for learning purposes**.

---

## Recommended Backend Setup with Firebase (or Any Server)

If you are using Firebase or any backend:

1. Create a secure **Cloud Function**.
2. Use the Stripe Secret Key inside the function to create the PaymentIntent.
3. Call this function from Flutter.
4. Receive the `client_secret` in the response.
5. Use it with the Stripe SDK to complete the payment.

This approach protects your credentials and keeps payment logic safe.

---

## Temporary Client-Side Setup (For Learning Only)

In this example tutorial:

- A function named `createPaymentIntent` is defined in Flutter.
- It accepts:
  - `amount`: The amount to charge (e.g., "10" for $10).
  - `currency`: The currency code (e.g., "usd").
- The function:
  - Multiplies the amount by 100 (Stripe expects smallest currency units).
  - Sends a POST request using the `dio` package to `https://api.stripe.com/v1/payment_intents`.
  - Includes headers such as the **Authorization** header with your **Secret Key**.

> This approach is only for sandbox/testing use. Do not use it in production.

---

## Using Dio for HTTP Requests

- Add `dio` to your `pubspec.yaml`.
- Configure the request with:
  - `Content-Type: application/x-www-form-urlencoded`
  - `Authorization: Bearer YOUR_SECRET_KEY`
- Send the required parameters (`amount`, `currency`) in the request body.
- Parse the response and retrieve the `client_secret`.

---

## Important: Amount Formatting

Stripe expects the amount in **smallest currency units**:

- $10 → `1000`
- €5 → `500`
- ₹150 → `15000`

Create a helper function to convert the amount accordingly.

---

## Initializing the Stripe Payment Sheet

Once you have the `client_secret`:

1. Call `Stripe.instance.initPaymentSheet` with the `client_secret` and merchant name.
2. This prepares the Stripe UI for payment.

You may also configure additional parameters such as:
- Apple Pay / Google Pay
- Appearance and theme
- Delayed payment methods

---

## Presenting the Payment Sheet

To allow the user to complete payment:

- Call `Stripe.instance.presentPaymentSheet()`.
- Stripe will handle card validation and errors.
- If the user cancels or provides invalid details, Stripe will throw a `StripeException`.

---

## Testing Stripe Payments

Use test data in sandbox mode:

- Card Number: `4242 4242 4242 4242`
- Expiry: Any future date (e.g., 12/27)
- CVC: Any 3-digit number
- ZIP: Any 5-digit number

Monitor test transactions in the [Stripe Dashboard](https://dashboard.stripe.com/test/dashboard).

---
