import 'package:flutter/material.dart';
import 'package:responsi/pages/login.dart';
import 'package:responsi/services/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Inisialisasi state
  String username = "";
  String password = "";
  String confirmPassword = ""; // Variabel untuk confirm password
  final _formKey = GlobalKey<FormState>(); // Kunci untuk form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Padding untuk tampilan yang lebih baik
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Padding untuk TextFormField username
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    onChanged: (value) {
                      username = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null; // Validasi sukses
                    },
                  ),
                ),
                // Padding untuk TextFormField password
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true, // Menyembunyikan password
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null; // Validasi sukses
                    },
                  ),
                ),
                // Padding untuk TextFormField confirm password
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true, // Menyembunyikan confirm password
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != password) {
                        return 'Passwords do not match'; // Validasi tidak cocok
                      }
                      return null; // Validasi sukses
                    },
                  ),
                ),
                SizedBox(height: 20), // Jarak antara input dan tombol
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Menyimpan data ke local
                      authServices.simpanAkun(username, password);

                      // Arahkan ke halaman login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    }
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor:
          Colors.grey[200], // Warna latar belakang yang lebih cerah
    );
  }
}
