import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayHandler {
  late Razorpay _razorpay;

  RazorpayHandler() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  void openCheckout() async {
    Future<String> generateOrderId(
        String key, String secret, int amount) async {
      var authn = 'Basic ' + base64Encode(utf8.encode('$key:$secret'));

      var headers = {
        'content-type': 'application/json',
        'Authorization': authn,
      };

      var data =
          '{ "amount": $amount, "currency": "INR", "receipt": "receipt#R1", "payment_capture": 1 }';
      print(data);
      var res = await http.post(Uri.parse('https://api.razorpay.com/v1/orders'),
          headers: headers, body: data);
      if (res.statusCode != 200)
        throw Exception('http.post error: statusCode= ${res.statusCode}');
      print('ORDER ID response => ${res.body}');

      return json.decode(res.body)['id'].toString();
    }

    var orderID = await generateOrderId("rzp_test_HKU93yR7awz0KJ",
        "DVgsdW3iTZG9uV1utezZPT0e", (((100).round())) + 50 * 100);
    print(orderID);
    var options = {
      "key": "rzp_test_HKU93yR7awz0KJ",
      'amount': ((((100).round()) * 1) + 50) *
          100, //in the smallest currency sub-unit.
      'name': 'CMS Pvt Ltd',
      'order_id': orderID, // Generate order_id using Orders API
      'description': "txtId",

      'prefill': {'contact': '', 'email': ''}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }
}
