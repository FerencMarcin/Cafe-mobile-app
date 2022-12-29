import 'package:cafe_mobile_app/model/login_request_model.dart';
import 'package:http/http.dart' as http;

// class LoginService {
//   final String loginUrl = 'http://10.0.2.2:3001/users/login';
//
//   Future<http.Response> fetchUserLogin(String email, String password) async {
//     LoginRequestModel user = LoginRequestModel(email: email, password: password);
//     var url = Uri.parse(loginUrl);
//
//     http.Response res = await http.post(url, body: user.makeLoginRequest());
//     return res;
//     /*
//     if(res.statusCode == HttpStatus.ok) {
//       log('dobrze');
//       final responseData = jsonDecode(res.body);
//       if(responseData['error'] != null) {
//         log('jest blad');
//         return responseData['error'];
//       }
//       LoginResponseModel loggedInUser = LoginResponseModel(roleId: responseData['roleId'], token: responseData['token']);
//       return loggedInUser;
//     } else {
//       log('oj');
//       return jsonDecode(res.body)['error'];
//       return null;
//     }*/
//   }
// }