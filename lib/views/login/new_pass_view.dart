import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/services/api_services.dart';

final TextEditingController npasswordController = TextEditingController();
final TextEditingController ntokenController = TextEditingController();

class NewPass extends StatefulWidget {
  const NewPass({ Key? key }) : super(key: key);

  @override
  State<NewPass> createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validate(){
    if(formKey.currentState!.validate()){
      forget();
      print("validated");
    }else{
      print("Not Validated !!");
    }
  }

  forget() async{
    Map<String,dynamic> body = {
      'password': npasswordController.text,
      'token': ntokenController.text
    };
    Response jobPostResponse = await NetworkServices().newPassService(body); //call api
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (jobPostResponse.statusCode == 200)?
          const Text("New password created"):
          const Text("Invalid Token"),
          actions: <Widget>[
            ElevatedButton(
              style: constants.addJobButtonStyle,
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pushNamed('/login') //login
            )
          ],
        );
      }  
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.fromLTRB(40, 160, 40, 0),
          child: Center(
            child: Column(
              children: [
                const Text("Code send to email", style: TextStyle(
                  fontWeight:FontWeight.w600,
                  color: Colors.black,
                  fontSize: 32
                ),),
                const Text("Set New Password", style: TextStyle(
                  color: Colors.black,
                  fontSize: 24
                ),),
                const SizedBox(height: 60),
                Form(  
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: true,
                        controller: npasswordController,
                        decoration: const InputDecoration(
                        labelText: "new password",
                        icon: Icon(Icons.email, color: Colors.black),
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
                        controller: ntokenController,
                        decoration: const InputDecoration(
                        labelText: "token",
                        icon: Icon(Icons.email, color: Colors.black),
                        ),
                        validator: (value) {  // VALIDATION
                          if (value!.trim().isEmpty) {
                            return 'token is required';
                          }
                          return null;
                        },                      
                      ),
                    ],
                  ),
                ),
                const SizedBox(height:32),
                ElevatedButton(         
                    onPressed: validate,
                    child: const Text("set"),
                    style: constants.updateButtonStyle,
                  )
              ],
            ),
          ),
        )
      ),
    );
  }
}