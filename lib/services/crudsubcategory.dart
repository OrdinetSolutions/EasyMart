import 'package:http/http.dart' as http;

Future<void> addSubCategory(String categoryid, String subcategory_name, String subcatimage) async {

  final String apiUrl = "http://192.168.43.82/Eassymart/VersionCode1/Admin/addSubCategory.php";

  final response = await http.post(
      apiUrl,
      body: {

        "category_id": categoryid,
        "subcategory_name": subcategory_name,
        "image" : subcatimage

      },
      headers: {"Accept":"application/json"}
  );

  if (response.statusCode == 200) {

  } else {

  }
}

Future<void> updateSubCategory(String subcategoryid, String subcategoryName) async {
  final response = await http.post(
      "http://192.168.43.82/Eassymart/VersionCode1/Admin/updateSubCategory.php",
      body: {

        "subcategory_id": subcategoryid,
        "subcategory_name": subcategoryName
        // "image": category_image

      },
      headers: {"Accept":"application/json"}
  );

  if (response.statusCode == 200) {

  } else {

  }
}


Future<void> deleteSubCategory(String subcategoryid) async {
  final response = await http.post(
      "http://192.168.43.82/Eassymart/VersionCode1/Admin/deleteSubCategory.php",

      body: {

        "subcategory_id": subcategoryid,

      },

      headers: {"Accept":"application/json"}
  );


  if (response.statusCode == 200) {

  } else {

  }
}