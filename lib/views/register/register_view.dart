import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/services/api_services.dart';
import 'package:http/http.dart';

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmpasswordController = TextEditingController();

bool data = false;
String value = '';

class RegisterView extends StatefulWidget {
  const RegisterView({ Key? key }) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validate(){
    if(formKey.currentState!.validate()){
      print("validated");
      registerService(  // registerService
      firstNameController.text,
      lastNameController.text,
      "+91"+phoneController.text,
      emailController.text,
      passwordController.text,
      confirmpasswordController.text,
      value, );
    }else{
      print("Not Validated !!");
      print(firstNameController.text);
      print(lastNameController.text);
      print(phoneController.text);
      print(passwordController.text);
      print("confirm : "+confirmpasswordController.text);
      print(value);
    }
  }

  Widget _registerBody(BuildContext context){
    const TextStyle footerTextStyle = TextStyle(color: Colors.black,fontSize: 12);
    const TextStyle linkStyle = TextStyle(color: Colors.blue, decoration: TextDecoration.underline);
    customRadioButton(String text, String indexItem) {  // ........radio widget
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = indexItem;
          data = true;          
        });
      },
      child: Text( text), 
      style: (value == indexItem) ? constants.radioSelectStyle : constants.radioUnselectStyle,
    );
  }

    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [  
            Container(  // register image
              padding: const EdgeInsets.only(right: 140),
              child: Image.asset(
                constants.splashImage,
                height: 240            
              ),
            ),

            Container( // ........... register Text
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.fromLTRB(10, 0, 8, 0),
              child: Row(              
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Register",  
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 29, 152, 227),
                      fontSize: 30,
                      fontWeight: FontWeight.w400,            
                    ),
                  ),
                  SvgPicture.asset(constants.profileIcon, height: 50)  // profile image            
                ]
              ),
            ),

            //const RegisterForm(),
            Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: Form(
                key: formKey,
                child: Column (
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      decoration: const InputDecoration(
                      labelText: "first name",
                      icon: Icon(Icons.person, color: Colors.black),
                      ),
                      validator: (value) {  // password VALIDATION
                        if (value!.trim().isEmpty) {
                          return 'First Name is required';
                        }
                        return null;
                      },                      
                    ),

                    TextFormField(
                      controller: lastNameController,
                      decoration: const InputDecoration(
                      labelText: "last name",
                      icon: Icon(Icons.person, color: Colors.black),
                      ),
                    ),

                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(                        
                      labelText: "phone",
                      icon: Icon(Icons.phone, color: Colors.black),                      
                      ),
                      validator: (value) {  
                        if(value!.length != 10)
                        {
                          return 'Phone number should be of length 10';
                          //and atmost 16 characters
                        }
                        else if(value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
                          return 'Phone number can\'t contain special character';
                        }
                        else if(value.contains(RegExp('[a-zA-Z]')))
                        {
                          return 'Phone number can\'t contain alphabets';
                        }
                          return null;                        
                      },
                    ),

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

                    TextFormField(
                      controller: confirmpasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                      labelText: "confirm password",
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
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,          
                      children: [
                        customRadioButton("Freelancer", "freelancer"),
                        const SizedBox(width: 12),
                        customRadioButton("Client", "client"),                
                      ],
                    )
                  ],
                )
              ),
            ),


            
            Container(
              padding: const EdgeInsets.only(left: 250),
              child: ElevatedButton(    
                onPressed: validate,
                /* (){  {
                    registerService(  // registerService
                    firstNameController.text,
                    lastNameController.text,
                    phoneController.text,
                    emailController.text,
                    passwordController.text,
                    confirmpasswordController.text,
                    value,
                  );}      
                }, */
                child: const Text(
                  "Sign up",  // register btn
                ),
                style: constants.raisedButtonStyle,   
              )
            ),
            const SizedBox(height: 20),

            Container(  //......... footer
              padding: const EdgeInsets.only(left: 100),
              child: Row(
                children: [
                  const Text("Already have an account ?",
                    style: footerTextStyle,
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    child: const Text("sign in",                       
                      style: linkStyle,                      
                    ),
                    onTap: () => Navigator.of(context).pushNamed('/login'), //login route
                  )
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }

  Future registerService(String firstName, String lastName, String phone,String email, String password, String confirmPassword, String userType) async {
    String isFreelancer = (userType == "freelancer") ? "true" : "false";
    String isClient = (userType == "client") ? "true": "false";
    if (userType == ""){
      Map<String,dynamic> body = {
        "first_name" : firstName,
        "last_name" : lastName,
        "email" : email,
        "phone" : phone,
        "password" : password,
        "password2" : confirmPassword,
      };
      Response response = await NetworkServices().postService("api/guest/register", body); //call api
      if (response.statusCode == 200){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("successfully registered ."),
              actions: <Widget>[
                ElevatedButton(
                  style: constants.addJobButtonStyle,
                  child: const Text("OK"),
                  onPressed: () => Navigator.of(context).pushNamed('/login')
                )
              ],
            );
          }  
        );
      } 
    }
    else{
      Map<String,dynamic> body = {
      "first_name" : firstName,
      "last_name" : lastName,
      "email" : email,
      "phone" : phone,
      "password" : password,
      "password2" : confirmPassword,
      "is_freelancer" : isFreelancer,
      "is_client" : isClient
    };
    Response response = await NetworkServices().registerService(body); //call api
    if (response.statusCode == 200){
      setState(() {
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      });
      print("Signed up successfully !!");
    }

    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Password Mismatch !!"),
            actions: <Widget>[
              ElevatedButton(
                style: constants.addJobButtonStyle,
                child: const Text("OK"),
                onPressed: () => Navigator.of(context).pushNamed('/register')
              )
            ],
          );
        }  
      );
      print("Couldn't sign up !!");
      print("isFreelancer"+isFreelancer);
      print("isClient"+isClient);
    }
    }

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _registerBody(context)
    );
  }
}