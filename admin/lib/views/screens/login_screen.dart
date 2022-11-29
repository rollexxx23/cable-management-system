import 'package:admin/controller/api/auth_service.dart';
import 'package:admin/views/screens/dashboard1.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextEditingController pwController = TextEditingController();
TextEditingController emailController = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xff26AE60),
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              Opacity(
                opacity: 0.05,
                child: Image.network(
                  'https://res.cloudinary.com/dek0w0qnj/image/upload/v1664458627/Circle_5_d4bkcn.png',
                  height: MediaQuery.of(context).size.height * .80,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
          Center(
            child: Material(
              elevation: 5,
              child: Container(
                width: 400,
                height: 392,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Column(
                        children: const [
                          Text("CMS Admin",
                              style: TextStyle(
                                  color: Color(0xff26AE60),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(height: 20),
                          Text("Login",
                              style: TextStyle(
                                  color: Color(0xff334155),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 10),
                          Text("Enter your account details below.",
                              style: TextStyle(
                                  color: Color(0xff64748B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                          SizedBox(height: 30),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text("Email",
                                  style: TextStyle(
                                      color: Color(0xff64748B),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 36,
                            child: TextField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey))),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text("Password",
                                  style: TextStyle(
                                      color: Color(0xff64748B),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 36,
                            child: TextField(
                              controller: pwController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.grey))),
                            ),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              // AuthService().login(emailController.text,
                              //     pwController.text, context);
                              if (emailController.text == "admin@cms.com" &&
                                  pwController.text == "12345678") {
                                Get.to(const DashBoard1());
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: const [
                                          Text(
                                              "ERROR OCCURED, PLEASE TRY AGAIN"),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel",
                                                style: TextStyle(
                                                    color: Colors.purple)))
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              width: 320,
                              color: const Color(0xff4558FF),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Center(
                                  child: Text("Log In",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
