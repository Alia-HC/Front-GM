import 'package:flutter/material.dart';
import 'package:goal_minder/login.dart';
import 'package:goal_minder/new_event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool notValid = false;

  Future<void> register() async {
    var url = Uri.parse('http://10.0.2.2:3002/api/users/signup');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': userController.text,
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registro correcto'),
        ),
      );
      userController.clear();
      emailController.clear();
      passwordController.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewEvent()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(responseJson['message']),
        ),
      );
    }
  }

  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 242, 220, 1),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image.png',
                height: 180,
                width: 180,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 50.0),
                child: Text(
                  'Sign up',
                  style: GoogleFonts.sansita(
                    fontSize: 57,
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 8, 8, 8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(228, 199, 225, 221),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    errorText: notValid ? "Campo vacío" : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(224, 2, 114, 129),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Username',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(224, 2, 114, 129)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(228, 199, 225, 221),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    errorText: notValid ? "Campo vacío" : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(224, 2, 114, 129),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: 'Email',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(224, 2, 114, 129)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(228, 199, 225, 221),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    errorText: notValid ? "Campo vacío" : null,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(224, 2, 114, 129),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: 'Password',
                    labelStyle:
                        TextStyle(color: Color.fromARGB(224, 2, 114, 129)),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Log()),
                    );
                  },
                  child: Text("Already have an account? Login here")),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 217, 235, 82),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                onPressed: () {
                  register();
                },
                child: Text(
                  'Sign up',
                  style: GoogleFonts.kurale(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
