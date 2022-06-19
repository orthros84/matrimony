import 'package:matrimony_final_2022/database/database_helper.dart';
import 'package:matrimony_final_2022/model/userMeta.dart';

class DbService {
  Future<List<User>> getSearch(String a) async {
    await DataBasehelper.init();

    List<Map<String, dynamic>> user = await DataBasehelper.query(a);

    return user.map((item) => User.fromMap(item)).toList();
  }

  Future<List<User>> getfav() async {
    await DataBasehelper.init();

    List<Map<String, dynamic>> user = await DataBasehelper.getfav();

    return user.map((item) => User.fromMap(item)).toList();
  }

  Future<bool> setFav(int n, int id) async {
    await DataBasehelper.init();

    int ret = await DataBasehelper.setfav(n, id);
    return ret > 0 ? true : false;
  }

  Future<List<User>> getUser() async {
    await DataBasehelper.init();

    List<Map<String, dynamic>> user = await DataBasehelper.details(userTable);

    return user.map((item) => User.fromMap(item)).toList();
  }

  Future<bool> addUser(User meta) async {
    await DataBasehelper.init();

    bool isSaved = false;
    int ret = await DataBasehelper.insert(userTable, meta);
    return ret > 0 ? true : false;
  }

  Future<bool> updateUser(User meta) async {
    await DataBasehelper.init();

    bool isSaved = false;
    int ret = await DataBasehelper.update(userTable, meta);
    return ret > 0 ? true : false;
  }

  Future<bool> deleteUser(User meta) async {
    await DataBasehelper.init();

    bool isSaved = false;
    int ret = await DataBasehelper.delete(userTable, meta);
    return ret > 0 ? true : false;
  }
}
