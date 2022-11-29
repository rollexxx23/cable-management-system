import 'package:cached_network_image/cached_network_image.dart';
import 'package:cms/view/book_appointment/book_appointment.dart';
import 'package:cms/view/my_subscription/my_subscription.dart';
import 'package:cms/view/recharge/channel_list.dart';
import 'package:cms/view/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final Email email = Email(
  body: 'Email body',
  subject: 'Email subject',
  recipients: ['example@example.com'],
  cc: ['cc@example.com'],
  bcc: ['bcc@example.com'],
  isHTML: false,
);

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listOfBanners = [
      "https://i.pinimg.com/474x/f9/da/5a/f9da5ad67dca7e4c2bcfba214c66ee39.jpg",
      "https://img.freepik.com/free-vector/gradient-world-footbal-championship-horizontal-banner-template_52683-96640.jpg",
      "https://cdn.shopify.com/s/files/1/0424/8322/0646/files/TBM_Template._Website_1000x400_copy.jpg"
    ];
    final controller = PageController(viewportFraction: 1, keepPage: true);
    final pages = List.generate(
      listOfBanners.length,
      (index) => InkWell(
        onTap: () async {},
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Center(child: Image.network(listOfBanners[index])),
        ),
      ),
    );
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          InkWell(
              onTap: () {
                Get.offAll(WelcomeScreen());
              },
              child: Icon(Icons.logout))
        ],
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        title:
            const Text("My Dashboard", style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 20),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Georgia",
                      color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Text(
                  "...",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Georgia",
                      color: Colors.blue),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: controller,
                // itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
              ),
            ),
            const SizedBox(
              height: 17.0,
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotColor: Color(0xFF96CFCC),
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MySubscriptions();
                    },
                  ),
                );
              },
              child: Container(
                height: 100.0,
                width: width - 40,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: const LinearGradient(
                        colors: [Colors.indigo, Colors.blueAccent]),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          offset: Offset(2.0, 2.0))
                    ]),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(width: 20),
                      Text(
                        "View Subscriptions",
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Georgia",
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 100.0,
              width: width - 40,
              decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
                      colors: [Colors.red, Colors.redAccent]),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        offset: Offset(2.0, 2.0))
                  ]),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ChannelList();
                      },
                    ),
                  );
                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(width: 20),
                      Text(
                        "Recharge",
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Georgia",
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.to(BookAppointment());
              },
              child: Container(
                height: 100.0,
                width: width - 40,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: const LinearGradient(
                        colors: [Colors.orange, Colors.orangeAccent]),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          offset: Offset(2.0, 2.0))
                    ]),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(width: 20),
                      Text(
                        "Schedule Booking",
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Georgia",
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                await FlutterEmailSender.send(email);
              },
              child: Container(
                height: 100.0,
                width: width - 40,
                decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: const LinearGradient(
                        colors: [Colors.purple, Colors.purpleAccent]),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          offset: Offset(2.0, 2.0))
                    ]),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(width: 20),
                      Text(
                        "Customer Service",
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Georgia",
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
