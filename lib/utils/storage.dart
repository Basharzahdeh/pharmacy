import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final box = GetStorage();
  //read login value
  Future<bool> getLoginValue() async {
    if (await box.read('login') != null || await box.read('login') == true) {
      return true;
    }
    return false;
  }

  Future<bool> getSkipValue() async {
    if (await box.read('wait') != null || await box.read('wait') == true) {
      return true;
    }
    return false;
  }

  Future<void> setLoginSkip() async {
    await box.write('wait', true);
  }

  //write login value
  Future<void> setLoginValue() async {
    await box.write('login', true);
  }

  Future<void> setTokenValue(String tok) async {
    await box.write("token", tok);

  }

  String getTokenValue() {
      final y=  box.read("token");
        return y;
    /*String t;
    FirebaseMessaging messaging;
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      try {
        print('val car:' + value);
        t = value;
        return value;
      } catch (err) {
        print('token error:' + err);
      }
    });
    return t;*/
  }

  //read uid
    getUid() {
    final i =  box.read('uid');
    return i;
  }

  //write uid
  Future<void> setUid(String uid) async {
    await box.write('uid', uid);

  }


  //read check
  getcheck() {
    final i =  box.read('check');
    return i;
  }

  //write check
  Future<void> setcheck(bool check) async {
    await box.write('check', check);

  }
}
