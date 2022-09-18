import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
  
class LoginForm extends StatefulWidget {
  const LoginForm({ Key? key }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(   
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(8),
      child: SingleChildScrollView(       
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                labelText: "email",                    
                icon: Icon(Icons.email, color: Colors.black),
                ),
                validator: (value) {  // password VALIDATION
                  if (value!.trim().isEmpty) {
                    return 'email is required';
                  }
                  else if(value.length<3)
                  {
                    return 'email must have atleast 3 ';
                    //and atmost 16 characters
                  }
                  else if(!value.contains(RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')))
                  {
                    return 'email should be look like : example@domain.com';
                  }
                    return null;                        
                },
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,                      
                decoration: const InputDecoration(                        
                  labelText: "password", 
                  icon: Icon(Icons.lock, color: Colors.black),                  
                ),
                validator: (value) {  // password VALIDATION
                  if (value!.trim().isEmpty) {
                    return 'Password is required';
                  }
                  else if(value.length<8)
                  {
                    return 'Password must have atleast 8 ';
                    //and atmost 16 characters
                  }
                  else if(value.length>16)
                  {
                    return 'Password must have atmost 16 ';
                  }
                  else if(!value.contains(RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')))
                  {
                    return 'Password must contain: atleast one alphabet, \n atleast one number and atleast one special character';
                  }
                  return null;
                },
              ),
            ],
          ),
        ) 
      ),
    );
  }
}