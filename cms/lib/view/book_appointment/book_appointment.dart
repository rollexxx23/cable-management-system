import 'package:cms/controller/constant/razorpay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../misc/button.dart';
import '../misc/textfield.dart';

TextEditingController nameTextController = TextEditingController();
TextEditingController addressTextController = TextEditingController();
TextEditingController emailTextController = TextEditingController();
TextEditingController phoneTextController = TextEditingController();
TextEditingController messageTextController = TextEditingController();

class BookAppointment extends StatefulWidget {
  const BookAppointment({Key? key}) : super(key: key);

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  @override
  Widget build(BuildContext context) {
    bool activated = true;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Book Appointment",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                const SizedBox(height: 20),
                customTextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: nameTextController,
                    hintText: "Name",
                    errorText: '',
                    onChanged: (v) => {}),
                const SizedBox(height: 20),
                customTextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: addressTextController,
                    hintText: "Address",
                    errorText: '',
                    onChanged: (v) => {}),
                const SizedBox(height: 20),
                customTextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: emailTextController,
                    hintText: "Email",
                    errorText: '',
                    onChanged: (v) => {}),
                const SizedBox(height: 20),
                customTextField(
                    maxLines: null,
                    keyboardType: TextInputType.phone,
                    controller: phoneTextController,
                    hintText: "Phone Number",
                    errorText: '',
                    onChanged: (v) => {}),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Pick Date"),
                    const SizedBox(width: 5),
                    InkWell(
                        onTap: () {
                          print("sjajha");
                          List<String> listTimes = [
                            "8 AM - 11 AM",
                            "11 AM - 12 PM",
                            "12 PM - 2 PM",
                            "2 PM - 4 PM",
                            "4 PM - 6 PM",
                            "6 PM - 8 PM"
                          ];

                          Get.bottomSheet(Container(
                            height: 400,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                const Text(
                                  'Expected Date & TIme',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(55, 71, 79, 1),
                                      fontSize: 16.583942413330078,
                                      letterSpacing: 0.6218978762626648,
                                      height: 1),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    DatePicker.showDatePicker(
                                      context,
                                      minTime: DateTime.now(),
                                      theme: const DatePickerTheme(
                                          backgroundColor: Colors.white),
                                      showTitleActions: true,
                                      onChanged: (date) {},
                                      onConfirm: (date) async {
                                        DateFormat dateFormat =
                                            DateFormat("yyyy-MM-dd");
                                        String string = dateFormat.format(date);
                                        print('confirm $string');

                                        //  setState;
                                      },
                                      currentTime: DateTime.now(),
                                    );
                                  },
                                  child: Card(
                                    elevation: 10,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.calendar_month),
                                          Container(
                                            width: 10,
                                          ),
                                          //   Text(expactedDate),
                                          const Spacer(),
                                          const Icon(Icons.arrow_drop_down)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GridView.count(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2.0,
                                  shrinkWrap: true,
                                  children: listTimes.map((e) {
                                    return GestureDetector(
                                      onTap: () async {},
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              e,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 10),
                                CustomButton(
                                  () {
                                    Get.back();
                                  },
                                  text: "Add",
                                )
                              ],
                            ),
                          ));
                        },
                        child: Icon(Icons.calendar_month))
                  ],
                ),
                const SizedBox(height: 20),
                customTextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: messageTextController,
                    hintText: "Message (optional)",
                    errorText: '',
                    onChanged: (v) => {}),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {
                      RazorpayHandler().openCheckout();
                    },
                    child: const Text(
                      "Book",
                      style: TextStyle(
                        fontFamily: "SF Pro",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )),
                const SizedBox(height: 50)
              ],
            ),
          ),
        ));
  }
}
