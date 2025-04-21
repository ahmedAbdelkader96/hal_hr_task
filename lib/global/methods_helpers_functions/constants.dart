import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static RegExp get emailRegExp => RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  static String get webClientId => dotenv.env['webClientId'].toString();
  static String get endPoint => dotenv.env['end_point'].toString();
  static String get clientId => dotenv.env['clientId'].toString();
  static String get encKey => dotenv.env['encKey'].toString();
  static String get oneSignalAppId => dotenv.env['oneSignalAppId']?? '';
  static String get oneSignalAppEndPoint => dotenv.env['oneSignalAppEndPoint']?? '';
  static String  oneSignalAuthorization = dotenv.env['oneSignalAuthorization']?? '';
  static String get androidTemplateId => dotenv.env['androidTemplateId']?? '';
  static String get androidChannelId => dotenv.env['android_channel_id']?? '';

}
