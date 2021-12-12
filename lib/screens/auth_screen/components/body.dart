import 'package:flutter/material.dart';
import 'package:kalpas_news_app/screens/auth_screen/components/background.dart';
import 'package:kalpas_news_app/screens/home_screen/home_screen.dart';
import '../../../widgets/round_btn.dart';
import '../../../widgets/input_btn.dart';
import '../../auth_screen/components/form_title.dart';
import './forgot_pass.dart';
import 'package:provider/provider.dart';
import '../../../apis/auth_api.dart';
import '../../constraints.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _authFormKey = GlobalKey();

  bool isSignUp = true;
  bool isLoading = false;
  final emailController = TextEditingController();

  final passController = TextEditingController();
  final cpassController = TextEditingController();

  void changeAuthMode() {
    setState(() {
      isSignUp = !isSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    bottom: size.height * 0.2, left: size.width * 0.1),
                child: Text(
                  "Welcome!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 2.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                height: size.height * 0.6,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                decoration: BoxDecoration(
                    // color: Color.fromRGBO(248, 240, 227, 1),
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: Form(
                  key: _authFormKey,
                  child: Column(
                    children: [
                      AuthFormTitle(
                        title: isSignUp ? "Sign up" : "Sign in",
                      ),
                      InputFormField(
                        hintText: "Email",
                        inputChangeVal: (valEmail) {
                          print(valEmail);
                          setState(() {
                            emailController.text = valEmail;
                          });
                        },
                      ),
                      InputFormField(
                        hintText: "Password",
                        inputChangeVal: (valPass) {
                          // print(valPass);
                          setState(() {
                            passController.text = valPass;
                          });
                        },
                      ),
                      isSignUp
                          ? InputFormField(
                              hintText: "Confirm Password",
                              inputChangeVal: (valCpass) {
                                // print(valCpass);
                                setState(() {
                                  cpassController.text = valCpass;
                                });
                              },
                            )
                          : ForgotPassBtn(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isLoading
                              ? Container(
                                  height: size.height * 0.065,
                                  child: Center(
                                      child: CircularProgressIndicator()))
                              : RoundBtn(
                                  btnText: isSignUp ? "Sign up" : "Sign in",
                                  pressBtn: isSignUp
                                      ? () async {
                                          print("on sign up");
                                          print(_authFormKey.currentState!
                                              .validate());
                                          if (!_authFormKey.currentState!
                                              .validate()) {
                                            return;
                                          } else {
                                            // print(emailController.text);
                                            // print(passController.text);
                                            // print(cpassController.text);

                                            if (passController.text !=
                                                cpassController.text) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Confirm Password doesn't match")));
                                            } else {
                                              print("way to register new user");
                                              setState(() {
                                                isLoading = true;
                                              });
                                              try {
                                                var ss = await Provider.of<
                                                            AuthAPI>(context,
                                                        listen: false)
                                                    .signUp(
                                                        emailController.text,
                                                        passController.text);
                                                if (ss == null) {
                                                  // showAuthMsg(context,
                                                  //     "Successfully Logged in");
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          HomeScreen.routeName);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                } else {
                                                  showAuthMsg(context, ss);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                }
                                              } catch (err) {
                                                // print("ss");
                                                showAuthMsg(context,
                                                    "Something Went Wrong!");
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            }
                                          }
                                        }
                                      : () async {
                                          // print(emailController.text);
                                          // print(passController.text);
                                          print("on sign in");
                                          print(_authFormKey.currentState!
                                              .validate());

                                          if (!_authFormKey.currentState!
                                              .validate()) {
                                            return;
                                          } else {
                                            setState(() {
                                              isLoading = true;
                                            });

                                            try {
                                              var ss =
                                                  await Provider.of<AuthAPI>(
                                                          context,
                                                          listen: false)
                                                      .login(
                                                          emailController.text,
                                                          passController.text);
                                              if (ss == null) {
                                                // showAuthMsg(context,
                                                //     "Successfully Logged in");
                                                Navigator.of(context).pushNamed(
                                                    HomeScreen.routeName);

                                                setState(() {
                                                  isLoading = false;
                                                });
                                              } else {
                                                showAuthMsg(context, ss);
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }
                                            } catch (err) {
                                              // print("ss");
                                              showAuthMsg(context,
                                                  "Something Went Wrong!");
                                              setState(() {
                                                isLoading = false;
                                              });
                                            }
                                          }
                                        },
                                ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: size.width * 0.2,
                                height: 2,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              Container(
                                // color: Colors.red,
                                child: Text(
                                  "Or Sign In With",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                width: size.width * 0.2,
                                height: 2,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ],
                          ),
                          // google n other login
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Container(
                            height: size.height * 0.1,
                            // color: Colors.amber,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                    'assets/imgs/gg.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.05,
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset(
                                    'assets/imgs/fb.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      SwitchAuthMode(
                        modeBtn: isSignUp ? "Sign in" : "Sign Up",
                        modeText: isSignUp
                            ? "Already have an account?"
                            : "Dont have an account?",
                        changeMode: changeAuthMode,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchAuthMode extends StatelessWidget {
  const SwitchAuthMode(
      {Key? key,
      required this.modeBtn,
      required this.modeText,
      required this.changeMode})
      : super(key: key);

  final String modeText;
  final String modeBtn;
  final Function changeMode;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.05,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            modeText,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          TextButton(
            onPressed: () {
              print("Changing auth mode");
              changeMode();
            },
            child: Text(
              modeBtn,
              style: TextStyle(
                color: Colors.amber,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
