import 'package:http/http.dart' as http;

Future<void> addCategory(String category_name, String category_image) async {

  final String apiUrl = "http://192.168.43.82/Eassymart/VersionCode1/Admin/addCategory.php";

  final response = await http.post(
      apiUrl,
      body: {

        "category_name": category_name,
        "image": category_image
      },
      headers: {"Accept":"application/json"}
  );

  if (response.statusCode == 200) {

  } else {

  }
}

Future<void> updateCategory(String categoryid, String categoryName) async {
  final response = await http.post(
      "http://192.168.43.82/Eassymart/VersionCode1/Admin/updateCategory.php",
      body: {

        "category_id": categoryid,
        "category_name": categoryName
       // "image": category_image

      },
      headers: {"Accept":"application/json"}
  );

  if (response.statusCode == 200) {

  } else {

  }
}


Future<void> deleteCategory(String categoryid) async {
  final response = await http.post(
      "http://192.168.43.82/Eassymart/VersionCode1/Admin/deleteCategory.php",

      body: {

        "category_id": categoryid,

      },

      headers: {"Accept":"application/json"}
  );


  if (response.statusCode == 200) {

  } else {

  }
}

