import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/services/api_services.dart';

final TextEditingController femailController = TextEditingController();

class ForgetPassView extends StatefulWidget {
  const ForgetPassView({ Key? key }) : super(key: key);

  @override
  State<ForgetPassView> createState() => _ForgetPassViewState();
}

class _ForgetPassViewState extends State<ForgetPassView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

   forget() async{
    Map<String,dynamic> body = {
      'email': femailController.text
    };
    Response jobPostResponse = await NetworkServices().forgetService(body); //call api
    (jobPostResponse.statusCode == 200)? 
    Navigator.of(context).pushNamed('/new/password') :
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("email isn't registered !!"),
          actions: <Widget>[
            ElevatedButton(
              style: constants.addJobButtonStyle,
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop()
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
                const Text("Enter email", style: TextStyle(
                  fontWeight:FontWeight.w600,
                  color: Colors.black,
                  fontSize: 32
                ),),
                const Text("to send verification code", style: TextStyle(
                  color: Colors.black,
                  fontSize: 24
                ),),
                const SizedBox(height: 60),
                Form(  
                  child: TextFormField(
                    controller: femailController,
                    decoration: const InputDecoration(
                    labelText: "email",
                    icon: Icon(Icons.email, color: Colors.black),
                    ),
                    validator: (value) {  // VALIDATION
                      if (value!.trim().isEmpty) {
                        return 'email is required';
                      }
                      return null;
                    },                      
                  ),
                ),
                const SizedBox(height:32),
                ElevatedButton(         
                    onPressed: forget,
                    child: const Text(
                      "send",  
                    ),
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