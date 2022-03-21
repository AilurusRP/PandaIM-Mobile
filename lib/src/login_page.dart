import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";

import "login_page.style.dart";
import "home_page.dart";
import "config.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _unameController = TextEditingController(),
      _passwdController = TextEditingController();

  @override
  void initState() {
    debugPrint("init state");
    checkToken(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loginColumn(
      [
        loginRow([
          loginText("Username: "),
          loginTextField(_unameController, FieldType.username)
        ]),
        loginRow([
          loginText("Password: "),
          loginTextField(_passwdController, FieldType.password)
        ]),
        loginBtn(() => login(_unameController, _passwdController, context))
      ],
    );
  }
}

Future<void> login(TextEditingController unameController,
    TextEditingController passwdController, BuildContext context) async {
  if (await readToken() == null) {
    requestToken(unameController.text, passwdController.text, context);
  } else {
    goToHomePage(context);
  }
}

requestToken(String uname, String passwd, BuildContext context) async {
  var uri = Uri.parse("$host:$port/login");
  debugPrint("$uri");
  var response = jsonDecode(
      (await http.post(uri, body: {"uname": uname, "passwd": passwd})).body);
  debugPrint(response["token"]);
  if (response["success"]) goToHomePage(context);
  await saveToken(response['token']);
}

saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
}

Future<String?> readToken() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  return token;
}

goToHomePage(BuildContext context) {
  debugPrint("Go To Home Page...");
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const HomePage()));
}

checkToken(context) async {
  if (await readToken() != null) goToHomePage(context);
}
