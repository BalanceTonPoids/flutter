import 'dart:developer';

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Column(
        children: [
          registerForm()
        ],
      )
    );
  }

  Column buildRegister() {
    return Column(
      children: <Widget>[
        TextField(
              controller: _emailController,
            decoration: const InputDecoration(
                labelText: "Email",
                hintText: "example@gmail.com"
            )
        ),
        TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Password",
                hintText: "Password"
            )
        ),
        TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Confirm Password",
                hintText: "Confirm Password"
            )
        ),
      ],
    );
  }

  Form registerForm() {
    final registerKey = GlobalKey<FormState>();
    return Form(
      key: registerKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            validator: (String? value) {
              if (value == null || value.isEmpty || RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) == false) {
                return "Veuillez entrer une adresse email valide";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "example@gmail.com"
            )
          ),
          ElevatedButton(
              onPressed: () {
                if (registerKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Processing Data"))
                  );
                }
              },
              child: const Text("Register"))
        ]
      )
    );
  }
}