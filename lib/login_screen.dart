import 'package:flutter/material.dart';
import 'package:joke/signup_screen.dart';

import 'joke.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  String? _emailErrorText;
  String? _passwordErrorText;
  bool _isEmailValidated = false;

  void _submitt() {
    final isValid = _formKey.currentState?.validate();
    if (_emailErrorText == null  && _passwordErrorText == null) {
      _formKey.currentState?.save();
      final snackBar = SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Logged In"),
        backgroundColor: Colors.indigo,
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            // Navigator.pushNamed(context, SignUpPage.id);
          },
        ),

      );

      ScaffoldMessenger.of(context).showSnackBar(
          snackBar,

      );
     Navigator.pushNamed(context, JokeList.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.9), // Adjust the opacity here
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 120),
              child: const Icon(
                Icons.location_on_sharp,
                color: Colors.white60,
                size: 120,
              ),
            ),
            Text(
              "VISION GO",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Courier'),
            ),
            SizedBox(
              height: 150,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  // height: MediaQuery.sizeOf(context).height / 1.5,
                  // width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      )),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.all(50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome",
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 40,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "Please login with your information",
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 40),
                              TextFormField(
                                focusNode: _emailFocusNode,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  errorText: _emailErrorText,
                                  hintText: 'sandeshpaudel@gmail.com',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: _isEmailValidated ? Colors.indigo:Colors.grey),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)
                                  ),
                                  suffixIcon: _isEmailValidated ? Icon(
                                    Icons.check,color: Colors.indigo,):null,

                                ),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  setState(() {
                                    RegExp emailRegExp = RegExp(
                                        r"^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$");
                                    if (value!.isEmpty) {
                                      _emailErrorText =
                                          "Please enter the email";
                                      _isEmailValidated=false;
                                    } else if (!emailRegExp.hasMatch(value)) {
                                      _emailErrorText = "Invalid Email Format";
                                      _isEmailValidated=false;
                                    }else{
                                      _emailErrorText=null;
                                      _isEmailValidated=true;
                                    }
                                  });
                                },
                                onEditingComplete: () {
                                  if(_isEmailValidated)
                                    {
                                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                                    }
                                },
                                onChanged: (email) {
                                  setState(() {
                                    _emailErrorText = null;
                                    _isEmailValidated=false;
                                  });
                                },
                                onFieldSubmitted: (value) {},
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                focusNode: _passwordFocusNode,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    errorText: _passwordErrorText,
                                    labelText: 'Password',
                                    hintText: '************',
                                    labelStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.indigo),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                      child: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.indigo,
                                      ),
                                    )),
                                obscureText: !_isPasswordVisible,
                                validator: (value)
                                {
                                  setState(() {
                                    if(value!.isEmpty){

                                      _passwordErrorText="Please enter the password";
                                    }
                                    else if(value.length<8)
                                    {
                                      _passwordErrorText="Password must be min 8 character";
                                    }
                                  });
                                  return null;
                                },
                                onChanged: (value)
                                {
                                  setState(() {
                                    _passwordErrorText=null;
                                  });
                                },
                                onFieldSubmitted: (value){},
                              ),
                              SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Checkbox(
                                      value: _rememberMe,
                                      checkColor: Colors.indigo,
                                      activeColor: Colors.grey[300],
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = !_rememberMe;
                                        });
                                      }),
                                  Text(
                                    "Remember Me",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(width: 70),
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      //Navigator.pushNamed(context, SignUpScreen.id);
                                    },
                                    child: Text(
                                      "Forget Password?",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  _submitt();
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 30),
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.blue.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3))
                                      ]),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "LOGIN",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                ),
                              ),

                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: ()
                                {
                                  Navigator.pushNamed(context, SignUpScreen.id);
                                },
                                child: Center(
                                  child: Text("Don't have an account? Sign Up",
                                      textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.redAccent),),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
