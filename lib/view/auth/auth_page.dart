import 'package:campus/view/config/%20colors.dart';
import 'package:campus/view/config/input_dec.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}
class _AuthPageState extends State<AuthPage> {
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: primaryColor.withAlpha(200),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              height: size.height * (isLogin ? 0.55 : 0.67),
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color.fromARGB(255, 207, 205, 205)),
              child: Column(
                children: [
                  Container(
                    height: 10,
                    width: 4,
                    color: primaryColor,
                  ),
                  const CircleAvatar(
                    radius: 14.5,
                    backgroundColor: primaryColor,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: isLogin
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      Text(
                        isLogin
                            ? "Welcome back you have been missed!"
                            : "Welcome! We're glad to see you here. ",
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade800),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        isLogin ? "Login" : "Sign In",
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                  Form(
                      child: Column(
                    mainAxisAlignment: !isLogin
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      !isLogin
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: size.width * 0.4,
                                  child: TextFormField(
                                      style: const TextStyle(fontSize: 12),
                                      decoration: myInputDecoration),
                                ),
                                SizedBox(
                                  width: size.height * 0.02,
                                ),
                                SizedBox(
                                  width: size.width * 0.4,
                                  child: TextFormField(
                                      style: const TextStyle(fontSize: 12),
                                      decoration: myInputDecoration.copyWith(
                                          hintText: "Second Name")),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      !isLogin
                          ? SizedBox(
                              height: size.height * 0.02,
                            )
                          : const SizedBox(),
                      !isLogin
                          ? TextFormField(
                              style: const TextStyle(fontSize: 12),
                              keyboardType: TextInputType.phone,
                              decoration: myInputDecoration.copyWith(
                                hintText: "Phone",
                              ),
                            )
                          : const SizedBox(),
                      !isLogin
                          ? SizedBox(
                              height: size.height * 0.02,
                            )
                          : const SizedBox(),
                      TextFormField(
                        style: const TextStyle(fontSize: 12),
                        decoration:
                            myInputDecoration.copyWith(hintText: "Email"),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      TextFormField(
                        obscureText: true,
                        style: const TextStyle(fontSize: 12),
                        decoration:
                            myInputDecoration.copyWith(hintText: "Password"),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: Text(isLogin ? "Login" : "Sign up")),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          },
                          child: Text(
                            isLogin
                                ? "Already have an account? Login"
                                : "Want to create an account? Sign up",
                            style: const TextStyle(color: primaryColor),
                          )),
                      TextButton(
                          onPressed: () {

                          },
                          child: const Text(
                            'Get in as a guest',
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}