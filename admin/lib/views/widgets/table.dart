// import 'dart:convert';
// import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
// import 'package:admin/controller/api/auth_service.dart';
// import 'package:admin/views/widgets/user_registration.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:admin/model/employee.dart';
// import 'package:admin/utils/extension.dart';

// import 'package:flutter/material.dart';

// int i = 0;
// Future<void> updateStatus(
//     String id, String status, BuildContext context) async {
//   String url = "https://farmer.kodagu.today/users/$id";
//   var mapData = {
//     "status": status,
//   };
//   print(mapData);
//   final localStorage = GetStorage();
//   String email = localStorage.read("email");
//   String password = localStorage.read("pw");
//   var body = json.encode(mapData);
//   try {
//     AuthService().login(email, password, context);
//     Future.delayed(const Duration(milliseconds: 5));
//     String token = await localStorage.read("accessToken");
//     Future.delayed(const Duration(milliseconds: 5));
//     print("token      ${token.toLowerCase()}");
//     var data = await http.patch(
//       Uri.parse(url),
//       body: body,
//       headers: {
//         "Content-Type": "application/json",
//         'Authorization': 'Bearer $token',
//       },
//     );
//   } catch (e) {
//     print("errortable->$e");
//   }
// }

// class EmployeeTable extends StatelessWidget {
//   EmployeeTable({required this.employees, Key? key}) : super(key: key);

//   final List<Employee> employees;

//   DataRow getEmployeeRow(Employee employee, int idx, BuildContext context) {
//     return DataRow(
//         color: MaterialStateColor.resolveWith(
//           (states) {
//             if (idx % 2 == 0) {
//               return Colors.white;
//             } else {
//               return const Color(0xffF8FAFC);
//             }
//           },
//         ),
//         cells: [
//           const DataCell(_CheckBox()),
//           DataCell(
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: const Color(0xFFD5DFF6),
//                   child: Image.asset("images/Avatar.png"),
//                 ),
//                 SizedBox(
//                   width: 11.bigScale,
//                 ),
//                 Center(
//                   child: Text(employee.name),
//                 ),
//               ],
//             ),
//           ),
//           DataCell(
//             Text(employee.email),
//           ),
//           DataCell(
//             Text(employee.location),
//           ),
//           DataCell(
//             getStatus(context, employee, employee.status),
//           ),
//           DataCell(
//             Text(employee.regNo),
//           ),
//           DataCell(
//             Text(employee.stateMedicalCouncil),
//           ),
//           DataCell(Row(
//             children: const [
//               InkWell(child: Icon(Icons.more_vert_sharp)),
//             ],
//           ))
//         ]);
//   }

//   Widget getHeaderText(String text) {
//     return Text(
//       text,
//       style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
//     );
//   }

//   final tableBorder = const BorderSide(color: Color(0xFFEFEDED), width: 0.8);
//   final _verticalScrollController = ScrollController();
//   final _horizontalScrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     return AdaptiveScrollbar(
//       underColor: Colors.blueGrey.withOpacity(0.3),
//       sliderDefaultColor: Colors.grey.withOpacity(0.7),
//       sliderActiveColor: Colors.grey,
//       controller: _verticalScrollController,
//       child: AdaptiveScrollbar(
//         controller: _horizontalScrollController,
//         position: ScrollbarPosition.bottom,
//         underColor: Colors.blueGrey.withOpacity(0.3),
//         sliderDefaultColor: Colors.grey.withOpacity(0.7),
//         sliderActiveColor: Colors.grey,
//         child: SingleChildScrollView(
//           controller: _verticalScrollController,
//           scrollDirection: Axis.vertical,
//           child: SingleChildScrollView(
//             controller: _horizontalScrollController,
//             scrollDirection: Axis.horizontal,
//             child: Padding(
//                 padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
//                 child: DataTable(
//                   headingRowColor:
//                       MaterialStateProperty.all(const Color(0xFFFBFBFB)),
//                   border: TableBorder(
//                     horizontalInside: tableBorder,
//                     top: tableBorder,
//                     left: tableBorder,
//                     right: tableBorder,
//                     bottom: tableBorder,
//                   ),
//                   headingRowHeight: 51.bigScale,
//                   dataRowHeight: 74.bigScale,
//                   columns: [
//                     DataColumn(
//                       label: SizedBox(
//                           width: 20.bigScale, child: const _CheckBox()),
//                     ),
//                     DataColumn(
//                       label: getHeaderText('Full Name'),
//                     ),
//                     DataColumn(
//                       label: getHeaderText('Email'),
//                     ),
//                     DataColumn(
//                       label: getHeaderText('Location'),
//                     ),
//                     DataColumn(
//                       label: getHeaderText('Status'),
//                     ),
//                     DataColumn(
//                       label: getHeaderText('Registration No'),
//                     ),
//                     DataColumn(
//                       label: getHeaderText('State Medical Council'),
//                     ),
//                     DataColumn(label: Image.asset("images/table.png"))
//                   ],
//                   rows: employees
//                       .map(
//                         (e) => getEmployeeRow(e, i++, context),
//                       )
//                       .toList(),
//                 )),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget getStatus(BuildContext context, Employee employee, String text) {
//   return Container(
//     decoration: BoxDecoration(
//         color: (text == "active")
//             ? const Color(0xffD1FAE5)
//             : (text == "decline")
//                 ? const Color(0xffF7A6A6)
//                 : const Color(0xffE2E8F0),
//         border: Border.all(
//           color: Colors.transparent,
//         ),
//         borderRadius: const BorderRadius.all(Radius.circular(100))),
//     width: 100,
//     height: 30,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//             decoration: BoxDecoration(
//                 color: (text == "active")
//                     ? const Color(0xff10B981)
//                     : (text == "decline")
//                         ? Colors.red
//                         : const Color(0xff334155),
//                 border: Border.all(
//                   color: Colors.transparent,
//                 ),
//                 borderRadius: const BorderRadius.all(Radius.circular(100))),
//             height: 7,
//             width: 7),
//         const SizedBox(width: 10),
//         Text(
//           text,
//           style: TextStyle(
//               color: (text == "active")
//                   ? const Color(0xff10B981)
//                   : (text == "decline")
//                       ? Colors.red
//                       : const Color(0xff334155),
//               fontSize: 12,
//               fontWeight: FontWeight.w400),
//         )
//       ],
//     ),
//   );
// }

// class _CheckBox extends StatefulWidget {
//   const _CheckBox({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<_CheckBox> createState() => _CheckBoxState();
// }

// class _CheckBoxState extends State<_CheckBox> {
//   bool _checked = false;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 16,
//       height: 16,
//       child: Center(
//         child: GestureDetector(
//           onTap: () {
//             setState(() {
//               _checked = !_checked;
//             });
//           },
//           child: AspectRatio(
//             aspectRatio: 1,
//             child: Container(
//               padding: const EdgeInsets.all(2),
//               alignment: Alignment.center,
//               width: 5,
//               height: 5,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF3F2F2),
//                 border: Border.all(
//                   color: const Color(0xFFD1D1D1),
//                 ),
//                 borderRadius: BorderRadius.circular(2),
//               ),
//               child: _checked == false
//                   ? null
//                   : const FittedBox(
//                       fit: BoxFit.fitWidth,
//                       child: Icon(
//                         Icons.check,
//                         color: Colors.black,
//                       ),
//                     ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
