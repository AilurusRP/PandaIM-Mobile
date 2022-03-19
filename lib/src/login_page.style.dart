import 'package:flutter/material.dart';

enum FieldType { username, password }

Widget loginColumn(List<Widget> childList) {
  return Scaffold(
      body: Center(
          child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: childList,
  )));
}

Widget loginText(String childText) {
  return Container(
    alignment: Alignment.centerRight,
    width: 85,
    margin: const EdgeInsets.only(right: 10),
    child: Text(
      childText,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}

Widget loginRow(List<Widget> childList) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: childList,
      ));
}

Widget loginBtn(void Function()? loginFn) {
  return Container(
      height: 30,
      width: 500,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: ElevatedButton(
        onPressed: loginFn,
        child: const Text(
          "LOGIN",
          style: TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.brown),
        ),
      ));
}

Widget loginTextField(TextEditingController controller, FieldType fieldType) {
  return Flexible(
      child: TextField(
    obscureText: fieldType == FieldType.password,
    controller: controller,
  ));
}
