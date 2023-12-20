import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymapp/admin/home_page.dart';
import 'package:gymapp/login_page.dart';
import 'package:gymapp/user/home_page.dart';

class SessionController extends GetxController {
  final box = GetStorage();

  checkLogin() {
    if (box.read('token') != null) {
      if (box.read('role') == 'user') {
        return const HomePage();
      } else if (box.read('role') == 'admin') {
        return const AdminHomePage(); 
      }else{
        return const LoginPage();
      }
    } else {
      return const LoginPage();
    }
  }

  logout() async {
    //box remove all
    await box.erase();
    Get.offAll(const LoginPage());
  }
}
