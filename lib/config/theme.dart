import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData get lightTheme{
    return ThemeData(
      primaryColor: Colors.cyan,
      scaffoldBackgroundColor: Colors.white,  
      textTheme: ThemeData.light().textTheme, 
      fontFamily: 'Georgia',
      chipTheme: ThemeData.light().chipTheme,      
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        buttonColor: Colors.blue,        
      ),
    );
  } 
}


