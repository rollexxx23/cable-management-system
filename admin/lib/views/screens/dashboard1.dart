import 'dart:convert';
import 'dart:math';
import 'package:admin/model/booking.dart';
import 'package:admin/model/order.dart';
import 'package:admin/utils/extension.dart';
import 'package:admin/views/screens/login_screen.dart';
import 'package:admin/views/widgets/order_table.dart';
import 'package:http/http.dart' as http;

import 'package:admin/views/screens/dashboard2.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

int selected = 0;
int type = 0;
int cur = 0;

Future<int> getCount() async {
  return 36;
}

final TextEditingController _searchText = TextEditingController();
String searchVal = "";

class DashBoard1 extends StatefulWidget {
  const DashBoard1({Key? key}) : super(key: key);

  @override
  State<DashBoard1> createState() => _DashBoard1State();
}

class _DashBoard1State extends State<DashBoard1> {
  @override
  Widget build(BuildContext context) {
    Future<String> getFirstName() async {
      return "Admin";
    }

    double screenWidth = MediaQuery.of(context).size.width;
    // ignore: no_leading_underscores_for_local_identifiers
    PopupMenuItem _buildPopupMenuAccItem(
        int value, bool moreinfo, bool notSeen, Function ontap) {
      return PopupMenuItem(
        value: value,
        onTap: () => ontap(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 13),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: (notSeen)
                  ? const Color(0xffedefff)
                  : const Color(0xffF0F0F0)),
          child: Stack(
            children: [
              ListTile(
                leading: const OvalImage(size: 45),
                contentPadding:
                    const EdgeInsets.only(left: 5, right: 3, top: 0, bottom: 0),
                minVerticalPadding: 0,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ullamcorper ac nisi non proin pharetra, phasellus. Dui tortor lobortis quis quis. ",
                        style: TextStyle(
                            color: Colors.black, fontSize: 10, height: 1.5)),
                    if (moreinfo)
                      CustomButton(
                        padding: const EdgeInsets.all(1),
                        margin: const EdgeInsets.only(top: 10),
                        width: 65,
                        height: 25,
                        textSize: 9,
                        fontWeight: FontWeight.w500,
                        buttonText: "View Event",
                        onPressed: () {},
                        shadowColor: Colors.transparent,
                        primaryColor: Colors.transparent,
                        borderColor: Theme.of(context).focusColor,
                        textColor: Theme.of(context).focusColor,
                      ),
                  ],
                ),
                trailing:
                    Icon(Icons.more_vert, color: Colors.black.withOpacity(0.5)),
              ),
              Positioned(
                right: screenWidth * 0.03,
                top: (moreinfo) ? 5 : 6,
                child: const Text("1h",
                    style: TextStyle(color: Colors.black, fontSize: 8)),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF1F5F9),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "CMS Admin",
                          style: TextStyle(
                              color: Color(0xff26AE60),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 90,
                          height: 35,
                          color: const Color(0xffEFF6FF),
                          child: Row(
                            children: const [
                              SizedBox(width: 10),
                              Icon(
                                Icons.home,
                                color: Color(0xff26AE60),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Home",
                                style: TextStyle(
                                    color: Color(0xff26AE60),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            //  Get.to(DashBoard2());
                          },
                          child: Container(
                            width: 100,
                            height: 35,
                            color: Colors.white,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Image.asset("images/profile-2user.png"),
                                const SizedBox(width: 10),
                                const Text(
                                  "All Orders",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                            onTap: () {
                              Get.offAll(const LoginScreen());
                            },
                            child: const Icon(Icons.logout)),
                        const SizedBox(
                          width: 12,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.person),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Admin',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(0))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 30),
                      FutureBuilder<String>(
                        future: getFirstName(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Text('Loading....');
                            default:
                              if (snapshot.hasError) {
                                return const Text('Welcome back,');
                              } else {
                                return Text(
                                  "Welcome back, ${snapshot.data}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                );
                              }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cardWidget(context, 4, "Placed"),
                  cardWidget(context, 5, "Accepted"),
                  cardWidget(context, 6, "Out For Delivery"),
                  cardWidget(context, 7, "Completed"),
                  cardWidget(context, 8, "Cancelled")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                // height: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(0))),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SizedBox(width: 30),
                            Text(
                              "Orderbase",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 30),
                            const Text(
                              "Author",
                              style: TextStyle(
                                  color: Color(0xff64748B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 10),
                            FutureBuilder<String>(
                              future: getFirstName(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return const Text('Loading....');
                                  default:
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Text(
                                        snapshot.data ?? "",
                                        style: const TextStyle(
                                            color: Color(0xff334155),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      );
                                    }
                                }
                              },
                            ),
                            const SizedBox(width: 10),
                            Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffCBD5E1),
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                                height: 4,
                                width: 4),
                            const SizedBox(width: 10),
                            const Text(
                              "Updated",
                              style: TextStyle(
                                  color: Color(0xff64748B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Just Now",
                              style: TextStyle(
                                  color: Color(0xff64748B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            tabs(0, "All"),
                            tabs(1, "New Orders"),
                            tabs(2, "Paid"),
                            tabs(3, "Not Paid"),
                            tabs(4, "Placed"),
                            tabs(5, "Packed"),
                            tabs(6, "Out For Delivery"),
                            tabs(7, "Delivered"),
                            tabs(8, "Cancelled")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width - 50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 96.bigScale,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(25.scale),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color(0xFFEFEDED),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16.scale),
                        constraints: BoxConstraints(maxWidth: 394.scale),
                        alignment: Alignment.center,
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() {
                              cur = 0;
                              _searchText.text = val;
                              _searchText.selection =
                                  TextSelection.fromPosition(
                                      TextPosition(offset: val.length));
                            });
                          },
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                          controller: _searchText,
                          decoration: InputDecoration(
                            focusColor: Colors.red,
                            border: InputBorder.none,
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              fontSize: 18.scale,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                            icon: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset('images/search.png'),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 18.scale,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      // IconBtn(
                      //   child: DropdownBtn(
                      //     options: const ['Filter', 'Lorem', 'Ipsum'],
                      //     width: 85.scale,
                      //   ),
                      //   onTap: () {},
                      // ),
                      const SizedBox(width: 10),
                      const Text(
                        "Displaying 10 results",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width - 50,
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    height: 96.bigScale,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(25.scale),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text("Pending Orders",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                        SizedBox(width: 20),
                        Text(
                          "Displaying 10 results",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )),
            ),
            FutureBuilder<List<BookingModel>>(
              future: getBookingList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<BookingModel>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Text('Loading....');
                  default:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: OrderTable(
                          Orders: (snapshot.data != null)
                              ? snapshot.data!.sublist(cur * 10,
                                  min((cur + 1) * 10, snapshot.data!.length))
                              : [],
                        ),
                      );
                    }
                }
              },
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width - 50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: pagination(),
              ),
            ),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }

  Widget pagination() {
    return FutureBuilder(
        future: getCount(),
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      cur = max(0, cur - 1);
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffE2E8F0),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0))),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 20,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (snapshot.data! / 10).truncate() +
                          ((snapshot.data! % 10 == 0) ? 0 : 1),
                      itemBuilder: (context, index) => pages(index)),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    setState(() {
                      cur = min(
                          (snapshot.data! / 10).truncate() +
                              ((snapshot.data! % 10 == 0) ? -1 : 0),
                          cur + 1);
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffE2E8F0),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0))),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }

  Widget pages(int index) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          color: (index == cur) ? const Color(0xff3B82F6) : Colors.white,
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Center(
        child: Text(
          (index + 1).toString(),
          style: TextStyle(
              color: (cur == index) ? Colors.white : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

Widget cardWidget(BuildContext context, int val, String header) {
  return InkWell(
    onTap: () {
      // Get.to(DashBoard2(
      //   selected: val,
      //   type: val,
      // ));
    },
    child: FutureBuilder<int>(
      future: getCount(), // async work
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading....');
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Container(
                width: MediaQuery.of(context).size.width * 0.15,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Booking $header",
                            style: const TextStyle(
                                color: Color(0xff64748B),
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 10),
                          Image.asset("assets/images/Vector.png")
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${snapshot.data} orders",
                            style: const TextStyle(
                                color: Color(0xff334155),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 5),
                          Image.asset("assets/images/arrow-up-right.png"),
                          const SizedBox(width: 5),
                          const Text(
                            "",
                            style: TextStyle(
                                color: Color(0xff10B981),
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
        }
      },
    ),
  );
}

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}

class Nortification extends StatelessWidget {
  final bool moreinfo;
  final bool notSeen;
  const Nortification({Key? key, this.notSeen = false, this.moreinfo = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 13),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: (notSeen) ? const Color(0xffedefff) : const Color(0xffF0F0F0)),
      child: Stack(
        children: [
          ListTile(
            leading: const OvalImage(size: 45),
            contentPadding:
                const EdgeInsets.only(left: 5, right: 3, top: 0, bottom: 0),
            minVerticalPadding: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ullamcorper ac nisi non proin pharetra, phasellus. Dui tortor lobortis quis quis. ",
                    style: TextStyle(
                        color: Colors.black, fontSize: 10, height: 1.5)),
                if (moreinfo)
                  CustomButton(
                    padding: const EdgeInsets.all(1),
                    margin: const EdgeInsets.only(top: 10),
                    width: 65,
                    height: 25,
                    textSize: 9,
                    fontWeight: FontWeight.w500,
                    buttonText: "View Event",
                    onPressed: () {},
                    shadowColor: Colors.transparent,
                    primaryColor: Colors.transparent,
                    borderColor: Theme.of(context).focusColor,
                    textColor: Theme.of(context).focusColor,
                  ),
              ],
            ),
            trailing:
                Icon(Icons.more_vert, color: Colors.black.withOpacity(0.5)),
          ),
          Positioned(
            right: screenWidth * 0.03,
            top: (moreinfo) ? 5 : 6,
            child: const Text("1h",
                style: TextStyle(color: Colors.black, fontSize: 8)),
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? primaryColor;
  final Color? borderColor;
  final double? borderRadius;
  final Color? shadowColor;
  final Color? textColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  const CustomButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      this.width,
      this.margin,
      this.fontWeight,
      this.padding,
      this.textSize,
      this.borderRadius,
      this.borderColor,
      this.shadowColor,
      this.primaryColor,
      this.textColor,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: margin ?? const EdgeInsets.only(top: 25, bottom: 18),
        // alignment: Alignment.center,
        width: width ?? double.infinity,
        height: height ?? MediaQuery.of(context).size.width * 0.15,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              padding: padding,
              // ignore: deprecated_member_use
              primary: primaryColor ?? Theme.of(context).focusColor,
              shadowColor: shadowColor,
              alignment: Alignment.center,
              side: BorderSide(
                  color: borderColor ?? Colors.transparent, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 15),
              )),
          child: Text(buttonText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor ?? Colors.white,
                  fontSize: textSize,
                  fontWeight: fontWeight)),
        ));
  }
}

