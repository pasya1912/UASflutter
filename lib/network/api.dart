import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gymapp/controllers/session_controller.dart';
import 'package:http/http.dart' as http;
//dotenv
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api extends GetxController {
  final String _url = dotenv.env['API_URL'] ?? 'http://localhost:8000/';
  final box = GetStorage();
  final sessionController = Get.put(SessionController());

  var token;

  Map<String, String> _setHeaders(Map<String, String>? head) {
    return {
      'Content-type': 'application/json',
      'User-Agent': 'insomnia/8.2.0',
      ...?head,
    };
  }

  Future login(String nomor, String password) async {
    var path = 'api/login';

    var data = {
      'nomor': nomor,
      'password': password,
    };
    var result = await post(path, data, {});
    return result;
  }

  Future<void> logout() async {
    var path = 'api/logout';
    token = box.read('token');
    
    var result = await get(path, {"Authorization": "Bearer $token"});

    var check = jsonDecode(result.body);
    if (check['status'] == 200) {
      sessionController.logout();
      return;
    }
  }

  Future post(
      String path, final body, final Map<String, String> headers) async {
    var fullUrl = _url + path;
    var result = await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(body),
      headers: _setHeaders(headers),
    );
    return result;
  }

  Future get(String path, final Map<String, String> headers) async {
    var fullUrl = _url + path;

    var result = await http.get(
      Uri.parse(fullUrl),
      headers: _setHeaders(headers),
    );


      return result;
    
  }

  Future me() async {
    var path = 'api/user';
    token = box.read('token');

    var result = await get(path, {"Authorization": "Bearer $token"});
    try {
      var check = jsonDecode(result.body);

      if (check['status'] != 200) {
        sessionController.logout();
        return;
      } else {
        return result;
      }
    } catch (e) {
      sessionController.logout();
      return;
    }
  }

  Future addLatihan() async {
    var path = 'api/latihan';
    token = box.read('token');

    var result = await post(path, "", {"Authorization": "Bearer $token"});
    try {
      var check = jsonDecode(result.body);
      if (check['status'] != 200) {
        sessionController.logout();
        return;
      } else {
        return result;
      }
    } catch (e) {
      sessionController.logout();
      return;
    }
  }

  Future getLatihan([int? limit, int? page = 1]) async {
    var path = 'api/latihan?';
    if (limit != null) {
      path += 'limit=$limit';
    }
    if (page != null && limit != null) {
      path += '&page=$page';
    }

    token = box.read('token');
    var result = await get(path, {"Authorization": "Bearer $token"});
    try {
      var check = jsonDecode(result.body);
      if (check['status'] != 200) {
        sessionController.logout();
        return;
      } else {
        return result;
      }
    } catch (e) {
      sessionController.logout();
      return;
    }
  }

  Future updateProfile(var data) async {
    var datas = {};
    if (data['nama'] != null) {
      datas['nama'] = data['nama'];
    }
    if (data['alamat'] != null) {
      datas['alamat'] = data['alamat'];
    }
    if (data['old_password'] != null) {
      datas['old_password'] = data['old_password'];
    }
    if (data['new_password'] != null) {
      datas['new_password'] = data['new_password'];
    }

    var path = 'api/user';
    token = box.read('token');

    var result = await post(path, datas, {"Authorization": "Bearer $token"});

    try {
      var check = jsonDecode(result.body);
      
      if (check['status'] == 200 || check['status'] == 400) {
        return result;
      } else {
        sessionController.logout();
        return;
      }
    } catch (e) {
      sessionController.logout();
      return;
    }
  }

  Future getDashboard() async {
    var path = 'api/admin/dashboard';
    token = box.read('token');

    var result = await get(path, {"Authorization": "Bearer $token"});
    try {
      var check = jsonDecode(result.body);
      if (check['status'] != 200) {
        sessionController.logout();
        return;
      } else {
        return result;
      }
    } catch (e) {
      sessionController.logout();
      return;
    }
  }

  Future getUsers([int? limit, int? page = 1]) async {
    var path = 'api/admin/users';
    token = box.read('token');

    if (limit != null) {
      path += '?limit=$limit';
    }
    if (page != null && limit != null) {
      path += '&page=$page';
    }

    var result = await get(path, {"Authorization": "Bearer $token"});
    try {
      var check = jsonDecode(result.body);
      if (check['status'] == 200 || check['status'] == 400) {
        return result;
      } else {
        sessionController.logout();
        return;
      }
    } catch (e) {
      sessionController.logout();
      return;
    }
  }

  Future addUser(
      String? nama, String? nomor, String? alamat, String? password) async {
    var path = 'api/admin/users/add';
    token = box.read('token');

    var data = {
      'nama': nama,
      'nomor': nomor,
      'alamat': alamat,
      'password': password,
    };

    var result = await post(path, data, {"Authorization": "Bearer $token"});
    try {
      var check = jsonDecode(result.body);
      if (check['status'] == 200 || check['status'] == 400) {
        return result;
      } else {
        sessionController.logout();
        return;
      }
    } catch (e) {
      sessionController.logout();
      return;
    }
  }

  Future addMembership(int? idUser, String? hari) async {
    var path = 'api/admin/users/$idUser';
    token = box.read('token');

    //hari to int

    var data = {
      "add_membership": hari,
    };
    

    var result = await post(path, data, {"Authorization": "Bearer $token"});
    try {
      var check = jsonDecode(result.body);
      if (check['status'] == 200 || check['status'] == 400) {
        return result;
      } else {
        sessionController.logout();
        return;
      }
    } catch (e) {
      sessionController.logout();
      return;
    }
  }

    Future getLatihanUsers([int? limit, int? page = 1]) async {
    var path = 'api/admin/latihan?';
    if (limit != null) {
      path += 'limit=$limit';
    }
    if (page != null && limit != null) {
      path += '&page=$page';
    }

    token = box.read('token');
    var result = await get(path, {"Authorization": "Bearer $token"});
    try {
      var check = jsonDecode(result.body);
      if (check['status'] == 200 || check['status'] == 400) {
        return result;
      } else {
        sessionController.logout();
        return;
      }
    } catch (e) {
      sessionController.logout();
      return;
    } 
  }
}
