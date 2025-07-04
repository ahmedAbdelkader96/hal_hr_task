import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:task/features/menu/repository/irepository.dart';
import 'package:task/global/methods_helpers_functions/local_storage_helper.dart';

class MenuRepository implements IMenuRepository {
  @override
  Future<void> signOut() async {
    try {
      await LocalStorageHelper.clearUserMainData();
      //await OneSignal.logout();
      await OneSignal.User.removeTag('userId');

    } catch (e) {
      rethrow;
    }
  }
}
