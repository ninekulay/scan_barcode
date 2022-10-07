import 'package:flutter/material.dart';
import 'api_manage.dart';
import 'qr_scan.dart';
import 'preference_manage.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final MyApiManagement myApi = MyApiManagement();
  final PresferenceManagement myPref = PresferenceManagement();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: myApi.beforeInitial(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBar: AppBar(title: const Text("Connect Server")),
            body: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Image.asset('assets/icon/icon.png',
                        fit: BoxFit.contain),
                  ),
                  const Text('Please wait...',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          );
          // return ListView(
          //   children: [
          //     Expanded(
          //       child: Image.asset('assets/icon/icon.png', fit: BoxFit.contain),
          //     ),
          //     const Text('Plese wait...',
          //         textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
          //   ],
          // );
        } else {
          if (snapshot.hasError)
            // ignore: curly_braces_in_flow_control_structures
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            // ignore: curly_braces_in_flow_control_structures
            return Scaffold(
              appBar: AppBar(title: const Text('Login Page')),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                        initialValue: 'Server : ${snapshot.data['username']}'),
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          // ignore: unrelated_type_equality_checks
                          if (usernameController != "" &&
                              // ignore: unrelated_type_equality_checks
                              passwordController != "") {
                            Map<String, dynamic> data = {
                              "username": usernameController.text,
                              "password": passwordController.text
                            };
                            var checkLogin = await myApi.userLogin(data);
                            if (checkLogin == true) {
                              var checkLocalSave =
                                  await myPref.userLogControl(data['username']);
                              if (checkLocalSave == true) {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const QRViewExample(),
                                ));
                              } else {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('Login fail!!'),
                                          content:
                                              const Text('กรุณาติดต่อ Support'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ));
                              }
                            } else {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Login fail!!'),
                                  content: const Text(
                                      'กรุณาตรวจสอบ username , password'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Login QR Code system'),
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
