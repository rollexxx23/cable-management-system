import 'dart:convert';

class Order {
  final String paid;
  final String expectedDate;
  final String status;
  final String total;
  final String extraCharges;
  final String expectedTime;
  final String paymentMode;
  final String id;
  String? address;
  String? pincode;
  String? city;
  String? name;
  String? email;
  String? deliveryPerson;
  String? deliveryPersonEmail;

  List<Items> items;
  Order({
    required this.paid,
    required this.id,
    required this.expectedDate,
    required this.status,
    required this.total,
    required this.extraCharges,
    required this.expectedTime,
    this.deliveryPerson,
    this.deliveryPersonEmail,
    this.address,
    this.city,
    this.pincode,
    this.name,
    this.email,
    this.items = const [],
    required this.paymentMode,
  });

  @override
  String toString() {
    return 'Order(paid: $paid, expectedDate: $expectedDate, status: $status, total: $total, extraCharges: $extraCharges, expectedTime: $expectedTime, paymentMode: $paymentMode, )';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.paid == paid &&
        other.expectedDate == expectedDate &&
        other.status == status &&
        other.total == total &&
        other.extraCharges == extraCharges &&
        other.expectedTime == expectedTime &&
        other.paymentMode == paymentMode;
  }

  @override
  int get hashCode {
    return paid.hashCode ^
        expectedDate.hashCode ^
        status.hashCode ^
        total.hashCode ^
        extraCharges.hashCode ^
        expectedTime.hashCode ^
        paymentMode.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paid': paid,
      'expectedDate': expectedDate,
      'status': status,
      'total': total,
      'extraCharges': extraCharges,
      'expectedTime': expectedTime,
      'paymentMode': paymentMode,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map["id"] as String,
      paid: map['paid'] as String,
      expectedDate: map['expectedDate'] as String,
      status: map['status'] as String,
      total: map['total'] as String,
      extraCharges: map['extraCharges'] as String,
      expectedTime: map['expectedTime'] as String,
      paymentMode: map['paymentMode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Items {
  String name;
  String quantity;
  String url;

  Items({required this.url, required this.name, required this.quantity});
}
