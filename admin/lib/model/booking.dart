class BookingModel {
  String userName;
  String address;
  String id;
  String expectedDate;
  String paid;
  String status;
  String expectedTime;
  BookingModel(
      {required this.address,
      required this.expectedDate,
      required this.expectedTime,
      required this.id,
      required this.paid,
      required this.status,
      required this.userName});
}
