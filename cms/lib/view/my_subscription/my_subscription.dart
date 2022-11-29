import 'package:flutter/material.dart';

class MySubscriptions extends StatefulWidget {
  const MySubscriptions({Key? key}) : super(key: key);

  @override
  State<MySubscriptions> createState() => _MySubscriptionsState();
}

class _MySubscriptionsState extends State<MySubscriptions> {
  Future<List<SubscriptionModel>> getSubscriptionList() async {
    List<SubscriptionModel> list = [
      SubscriptionModel(
          autoSubscribe: false,
          daysLeft: 5,
          id: "",
          name: "Sports Plan",
          imageUrl:
              "https://static.wikia.nocookie.net/logopedia/images/f/f4/Star_Sports_2013.png",
          duration: "84",
          price: "199"),
      SubscriptionModel(
          autoSubscribe: false,
          daysLeft: 9,
          id: "",
          name: "AAJ TAK",
          imageUrl:
              "https://www.nxtdigital.in/static/images/logo/AAJ%20TAK.jpg",
          duration: "84",
          price: "199"),
      SubscriptionModel(
          autoSubscribe: true,
          daysLeft: 25,
          id: "",
          name: "Zee Cinema",
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/en/thumb/3/30/Zee5_Official_logo.svg/1200px-Zee5_Official_logo.svg.png",
          duration: "84",
          price: "199")
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    bool activated = true;
    return Scaffold(
        backgroundColor: Color(0xFFE2E2E2),
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "My Subscriptions",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                // Get.offAll(NewHomeScreen());
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              FutureBuilder<List<SubscriptionModel>>(
                future:
                    getSubscriptionList(), // function where you call your api
                builder: (BuildContext context,
                    AsyncSnapshot<List<SubscriptionModel>> snapshot) {
                  // AsyncSnapshot<Your object type>
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: Text('Please wait its loading...'));
                  } else {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return (snapshot.data!.isEmpty)
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/nocart.png",
                                    width: 200,
                                    height: 200,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text("No Subscription",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0, top: 10, bottom: 10),
                                shrinkWrap: true,
                                //physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  crossAxisCount: 1,
                                  childAspectRatio: 1.65,
                                ),
                                itemBuilder: (context, index) {
                                  return NewSubscriptionItem(
                                      context, snapshot.data![index]);
                                },
                              ),
                            );
                    } // snapshot.data  :- get your object which is pass from your downloadData() function
                  }
                },
              ),
              const SizedBox(height: 50)
            ],
          ),
        ));
  }
}

Widget NewSubscriptionItem(BuildContext context, SubscriptionModel model) {
  return StatefulBuilder(builder: (context, setState) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Image.network(model.imageUrl, width: 100, height: 100),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (model.name.length <= 22)
                        ? model.name
                        : "${model.name.substring(0, 20)}..",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Auto Subscribe: ${model.autoSubscribe}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Duration: ${model.duration} days",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${model.daysLeft.toString()} Days Left",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: (model.daysLeft <= 5) ? Colors.red : Colors.green,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "₹${double.parse(model.price).toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontFamily: "SF Pro",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF26AE60),
                      fontSize: 20,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          (model.autoSubscribe)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontFamily: "SF Pro",
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        )),
                    const SizedBox(width: 20),
                  ],
                )
              : Container()
        ],
      ),
    );
  });
}

class SubscriptionModel {
  String name;
  int daysLeft;
  String price;
  String imageUrl;
  String id;
  String duration;
  bool autoSubscribe;

  SubscriptionModel(
      {required this.autoSubscribe,
      required this.daysLeft,
      required this.id,
      required this.name,
      required this.imageUrl,
      required this.duration,
      required this.price});
}
