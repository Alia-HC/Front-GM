import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class LogIn extends StatefulWidget {
  const LogIn({super.key});
  
  @override
  State<LogIn> createState() => LoginState();
}

class LoginState extends State<LogIn> {
  FocusNode myFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromRGBO(240, 242, 220, 1),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 90.0),
        children: <Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image.png',
                height: 180,
                width: 180,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 50.0),
                child: Text(
                  'Login',
                  style: GoogleFonts.sansita(
                    fontSize: 58,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              
              SizedBox(
                width: 350, 
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(228, 199, 225, 221), 
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(224, 2, 114, 129), width: 2),
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      labelText: 'Username',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(224, 2, 114, 129)
                      )
                    ),
                )
              ),

              SizedBox(height: 20),

              SizedBox(
                width: 350,
                  child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    labelText: 'Email',
                  ),
                )
              ),

              SizedBox(height: 20),

              SizedBox(
                width: 350,
                  child: TextField(
                    obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    labelText: 'Password',
                  ),
                )
              )
            ],
          ),
        ],
      ),
    );
  }
}
