import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class GetUserId {
  void getUserApi(String email) async {
    final localStorage = GetStorage();
    print("user api");

    String url = "https://farmer.kodagu.today/users";
    try {
      var res = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      var jsonDecoded = await json.decode(res.body);
      // print(jsonDecoded.toString());
      for (var singleData in jsonDecoded["data"]) {
        if (singleData["email"] == email) {
          print("Found userID-> ${singleData["id"]}");

          print("data-> ${singleData["first_name"]}");

          localStorage.write("firstName", singleData["first_name"].toString());
          localStorage.write("lastName", singleData["last_name"].toString());
          localStorage.write("photoURL", singleData["photo_url"].toString());
          localStorage.write("type", singleData["auth_type"].toString());
          localStorage.write("email", singleData["email"].toString());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
