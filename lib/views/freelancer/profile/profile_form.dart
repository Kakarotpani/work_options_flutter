import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart';

TextEditingController tagController = TextEditingController();
TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController locationController = TextEditingController();
TextEditingController sexController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController qualificationController = TextEditingController();
TextEditingController experienceController = TextEditingController();
//TextEditingController photoController = TextEditingController();

class ProfileForm extends StatefulWidget {
  const ProfileForm({ Key? key }) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _formKey,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(6),
      child: SingleChildScrollView(       
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            profileInputText("Tag", tagController),
            profileInputText("first name", firstNameController),
            profileInputText("last name", lastNameController),
            profileInputText("email", emailController),
            profileInputText("phone", phoneController),
            profileInputText("Location", locationController),
            profileInputText("Sex", sexController),
            profileInputText("Birth date", dobController),
            profileInputText("Qualification", qualificationController),
            profileInputText("Experience", experienceController),
          ],
        ) 
      ),
    );
  }
}


class ProfileUploadForm extends StatefulWidget {
  const ProfileUploadForm({ Key? key }) : super(key: key);

  @override
  State<ProfileUploadForm> createState() => _ProfileUploadFormState();
}

class _ProfileUploadFormState extends State<ProfileUploadForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _formKey,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(6),
      child: SingleChildScrollView(       
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            profileInputText("Tag", tagController),
            profileInputText("Location", locationController),
            profileInputText("Sex", sexController),
            profileInputText("Birth date", dobController),
            profileInputText("Qualification", qualificationController),
            profileInputText("Experience", experienceController),
            const SizedBox(height: 16)
          ],
        ) 
      ),
    );
  }
}