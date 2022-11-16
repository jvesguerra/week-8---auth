import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/providers/auth_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lasttNameController = TextEditingController();

    final email = TextField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
    );

    //First name
    final firstName = TextField(
      controller: firstNameController,
      decoration: const InputDecoration(
        hintText: "First Name",
      ),
    );
    //Last name
    final lastName = TextField(
      controller: lasttNameController,
      decoration: const InputDecoration(
        hintText: "Last Name",
      ),
    );

    final password = TextField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
    );

    final SignupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          context.read<AuthProvider>().signUp(
              emailController.text,
              passwordController.text,
              firstNameController.text,
              lasttNameController.text);
          Navigator.pop(context);
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            email,
            firstName,
            lastName,
            password,
            SignupButton,
            backButton
          ],
        ),
      ),
    );
  }
}
