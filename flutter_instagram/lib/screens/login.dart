import 'package:flutter_instagram/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/firebase/authentication.dart';
import 'package:flutter_instagram/service/image_picker.dart';
import 'package:flutter_instagram/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key:key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
  
class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  FocusNode email_foc = FocusNode();
  final password = TextEditingController();
  FocusNode password_foc = FocusNode();
  bool _isLoading = false;

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authentication().login(
      email: email.text, 
      password: password.text);
      if(res == "success"){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const HomeScreen())
            );
      }else {
        showSnackBar(res, context);
      }
      setState(() {
        _isLoading = false;
      });
  }
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFEEF6FF),
      body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 150),
          const Center(
            child: Image(
              image: AssetImage('images/instagram_logo.png'),
              height: 100,
              width: 100,
            ),
          ),
          const SizedBox(height: 50),
          Textbox(email, email_foc, 'Username, email or mobile number'),
          const SizedBox(height: 25),
          Textbox(password, password_foc, 'Password'),
          const SizedBox(height: 25),
          InkWell(  
      onTap: loginUser,
      child: Container(  
          child: _isLoading ?
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
            : const Text(
              'Log in',
              style: TextStyle(color: Colors.white),
            ),
            width: 390,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(  
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              color: Colors.blue,
            ),
        ),
      ),
          const SizedBox(height: 230),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => SignupScreen(() { })),
              );
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size(390,60)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
               RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), 
                side: BorderSide(color: Color(0xFF0062DD)),
            ),
    ),
            ),
            child: const Text(
              "Create New Account",
              style: TextStyle(  
              fontSize: 15,
              color: Color(0xFF0062DD),
            ),
              ),
          )
        ],
        )
      ),
    );
  }
} 

Padding Textbox(TextEditingController x, FocusNode focus, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Container(  
      height: 70,
      decoration: BoxDecoration(  
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(  
        style: TextStyle(fontSize: 16, color: Colors.black),
        controller: x,
        focusNode: focus,
        decoration: InputDecoration(  
          hintText: text,
          contentPadding:
                EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.grey, 
              ),
        ),
          focusedBorder: OutlineInputBorder(  
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(  
              width: 2,
              color: Colors.black,
            )
          )
        ),
      ),
    ),
  );
}

