import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/firebase/authentication.dart';
import 'package:flutter_instagram/screens/login.dart';
import 'package:flutter_instagram/service/image_picker.dart';


import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback show;
  SignupScreen(this.show, {super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final password = TextEditingController();
  final FocusNode passwordFocus = FocusNode();
  final confirmpass = TextEditingController();
  final FocusNode confirmpassFocus = FocusNode();
  final username = TextEditingController();
  final FocusNode usernameFocus = FocusNode();
  final description = TextEditingController();
  final FocusNode descriptionFocus = FocusNode();
  Uint8List? _image;
  bool _isLoading = false;

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUp() async {
    setState(() {
      _isLoading = true;
    });
    String render = await Authentication().Signup(
      email: email.text, 
      password: password.text, 
      username: username.text, 
      description: description.text, 
      file: _image!,
      );
      setState(() {
        _isLoading = false;
      });
      if(render != 'success'){
        showSnackBar(render, context);
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Center(
              child: Image(
                image: AssetImage('images/logo-text.png'),
                height: 150,
                width: 300,
              ),
            ),
            const SizedBox(height: 20),
            Stack(  
              children: [
                _image!=null?CircleAvatar(
                  radius: 64,
                  backgroundImage: MemoryImage(_image!),
                )
                : const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                ),
                Positioned(
                  child: IconButton(  
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                    )
                  )
                )
              ],
            ),
            const SizedBox(height: 25),
            buildTextBox(email, emailFocus, "Email"),
            const SizedBox(height: 15),
            buildTextBox(username, usernameFocus, "Username"),
            const SizedBox(height: 15),
            buildTextBox(description, descriptionFocus, "Description"),
            const SizedBox(height: 15),
            buildTextBox(password, passwordFocus, "Password"),
            const SizedBox(height: 15),
            buildTextBox(confirmpass, confirmpassFocus, "Confirm Password"),
            const SizedBox(height: 15),
            InkWell(
              onTap: signUp,
              child: Container( 
                child:_isLoading ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),) 
                  : const Text('Sign up'),
                width: 370,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15),),
                  ),
                  color: Colors.blue,
                ),
                
              ),
            ),
              
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "Click Here!",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTextBox(TextEditingController controller, FocusNode focus, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 70,
        width: 370,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          controller: controller,
          focusNode: focus,
          decoration: InputDecoration(
            hintText: text,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}