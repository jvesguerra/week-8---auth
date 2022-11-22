// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/providers/auth_provider.dart';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lasttNameController = TextEditingController();

    bool _validateEmail = false;
    bool _validatePassword = false;
    bool _validateFirstName = false;
    bool _validateLastName = false;

    final email = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
      validator: (email) {
        if (email != null && email.length == 0) {
          return 'Email required';
        } else if (email != null && !EmailValidator.validate(email)) {
          return 'Email a valid email';
        } else {
          return null;
        }
      },
    );

    //First name
    final firstName = TextFormField(
        controller: firstNameController,
        decoration: InputDecoration(
          hintText: "First Name",
        ),
        validator: (value) {
          if (value != null && value.length == 0) {
            return 'First Name Required';
          } else {
            return null;
          }
        });
    //Last name
    final lastName = TextFormField(
        autofocus: true,
        controller: lasttNameController,
        decoration: InputDecoration(
          hintText: "Last Name",
        ),
        validator: (value) {
          if (value != null && value.length == 0) {
            return 'Last Name Required';
          } else {
            return null;
          }
        });

    final password = TextFormField(
        controller: passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Password',
        ),
        validator: (value) {
          if (value != null && value.length == 0) {
            return 'Password required';
          } else if (value != null && value.length < 6) {
            return 'Enter valid password';
          } else {
            return null;
          }
        });

    final SignupButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          final isValidForm = formKey.currentState!.validate();

          if (isValidForm) {
            context.read<AuthProvider>().signUp(
                emailController.text,
                passwordController.text,
                firstNameController.text,
                lasttNameController.text);
            Navigator.pop(context);
          }
        },
        child: const Text(
          'Sign up',
          style: TextStyle(color: Colors.white),
        ),
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
      body: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: formKey,
        child: Center(
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
      ),
    );
  }
}
