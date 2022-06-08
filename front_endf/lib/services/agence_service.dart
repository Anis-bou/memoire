import 'dart:convert';
import 'dart:io';
import 'package:blogapp/constant.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Offer.dart';
import '../models/agence.dart';

class Api {
// ____________login_agence___________________
  static Future<ApiResponse> login_agence(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(Uri.parse(loginagenceURL),
          headers: {'Accept': 'application/json'},
          body: {'email': email, 'password': password});

      switch (response.statusCode) {
        case 200:
          apiResponse.data = Agence.fromJson(jsonDecode(response.body));
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }

    return apiResponse;
  }
//____________________________________//

//____ Register_agence_________________//
  static Future<ApiResponse> register_agence(
      String name, String email, String password) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(Uri.parse(registeragenceURL), headers: {
        'Accept': 'application/json'
      }, body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = Agence.fromJson(jsonDecode(response.body));
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }
//____________________________//

  static postOffer(data, apiUrl) async {
    String token = await getToken();
    var fullUrl = baseURL + apiUrl;
    return await http
        .post(Uri.parse(fullUrl), body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
  }

//___________getOffer__________//
  static Future<ApiResponse> getOffer() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(Uri.parse(offersURL), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['offers']
              .map((p) => Offer.fromJson(p))
              .toList();
          // we get list of posts, so we need to map each item to post model
          apiResponse.data as List<dynamic>;
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }
  //________________________//

//_____________________ Delete post______________________//
  static Future<ApiResponse> deleteOffer(int offerId) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.delete(Uri.parse('$offersURL/$offerId'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  // agence
  static Future<ApiResponse> getAgenceDetail() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(Uri.parse(userURL), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = Agence.fromJson(jsonDecode(response.body));
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

// get token
  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }

// get agence id
  static Future<int> getAgenceId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('agenceID') ?? 0;
  }

  // Edit post
  static Future<ApiResponse> editPost(
      int OfferId,
      String price,
      String bedrooms,
      String addres,
      String area,
      String bathrooms,
      String kitchen,
      String garage,
      String name_agence,
      String description) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response =
          await http.put(Uri.parse('$offersURL/$OfferId'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        'price': price,
        'bedrooms': bedrooms,
        'addres': addres,
        'area': area,
        'bathrooms': bathrooms,
        'kitchen': kitchen,
        'garage': garage,
        'name_agence': name_agence,
        'description': description
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  postDataWithImage(data, apiUrl, filepath) async {
    var fullUrl = baseURL + apiUrl;
    String token = await getToken();
    //token = await SharedPreferencesManager().getAuthToken();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl))
      ..fields.addAll(data)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', filepath));
    return await request.send();
  }

  postDataWithImages(data, apiUrl, List<XFile> files) async {
    var fullUrl = baseURL + apiUrl;
    String token = await getToken();
    //token = await SharedPreferencesManager().getAuthToken();
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl))
      ..fields.addAll(data)
      ..headers.addAll(headers);
    for (var file in files) {
      request.files
          .add(await http.MultipartFile.fromPath('images[]', file.path));
    }
    return await request.send();
  }

  static Future<ApiResponse> getMyOffer() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(Uri.parse(myoffersURL), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['offers']
              .map((p) => Offer.fromJson(p))
              .toList();
          // we get list of posts, so we need to map each item to post model
          apiResponse.data as List<dynamic>;
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }

  static Future<ApiResponse> deletetoken() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.post(Uri.parse('$logoutURL'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        case 401:
          apiResponse.error = unauthorized;
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = serverError;
    }
    return apiResponse;
  }
}

String getOfferImageUrl(id) {
  return baseURL + '/images/$id';
}
