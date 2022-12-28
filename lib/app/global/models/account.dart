import 'package:shared_preferences/shared_preferences.dart';

class AccountData {
  String id;
  String token;
  String address;
  String pass;
  String domain;

  AccountData({
    required this.id,
    required this.token,
    required this.address,
    required this.pass,
    required this.domain,
  });

  factory AccountData.create() => AccountData(
        id: "",
        token: "",
        address: "",
        pass: "",
        domain: "",
      );

  Future<void> loadData() async {
    final shared = await SharedPreferences.getInstance();

    id = shared.getString("id") ?? "";
    token = shared.getString("token") ?? "";
    address = shared.getString("address") ?? "";
    pass = shared.getString("pass") ?? "";
    domain = shared.getString("domain") ?? "";
  }

  Future<bool> setData({required String key, required String value}) async {
    final shared = await SharedPreferences.getInstance();

    return await shared.setString(key, value);
  }

  bool isValidAccount() {
    return id.trim().isNotEmpty &&
        token.trim().isNotEmpty &&
        address.trim().isNotEmpty &&
        pass.trim().isNotEmpty &&
        domain.trim().isNotEmpty;
  }

  Future<void> removeDataAccount() async {
    final shared = await SharedPreferences.getInstance();

    await shared.remove("id");
    await shared.remove("address");
    await shared.remove("token");
    await shared.remove("pass");
    await shared.remove("domain");

    id = "";
    token = "";
    address = "";
    pass = "";
    domain = "";
  }
}
