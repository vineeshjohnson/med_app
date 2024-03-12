import 'package:flutter/material.dart';
import 'package:med_app/functions_user/login_logic.dart';
import 'package:med_app/screens/bottom_nav.dart';
import 'package:med_app/screens/screen_registration.dart';
import 'package:med_app/admin_side/admin_login.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:med_app/boxes.dart';
import 'package:med_app/hive/person.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();

  @override
  // void initState() {
  //   super.initState();
  //   LoginLogic.init(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.green],
              stops: [0.0, 1.0],
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/Hospital wheelchair-amico.png',
                        height: 250,
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      const Text(
                        'Welcome Back to the Application',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          controller: _username,
                          validator: (username) {
                            if (username == null || username.isEmpty) {
                              return 'Enter a username';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontFamily: 'Outfit'),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
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
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Enter your password';
                            } else {
                              return null;
                            }
                          },
                          controller: _password,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontFamily: 'Outfit',
                              color: Colors.grey.shade500,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            LoginLogic.saveLoginDetails(
                                _username.text, _password.text);
                            final person =
                                boxPerson.get('key_${_username.text}');
                            if (person != null &&
                                person is Person &&
                                person.password == _password.text) {
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
                                      return const BottomNav();
                                    }),
                                  );
                                },
                              ).show();
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.topSlide,
                                showCloseIcon: true,
                                title: 'Error',
                                desc: 'Incorrect email or password',
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
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'If you don\'t have an account?',
                            style: TextStyle(
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ScreenRegistration();
                                  },
                                ),
                              );
                            },
                            child: const Text('Register now'),
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const AdminLogin();
                            }));
                          },
                          child: const Text('Login as Admin'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
