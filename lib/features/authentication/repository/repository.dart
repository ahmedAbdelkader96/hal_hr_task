import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:task/features/authentication/models/user_model.dart';
import 'package:task/features/authentication/repository/irepository.dart';
import 'package:task/global/methods_helpers_functions/constants.dart';

class AuthRepository implements IAuthRepository {
  @override
  Future<UserModel?> fetchUserData({required String id}) async {
    try {
      var url = Uri.parse('${Constants.endPoint}/user?id=$id');
      var res = await http.get(url).timeout(const Duration(seconds: 60));
      var data = jsonDecode(res.body);
      UserModel userModel = UserModel.fromJson(data);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      var body = {
        "name": name,
        "email": email,
        "password": password,
        "authenticationType": 'email',
      };

      var url = Uri.parse('${Constants.endPoint}/user/signup_email');
      var res = await http
          .post(url, body: body)
          .timeout(const Duration(seconds: 60));

      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var body = {"email": email, "password": password};
      var url = Uri.parse('${Constants.endPoint}/user/login_email');
      var res = await http
          .post(url, body: body)
          .timeout(const Duration(seconds: 60));
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> signWithGoogle() async {
    try {
      String webClientId = Constants.webClientId;

      String clientId = Constants.clientId;

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: clientId,
        serverClientId: webClientId,
      );
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        var body = {
          "name": googleUser.displayName.toString(),
          "email": googleUser.email,
          "googleId": googleUser.id,
        };

        var url = Uri.parse('${Constants.endPoint}/user/check_google');
        var res = await http
            .post(url, body: body)
            .timeout(const Duration(seconds: 60));
        googleSignIn.signOut();
        return res;
      } else {
        throw 'Error Occurred!';
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<http.Response> renewToken({required String refreshToken}) async {
    try {
      var body = {"refreshToken": refreshToken};
      var url = Uri.parse('${Constants.endPoint}/user/renew_token');
      var res = await http
          .post(url, body: body)
          .timeout(const Duration(seconds: 60));
      return res;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendNotification({
    required String title,
    required String body,
    required String externalId,
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': Constants.oneSignalAuthorization,
      'Accept': 'application/json',
    };
    var request = http.Request(
      'POST',
      Uri.parse(Constants.oneSignalAppEndPoint),
    );
    request.body = json.encode({
      "app_id": Constants.oneSignalAppId,
      "android_template_id": Constants.androidTemplateId,
      "filters": [
        {"field": "tag", "key": "userId", "relation": "=", "value": externalId},
      ],
      "target_channel": "push",
      "headings": {"en": title},
      "contents": {"en": body},
      "ios_sound": "awesome_sound.wav",
      "android_channel_id": Constants.androidChannelId,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
