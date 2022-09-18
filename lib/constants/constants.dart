import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
const String splashText = 'Work Options';
const String splashImage = 'assets/images/splash.png';
const String profileIcon = 'assets/icons/user_profile.svg';
const String registerImage = 'assets/images/register.png';
const String dashBoardImage = 'assets/images/dashboard.png';
const String userAskImage = 'assets/images/user_ask.jpg';
const String addJobImage = 'assets/images/add_job.png';

//const String imageUrl = 'https://dashgirija.pythonanywhere.com/media/';
const String imageUrl = 'http://10.0.2.2:8000/media/';
const photoUrlSubstringSize = 42;

TextFormField customInputText(String title, IconData icon, TextEditingController passedControler){
  return TextFormField(
    obscureText: title == "password" || title == "confirm password" ? true : false,
    controller: passedControler,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black, fontFamily: "serif"),
    decoration: InputDecoration(   
      hintText: title,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
      icon: Icon(icon, color: Colors.black),
    ), 
  );
}

TextFormField searchInputText(String title, TextEditingController passedControler){
  return TextFormField(
    controller: passedControler,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black, fontSize: 20),
    decoration: InputDecoration(    
      hintText: title,
      hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
    ),
  );
}

TextFormField addBidInputText(String title,TextEditingController passedControler){
  return TextFormField(    
    controller: passedControler,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black,fontSize: 18),
    decoration: InputDecoration(    
      labelText: title,
      hintText: title,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
    )
  );
}

TextFormField reviewInputText(String title, String placeholder, TextEditingController passedControler){
  return TextFormField(    
    controller: passedControler,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black,fontSize: 18),
    decoration: InputDecoration(    
      labelText: title,
      hintText: placeholder,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
    )
  );
}

TextFormField profileInputText(String title,TextEditingController passedControler){
  return TextFormField(    
    controller: passedControler,
    cursorColor: Colors.black,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(    
      labelText: title,
      hintText: title,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
    )
  );
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  alignment: Alignment.center,
  textStyle: const TextStyle(
    letterSpacing: 0,
    fontSize: 18,
    //fontFamily: 'serif',
    fontWeight: FontWeight.normal,
  ),
  onPrimary: const Color.fromARGB(255, 255, 255, 255),
  primary: const Color.fromARGB(255, 36, 198, 241),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
);

final ButtonStyle updateButtonStyle = ElevatedButton.styleFrom(
  alignment: Alignment.center,
  textStyle: const TextStyle(
    letterSpacing: 0,
    fontSize: 18,
    fontWeight: FontWeight.normal,
  ),
  onPrimary: const Color.fromARGB(255, 255, 255, 255),
  primary: const Color.fromARGB(255,24,31,249),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
);

final ButtonStyle addJobButtonStyle = ElevatedButton.styleFrom(
  alignment: Alignment.center,
  textStyle: const TextStyle(
    letterSpacing: 0,
    fontSize: 18,
    fontWeight: FontWeight.normal,
  ),
  onPrimary: const Color.fromARGB(255, 255, 255, 255),
  primary: const Color.fromARGB(255, 13, 177, 149),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
);

final ButtonStyle deleteButtonStyle = ElevatedButton.styleFrom(
  alignment: Alignment.center,
  textStyle: const TextStyle(
    letterSpacing: 0,
    fontSize: 18,
    fontWeight: FontWeight.normal,
  ),
  onPrimary: const Color.fromARGB(255, 255, 255, 255),
  primary: const Color.fromARGB(255, 230, 7, 7),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
);

final ButtonStyle radioSelectStyle = ElevatedButton.styleFrom(
  alignment: Alignment.center,
  textStyle: const TextStyle(
    letterSpacing: 0,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
  onPrimary: Colors.black,
  primary: const Color.fromARGB(255, 36, 198, 241),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
);

final ButtonStyle radioUnselectStyle = ElevatedButton.styleFrom(
  alignment: Alignment.center,
  textStyle: const TextStyle(
    letterSpacing: 0,
    fontSize: 16,
    fontFamily: 'Bell MT',
    fontWeight: FontWeight.normal,
  ),
  onPrimary: Colors.black,
  primary: const Color.fromARGB(255, 255, 255, 255),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
);

