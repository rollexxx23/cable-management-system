import 'dart:convert';
import 'package:admin/controller/api/auth_service.dart';
import 'package:admin/model/booking.dart';
import 'package:admin/views/widgets/user_registration.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:admin/utils/extension.dart';

import 'package:flutter/material.dart';

import '../../model/order.dart';

int i = 0;

class OrderTable extends StatelessWidget {
  const OrderTable({required this.Orders, Key? key}) : super(key: key);

  final List<BookingModel> Orders;

  DataRow getOrderRow(BookingModel Order, int idx, BuildContext context) {
    return DataRow(
        color: MaterialStateColor.resolveWith(
          (states) {
            if (idx % 2 == 0) {
              return Colors.white;
            } else {
              return const Color(0xffF8FAFC);
            }
          },
        ),
        cells: [
          DataCell(
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFD5DFF6),
                    child: Image.network(
                        "https://media.istockphoto.com/vectors/shopping-cart-icon-silhouette-2-vector-id898295684?k=20&m=898295684&s=612x612&w=0&h=-RzhG6vXhzP5RL5j51aEdlyquc6tSnSk-2-h3_ynz1E=",
                        height: 25,
                        width: 25),
                  ),
                  SizedBox(
                    width: 11.bigScale,
                  ),
                  Center(
                    child: Text(Order.id),
                  ),
                ],
              ),
            ),
          ),
          DataCell(
            Text(Order.paid),
          ),
          DataCell(
            Text(Order.address),
          ),
          DataCell(
            Text(Order.expectedDate),
          ),
          DataCell(
            Text(Order.expectedTime),
          ),
          DataCell(
            getStatus(context, Order.status),
          ),
          DataCell(
            Text(Order.userName),
          ),
          DataCell(Row(
            children: [
              InkWell(
                onTap: () {
                  //   assignDelivery(context, Order.id);
                },
                child: Icon(Icons.more_vert_sharp),
              ),
            ],
          ))
        ]);
  }

  Widget getHeaderText(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
    );
  }

  final tableBorder = const BorderSide(color: Color(0xFFEFEDED), width: 0.8);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          primary: false,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable(
                    headingRowColor:
                        MaterialStateProperty.all(const Color(0xFFFBFBFB)),
                    border: TableBorder(
                      horizontalInside: tableBorder,
                      top: tableBorder,
                      left: tableBorder,
                      right: tableBorder,
                      bottom: tableBorder,
                    ),
                    headingRowHeight: 51.bigScale,
                    dataRowHeight: 74.bigScale,
                    columns: [
                      DataColumn(
                        label: getHeaderText('ID'),
                      ),
                      DataColumn(
                        label: getHeaderText('PAID'),
                      ),
                      DataColumn(
                        label: getHeaderText('ADDRESS'),
                      ),
                      DataColumn(
                        label: SizedBox(
                            width: 100, child: getHeaderText('EXPECTED TIME')),
                      ),
                      DataColumn(
                        label: SizedBox(
                            width: 100, child: getHeaderText('EXPECTED DATE')),
                      ),
                      DataColumn(
                        label: getHeaderText('STATUS'),
                      ),
                      DataColumn(
                        label: SizedBox(
                            width: 100, child: getHeaderText('USER NAME')),
                      ),
                      DataColumn(label: Image.asset("images/table.png"))
                    ],
                    rows: Orders.map(
                      (e) => getOrderRow(e, i++, context),
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget getStatus(BuildContext context, String text) {
  Map<String, Color> bgColor = {
    "accepted": const Color(0xff3C3730),
    "completed": const Color(0xffBFE4D1),
    "placed": const Color(0xffE2E8F0),
    "cancelled": const Color(0xffFFE4E6),
    "outfordelivery": const Color(0xffE2E8F0)
  };

  Map<String, Color> fontColor = {
    "accepted": const Color(0xffDF9322),
    "completed": const Color(0xff098159),
    "placed": const Color(0xff10B981),
    "cancelled": const Color(0xffF43F5E),
    "outfordelivery": const Color(0xff334155)
  };
  return Container(
    decoration: BoxDecoration(
        color: (bgColor[text]),
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(100))),
    width: 100,
    height: 30,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
                color: fontColor[text],
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(100))),
            height: 7,
            width: 7),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
              color: fontColor[text],
              fontSize: 12,
              fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}

class _CheckBox extends StatefulWidget {
  const _CheckBox({
    Key? key,
  }) : super(key: key);

  @override
  State<_CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<_CheckBox> {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _checked = !_checked;
            });
          },
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: const EdgeInsets.all(2),
              alignment: Alignment.center,
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F2F2),
                border: Border.all(
                  color: const Color(0xFFD1D1D1),
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              child: _checked == false
                  ? null
                  : const FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Icon(
                        Icons.check,
                        color: Colors.black,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