class CustomMaterialButton extends StatelessWidget {
  final bool twolines;
  final double? height;
  final double? width;
  final void Function()? onPressed;
  final String text;
  final String subText;
  const CustomMaterialButton(
      {super.key,
      this.twolines = true,
      this.text = "",
      required this.subText,
      required this.onPressed,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      height: height,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Color(0xffF0F0F0), width: 1)),
      padding: const EdgeInsets.all(20),
      onPressed: onPressed,
      child: Row(
        children: [
          const Icon(
            Icons.add,
            color: Color(0xff292D32),
          ),
          SizedBox(
            width: (twolines) ? 15 : 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (twolines)
                Text(text,
                    style: TextStyle(
                        fontFamily: 'TTNormsPro-Regular',
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Colors.black.withOpacity(0.6))),
              const SizedBox(
                height: 5,
              ),
              Text(
                subText,
                style: TextStyle(
                    fontFamily: 'TTNormsPro-Regular',
                    color:
                        twolines ? Colors.black : Colors.black.withOpacity(0.7),
                    fontWeight: twolines ? FontWeight.w500 : FontWeight.w400,
                    fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}

class OvalImage extends StatelessWidget {
  final double size;
  const OvalImage({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipOval(
          child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDqc-DAdyw0_SflhMQbBK6fTdQxkdFpHVD7A&usqp=CAU",
              fit: BoxFit.cover)),
    );
  }
}

Widget tabs(int val, String txt) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0),
    child: InkWell(
      onTap: () {
        // setState(() {
        //   widget.selected = val;
        //   widget.type = val;
        //   cur = 0;
        //   _searchText.text = "";
        // });
      },
      child: Container(
        color: (selected == val) ? Colors.green.withOpacity(0.1) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            txt,
            style: TextStyle(
                color:
                    (selected == val) ? Colors.green : const Color(0xff64748B),
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ),
  );
}

Future<List<BookingModel>> getBookingList() async {
  List<BookingModel> list = [
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "cancelled",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "cancelled",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "placed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "placed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "placed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "placed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "completed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "accepted",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "accepted",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "placed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "completed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "completed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "placed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "completed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "cancelled",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "cancelled",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "placed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "cancelled",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "cancelled",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "accepted",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "accepted",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "placed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "placed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "placed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "placed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "completed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "completed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "completed",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "accepted",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "accepted",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "accepted",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "cancelled",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "cancelled",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "cancelled",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "cancelled",
        userName: "Arin"),
    BookingModel(
        address: "Sector A",
        expectedDate: "29/11/22",
        expectedTime: "10:00AM-12:00AM",
        id: "7555",
        paid: "true",
        status: "cancelled",
        userName: "Arin"),
  ];
  return list;
}
