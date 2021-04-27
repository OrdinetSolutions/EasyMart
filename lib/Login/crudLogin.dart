import 'package:http/http.dart' as http;

Future<void> loginAdmin(String user_name, String password) async {

  final String apiUrl = "http://192.168.43.82/Eassymart/VersionCode1/Admin/checkAdminLogin.php";

  final response = await http.post(
      apiUrl,
      body: {

        "username": user_name,
        "password": password
      },
      headers: {"Accept":"application/json"}
  );

  if (response.statusCode == 200) {

  } else {

  }
}