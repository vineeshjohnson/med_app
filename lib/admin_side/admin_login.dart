// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:med_app/admin_side/admin_bottom_nav.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _adminId = TextEditingController();
  final TextEditingController _adminPw = TextEditingController();
  final _formKeyad = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKeyad,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/Admin-bro.png',
                      height: 400,
                    ),
                    // const SizedBox(height: 1),
                    const Text('Welcome to Admin pannel'),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        // key: _formKeyad,
                        controller: _adminId,
                        validator: (username) {
                          if (username == null || username.isEmpty) {
                            return 'Enter a username';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'User Name',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                        controller: _adminPw,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Enter your password';
                          } else {
                            return null;
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade200),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        if (_formKeyad.currentState!.validate()) {
                          _formKeyad.currentState?.save();

                          if (_adminId.text == 'admin' &&
                              _adminPw.text == 'password') {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.topSlide,
                              showCloseIcon: true,
                              title: 'Success',
                              desc: 'Login successful',
                              btnOkOnPress: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return const AdminBottomNav();
                                }));
                              },
                            ).show();
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.topSlide,
                              showCloseIcon: true,
                              title: 'Error',
                              desc: 'Incorrect ID or Password',
                              btnOkOnPress: () {},
                            ).show();
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        fixedSize: const Size(200, 60),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
