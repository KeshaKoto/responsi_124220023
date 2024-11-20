import 'package:flutter/material.dart';
import 'package:responsi/pages/list.dart';
import 'package:responsi/services/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //inisiasi state
  String username = '';
  String password = '';
  bool isVisible = false;
  bool isClicked = false;

  //function redirect
  _navigateToHome() async {
    //fungsinya ga beraturan
    await Future.delayed(Duration(seconds: 3));

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
        body: Column(
          children: [
            _usernameField(),
            _passwordField(),
            _loginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        onChanged: (value) {
          username = value;
        },
        decoration: InputDecoration(
            hintText: 'Username',
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        enabled: true,
        obscureText: isVisible,
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
            suffix: IconButton(
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              icon: Icon(Icons.visibility),
            ),
            hintText: 'Password',
            contentPadding: EdgeInsets.all(8),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () async {
          String text = '';
          Future<bool> loginSuccess = authServices.login(username, password);
          if (await loginSuccess) {
            _navigateToHome();

            setState(() {
              text = 'Login Berhasil';
              isClicked = !isClicked;
            });
          } else {
            setState(() {
              text = 'Login Gagal';
              isClicked = false;
            });
          }

          SnackBar snackBar = SnackBar(
            content: Text(text),
            backgroundColor: isClicked ? Colors.green : Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Text(
          "Login",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
