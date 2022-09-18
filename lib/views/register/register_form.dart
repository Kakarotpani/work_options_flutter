import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart';
import 'package:email_validator/email_validator.dart';


final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmpasswordController = TextEditingController();
//String radioButtonItem = '';
bool data = false;
String value = '';

class RegisterForm extends StatefulWidget {
  const RegisterForm({ Key? key }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  //int id = 1;

  String _errorMessage = '';
  customRadioButton(String text, String indexItem) {  // ........radio widget
    return OutlinedButton(
      onPressed: () {
        setState(() {
          value = indexItem;
          data = true;          
        });
      },
      child: Text( text), 
      style: (value == indexItem) ? radioSelectStyle : radioUnselectStyle,
    );
  }

  // regular expression to check if string
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  //A function that validate user entered password
  bool validatePassword(String pass){
    String _password = pass.trim();
    if(pass_valid.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    TextFormField custompass(String title, IconData icon, TextEditingController passedControler){
      return TextFormField(
        obscureText: true,
        controller: passedControler,
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black, fontFamily: "serif"),
        onChanged: validatePassword,
        validator: (value){
                      if(value!.isEmpty){
                        return "Please enter password";
                      }else{
                       //call function to check password
                        bool result = validatePassword(value);
                        if(result){
                          // create account event
                         return null;
                        }else{
                          return " Password should contain Capital, small letter & Number & Special";
                        }
                      }
                  },
        decoration: InputDecoration(   
          hintText: title,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
          icon: Icon(icon, color: Colors.black),
        ), 
      );
    }

    TextFormField customcon(String title, IconData icon, TextEditingController passedControler){
      return TextFormField(
        obscureText: title == "password" || title == "confirm password" ? true : false,
        controller: passedControler,
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.black, fontFamily: "serif"),
        validator: (value){
                      if(value!.isEmpty){
                        return "Please enter password";
                      }else{
                       //call function to check password
                        bool result = validatePassword(value);
                        if(result){
                          // create account event
                         return null;
                        }else{
                          return " Password should contain Capital, small letter & Number & Special";
                        }
                      }
                  },
        decoration: InputDecoration(   
          hintText: title,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
          icon: Icon(icon, color: Colors.black),
        ), 
        
      );
    }

    return Container(
      key: _formKey,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
      child: SingleChildScrollView(      
        child: Column(
          children: [
            customInputText("first name", Icons.person, firstNameController),
            customInputText("last name", Icons.person, lastNameController),
            customInputText("(+91) phone", Icons.phone, phoneController),
            customInputText("email", Icons.email, emailController),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black, fontFamily: "serif"),
              validator: (value) {
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
                else if(!value.contains(RegExp('^(?=.?[a-zA-Z])(?=.?[0-9])(?=.?[#?!@\$%^&-]).{8,}\$')))
                {
                  return 'Password must contain: atleast one alphabet, \n atleast one number and atleast one special character';
                }
                return null;
              },
              decoration: const InputDecoration(   
                hintText: "password",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                icon: Icon(Icons.lock, color: Colors.black),
              ),
            ),
            TextFormField(
              obscureText: true,
              controller: confirmpasswordController,
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black, fontFamily: "serif"),
              validator: (value) {
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
                else if(!value.contains(RegExp('^(?=.?[a-zA-Z])(?=.?[0-9])(?=.?[#?!@\$%^&-]).{8,}\$')))
                {
                  return 'Password must contain: atleast one alphabet, \n atleast one number and atleast one special character';
                }
                return null;
              },
              decoration: const InputDecoration(   
                hintText: "confirm password",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                icon: Icon(Icons.lock, color: Colors.black),
              ),
            ),
            //custompass("password", Icons.lock, passwordController),
            //customcon("confirm password", Icons.lock, confirmpasswordController),
            //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            /* TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'email'),
              controller: emailController,
              onChanged: validate(),
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(labelText: 'password'),
              controller: passwordController,
              obscureText: true,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(labelText: 'confirm password'),
              controller: confirmpasswordController,
              obscureText: true,
            ), */
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,          
              children: [
                customRadioButton("Freelancer", "freelancer"),
                const SizedBox(width: 12),
                customRadioButton("Client", "client"),                
              ],
            )
            /* Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'freelancer';
                      id = 1;
                    });
                  },
                ),
                const Text(
                  'freelancer',
                  style: TextStyle(fontSize: 17.0),
                ),
    
                Radio(
                  value: 2,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'client';
                      id = 2;
                    });
                  },
                ),
                const Text(
                  'client',
                  style: TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ],
            ), */
          ],
        ) 
      ),
    );
  }
  
  void validateEmail(String val) {
    if(val.isEmpty){
      setState(() {
        _errorMessage = "Email can not be empty";
      });
      }else if(!EmailValidator.validate(val, true)){
        setState(() {
          _errorMessage = "Invalid Email Address";
        });
      }else{
        setState(() {
          _errorMessage = "";
        });
      }
  }

}