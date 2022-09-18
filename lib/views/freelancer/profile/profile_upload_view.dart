import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/freelancer/profile/profile_form.dart';

class FreelancerProfileUpload extends StatefulWidget {
  const FreelancerProfileUpload({ Key? key }) : super(key: key);

  @override
  State<FreelancerProfileUpload> createState() => _FreelancerProfileUploadState();
}

class _FreelancerProfileUploadState extends State<FreelancerProfileUpload> {

  XFile? file;
  pickImage() async{
    file = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  _putProfile() async{
    final api = apiRoutes['freelancer_profile_post'].toString();
    Map<String,dynamic> body = {
      'tag': tagController.text,
      'sex': sexController.text,
      'dob': dobController.text,
      'location': locationController.text,
      'qualification': qualificationController.text,
      'experience': experienceController.text,
      'photo': (file != null) ? file!.path.toString(): null
    };
    dynamic res = await NetworkServices().freelancerProfileUpload(api, body); //call api
    print(res.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (res.statusCode == 200)?
          const Text("Profile updated."):
          const Text("Something Wrong !!"),
          actions: <Widget>[
            ElevatedButton(
              style: addJobButtonStyle,
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pushNamed('/freelancer/bottom/nav')
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text("Upload Profile", style: TextStyle(
                fontSize: 28,
              ),),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 24,
              borderOnForeground: false,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const ProfileUploadForm(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: pickImage,
                  child: const Text("profile picture")
                ),
                ElevatedButton(onPressed: _putProfile, 
                  child: const Text("upload"),
                  style: addJobButtonStyle
                )
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("If already uploaded ,  ",
                    style: TextStyle(fontSize: 12)
                  ),
                  InkWell(
                    child: const Text("click here .", 
                      style: TextStyle(color: Color.fromARGB(255, 92, 175, 227), fontSize: 14)
                    ,),
                    onTap: () => Navigator.of(context).pushNamed('/freelancer/profile/view'),
                  )
                ]
              )
            )
          ],
        )
      )
    );
  }
}