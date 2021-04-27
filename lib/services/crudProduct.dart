import 'package:http/http.dart' as http;

Future<void> addProduct(String categoryid, String subcategoryid, String productname, String productdesc,
    String originalprice, String sellingprice, String availibility, String productimage) async {

  final String apiUrl = "http://192.168.43.82/Eassymart/VersionCode1/Admin/addProduct.php";

  final response = await http.post(
      apiUrl,
      body: {

        "category_id": categoryid,
        "subcategory_id" : subcategoryid,

        "product_name" : productname,
        "product_desc" : productdesc,
        "original_price" : originalprice,
        "selling_price" : sellingprice,
        "availibility" : availibility, //availibility mdhe value yet ni ahe
        "image" : productimage

      },
      headers: {"Accept":"application/json"}
  );

  if (response.statusCode == 200) {

  } else {

  }
}

Future<void> updateProduct(String productid, String productname, String productdesc, String originalprice, String sellingprice, String availibility) async {
  final response = await http.post(
      "http://192.168.43.82/Eassymart/VersionCode1/Admin/updateProduct.php",
      body: {

        "product_id" : productid,
        "product_name" : productname,
        "product_desc" : productdesc,
        "original_price" : originalprice,
        "selling_price" : sellingprice,
        "availibility" : availibility //availibility mdhe value yet ni ahe
        //"image" : productimage

      },
      headers: {"Accept":"application/json"}
  );

  if (response.statusCode == 200) {

  } else {

  }
}


Future<void> deleteProduct(String productid) async {
  final response = await http.post(
      "http://192.168.43.82/Eassymart/VersionCode1/Admin/deleteProduct.php",

      body: {

        "product_id": productid,

      },

      headers: {"Accept":"application/json"}
  );


  if (response.statusCode == 200) {

  } else {

  }
}