import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cms/controller/constant/razorpay.dart';
import 'package:cms/view/recharge/plan_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<List<ChannelModel>> getChannelList() async {
  String url = "https://www.nxtdigital.in/api?&type=ala";
  List<ChannelModel> list = [];
  try {
    var res = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    var jsonDecoded = await json.decode(res.body);
    print(jsonDecoded);
    int i = 0;

    for (dynamic sD in jsonDecoded) {
      print("h");
      double price = 0;
      if (sD["channel_price"] == null) {
        price = 0;
      } else {
        price = double.parse(sD["channel_price"]);
      }
      list.add(ChannelModel(
          language: sD["channel_language"] ?? "",
          type: sD["hd"] ?? "",
          genre: sD["channel_type"] ?? "",
          id: (i++).toString(),
          name: sD["channel_name"] ?? "",
          imgUrl: sD["channel_logo"] ?? "",
          price: price));
    }
  } catch (e) {
    print(e.toString());
  }

  return list;
}

Future<List<PlanModel>> getPlanList() async {
  List<PlanModel> list = [];
  String url = "https://www.nxtdigital.in/api?&type=fp";
  try {
    var res = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    var jsonDecoded = await json.decode(res.body);
    print(jsonDecoded);
    int i = 0;
    for (dynamic sD in jsonDecoded) {
      double price1 = 0;
      double price3 = 0;
      double price6 = 0;
      double price12 = 0;
      if (sD["price1"] == null) {
        price1 = 0;
      } else {
        price1 = double.parse(sD["price1"]);
      }
      if (sD["price3"] == null) {
        price3 = 0;
      } else {
        price3 = double.parse(sD["price3"]);
      }
      if (sD["price6"] == null) {
        price6 = 0;
      } else {
        price6 = double.parse(sD["price6"]);
      }
      if (sD["price12"] == null) {
        price12 = 0;
      } else {
        price12 = double.parse(sD["price12"]);
      }
      list.add(PlanModel(
          listOfChanhnels: [],
          genre: sD["foundation_pack_language"] ?? "",
          id: sD["plancode"] ?? "",
          name: sD["foundation_pack_name"] ?? "",
          imgUrl: sD["logo"] ?? "",
          price1: price1,
          price3: price3,
          price6: price6,
          price12: price12,
          language: sD["language_filter"] ?? ""));
    }
  } catch (e) {
    print(e.toString());
  }

  return list;
}

class ChannelList extends StatelessWidget {
  const ChannelList({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Channels List",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: Icon(Icons.tv),
                  child: Text(
                    "Channels",
                    style: TextStyle(color: Colors.blue),
                  )),
              Tab(
                  icon: Icon(Icons.table_view_rounded),
                  child: Text(
                    "Plans",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 8),
            SizedBox(
              height: 750,
              child: TabBarView(
                children: [widget1(), widget2()],
              ),
            ),
            const SizedBox(height: 50)
          ],
        )),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }
}

Widget widget1() {
  return FutureBuilder<List<ChannelModel>>(
    future: getChannelList(), // function where you call your api
    builder:
        (BuildContext context, AsyncSnapshot<List<ChannelModel>> snapshot) {
      // AsyncSnapshot<Your object type>
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: Text('Please wait its loading...'));
      } else {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return (snapshot.data!.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(height: 10),
                      Text("No Subscription",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    //physics: NeverScrollableScrollPhysics(),
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
                      return ChannelWidget(context, snapshot.data![index]);
                    },
                  ),
                );
        } // snapshot.data  :- get your object which is pass from your downloadData() function
      }
    },
  );
}

Widget widget2() {
  return FutureBuilder<List<PlanModel>>(
    future: getPlanList(), // function where you call your api
    builder: (BuildContext context, AsyncSnapshot<List<PlanModel>> snapshot) {
      // AsyncSnapshot<Your object type>
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: Text('Please wait its loading...'));
      } else {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return (snapshot.data!.isEmpty)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(height: 10),
                      Text("No Plans",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    //  physics: NeverScrollableScrollPhysics(),
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
                      return PlanWidget(context, snapshot.data![index]);
                    },
                  ),
                );
        } // snapshot.data  :- get your object which is pass from your downloadData() function
      }
    },
  );
}

Widget ChannelWidget(BuildContext context, ChannelModel model) {
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
              Image.network("https://www.nxtdigital.in/static/${model.imgUrl}",
                  width: 100, height: 100),
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
                    height: 6,
                  ),
                  Text(
                    "Category: ${model.genre}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Language: ${model.language}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "₹${model.price.toStringAsFixed(0)}/month",
                        style: const TextStyle(
                          fontFamily: "SF Pro",
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF26AE60),
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  ),
                  onPressed: () {
                    RazorpayHandler().openCheckout();
                  },
                  child: const Text(
                    "Subscribe",
                    style: TextStyle(
                      fontFamily: "SF Pro",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
    );
  });
}

class ChannelModel {
  String name;

  double price;
  String genre;
  String id;
  String language;
  String imgUrl;
  String type;
  ChannelModel(
      {required this.language,
      required this.genre,
      required this.id,
      required this.name,
      required this.type,
      required this.imgUrl,
      required this.price});
}

class PlanModel {
  String name;
  String id;

  double price1;
  double price3;
  double price6;
  double price12;
  String genre;

  String language;
  String imgUrl;
  List<ChannelModel> listOfChanhnels;
  PlanModel(
      {required this.listOfChanhnels,
      required this.genre,
      required this.id,
      required this.name,
      required this.imgUrl,
      required this.price1,
      required this.price3,
      required this.price6,
      required this.price12,
      required this.language});
}
