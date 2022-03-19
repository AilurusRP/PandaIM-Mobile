import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

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
  var uname = unameController.text, passwd = passwdController.text;
  var uri = Uri.parse("$host:$port/login?uname=$uname&passwd=$passwd");
  var response = jsonDecode((await http.get(uri)).body);
  debugPrint(response["text"]);
  if (response["success"]) goToHomePage(context);
}

goToHomePage(BuildContext context) {
  debugPrint("Go To Home Page...");
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => const HomePage()));
}
