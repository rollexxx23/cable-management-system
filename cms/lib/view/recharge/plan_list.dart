import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../controller/constant/razorpay.dart';
import 'channel_list.dart';

bool expanded = false;
int sel = 0;
Widget PlanWidget(BuildContext context, PlanModel model) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Image.network("https://www.nxtdigital.in/${model.imgUrl}",
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
                        "Language: ${model.language}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF000000),
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
                    ],
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  (model.price1 != 0)
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              sel = 0;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: (sel == 0) ? Colors.green : Colors.grey,
                                borderRadius: BorderRadius.circular(100)
                                //more than 50% of width makes circle
                                ),
                            child: Center(
                              child: Text("1",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: (sel == 0)
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ))
                      : Container(),
                  const SizedBox(width: 10),
                  (model.price3 != 0)
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              sel = 1;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: (sel == 1) ? Colors.green : Colors.grey,
                                borderRadius: BorderRadius.circular(100)
                                //more than 50% of width makes circle
                                ),
                            child: Center(
                              child: Text("3",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: (sel == 1)
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(width: 10),
                  (model.price6 != 0)
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              sel = 2;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: (sel == 2) ? Colors.green : Colors.grey,
                                borderRadius: BorderRadius.circular(100)
                                //more than 50% of width makes circle
                                ),
                            child: Center(
                              child: Text("6",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: (sel == 2)
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ),
                        )
                      : Container(),
                  const SizedBox(width: 10),
                  (model.price12 != 0)
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              sel = 3;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: (sel == 3) ? Colors.green : Colors.grey,
                                borderRadius: BorderRadius.circular(100)
                                //more than 50% of width makes circle
                                ),
                            child: Center(
                              child: Text("12",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: (sel == 3)
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Price: ${(sel == 0) ? model.price1 : (sel == 1) ? model.price3 : (sel == 2) ? model.price6 : model.price12}",
                    style: const TextStyle(
                      fontFamily: "SF Pro",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 20)
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  });
}

Widget channelCard(ChannelModel channel) {
  return Column(
    children: [
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) =>
                    const Center(child: Text("Failed to load image")),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                height: 50,
                width: 50,
                imageUrl: (channel.imgUrl),
              )),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(channel.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: (18),
                    fontWeight: FontWeight.bold)),
            Text(channel.genre,
                style: const TextStyle(
                    color: Color(0xff7A7A7A),
                    fontSize: (15),
                    fontWeight: FontWeight.w500)),
          ])
        ],
      ),
    ],
  );
}
