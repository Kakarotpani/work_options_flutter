import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/constants/constants.dart';
import 'package:work_options/repository/models/client_model.dart';
import 'package:work_options/repository/secure_storage.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/client/profile/profile_form.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({ Key? key }) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Response response;
  bool _isloading = false;
  List<ClientProfile> clients = [];
  ClientProfile profile = ClientProfile();
  dynamic contribution;
  dynamic isVerified;
  dynamic responseBody;
  dynamic clientId;

  XFile? file;
  var image;

  pickImage() async{
    file = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(file!.path);
    });
  }

  final TextStyle insideText = const TextStyle(
    fontSize: 16,
    fontFamily: 'serif',
    fontWeight: FontWeight.w300
  );
  final TextStyle insideTextBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500
  );

  @override
  void initState(){    
    _getProfile();
    super.initState();
  }

  _getProfile() async{
    _isloading = true;
    final api = apiRoutes['client_profile_get'].toString();
    response = await NetworkServices().getService(api); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      profile = ClientProfile.fromJson(responseBody); // map response to Model, store in profile instance 
      setState(() {
        firstNameController.text = profile.firstName.toString();
        lastNameController.text = profile.lastName.toString();
        emailController.text = profile.email.toString();
        phoneController.text = profile.phone.toString();
        locationController.text = profile.location.toString();
        sexController.text = profile.sex.toString();
        companyController.text = profile.company.toString();
        contribution = profile.contribution.toString();
        isVerified = profile.isVerified;
        clientId = profile.id.toString();
        _isloading = false;
      });
    }
    else{
      noProfile();
    }
  }

  _putProfile() async{
    _isloading = true;
    final api = apiRoutes['client_profile_put'].toString();
    Map<String,dynamic> body = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'location': locationController.text,
      'sex': sexController.text,
      'company': companyController.text,
      'photo': (file != null) ? file!.path.toString(): null
    };
    dynamic cProfileResponse = await NetworkServices().clientProfileUpdate(api, body); //call api
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (cProfileResponse.statusCode == 200)?
          const Text("Profile updated Successfully ."):
          const Text("Something Wrong !!"),
          actions: <Widget>[
            ElevatedButton(
              style: constants.addJobButtonStyle,
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pushNamed('/client/bottom/nav')
            )
          ],
        );
      }  
    );
    setState(() {
      _isloading = false;
    });
  }

  _logout() async{
    _isloading = true;
    final api = apiRoutes['logout_api'].toString();
    String? refreshToken = await UserSecureStorage.getRefreshToken();
    Map<String,dynamic> body = {
      'refresh_token': refreshToken.toString()
    };
    response = await NetworkServices().postService(api, body); // call api
    if(response.statusCode == 200){
      Navigator.of(context).pushNamed('/login');
    }  
    else{
      setState(() {
        noProfile();
      });
    }
  }

  Widget noProfile(){
    return Card(      
      color: const Color.fromARGB(255, 89, 207, 188),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation: 12,            
      margin: const EdgeInsets.all(8),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          height: 120,
          width: 200,
          padding: const EdgeInsets.all(6),
          child: const Text("Something Wrong.", textScaleFactor: 1.8)
        ),
      )
    );
  }

  Container starWidget(int ratings){
    return Container(
      color: Colors.transparent,
      child: const Icon(Icons.star,color: Color.fromARGB(255, 231, 203, 45),),
    );
  } 
  Container nonStarWidget(int ratings){
    return Container(
      color: Colors.transparent,
      child: const Icon(Icons.star,color: Color.fromARGB(255, 207, 207, 203),),
    );
  }

  Widget actualBody(){
    var photoApi = imageUrl+profile.photo.toString();
    return SingleChildScrollView( 
      child: Column(
        children: [      
          Row( //.................... 1st row
            children: [
              Stack(         
                children: [
                  Container(  //........ triangle
                    padding: const EdgeInsets.all(0),
                    height: 130,
                    width: 130,
                    child: CustomPaint(foregroundPainter: TopTrianglePainter()),            
                  ),
                  Positioned(  //....... profile pic
                    right: 28,
                    top: 30,
                    child: CircleAvatar(
                      radius: 36,
                      child: (_isloading == true)? const CircularProgressIndicator():
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(photoApi)
                          )
                        ),
                      ),
                    ),
                  ),
                  Positioned(  //....... edit profile pic
                    right: 22,
                    top: 70,
                    child: InkWell(
                      onTap: pickImage,
                      child: const CircleAvatar(                  
                        backgroundColor: Colors.cyan,
                        child: Icon(Icons.camera_alt_outlined, color: Colors.white,size: 12),
                        radius: 12,
                      )
                    )
                  ), 
                ],
              ),
              Container(  //...... client profile
                height: 126,
                width: 240,             
                padding: const EdgeInsets.only(top: 42),
                child: Column(         
                  children: [
                    Container(  //........... client profile Text
                      padding: const EdgeInsets.fromLTRB(0, 8, 46, 0),
                      child: const Text("Client Profile",
                        style: TextStyle(                        
                          color:Color.fromARGB(255, 36, 198, 241),
                          fontSize: 24,
                          fontFamily: "serif"
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(  // verified
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (isVerified == true) Row(
                          children: const [
                            Text("Verified"),
                            Icon(Icons.verified_outlined, color: Colors.green)
                          ],
                        ) 
                        else Row(
                          children: const [
                            Text("Not Verified"),
                            Icon(Icons.dangerous_outlined, color: Colors.red)
                          ],
                        ) ,
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          
          Row(  //..................... row 2
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 480,
                width: 300,
                child: Column(                
                  children: [                    
                    Container(  //..................... Profile Form
                      alignment: Alignment.topCenter,
                      height: 440,
                      child: const ProfileForm()
                    ),
                    Container(  //.................... client id
                      height: 40,
                      padding: const EdgeInsets.fromLTRB(0, 10, 140, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Client id  :",
                            style: TextStyle(
                              color: Color.fromARGB(255, 36, 198, 241),
                              fontSize: 18,
                              fontFamily: "serif"
                            )
                          ),
                          const SizedBox(width: 10),
                          Text(profile.id.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                            )
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ),
              SizedBox(
                height: 480,
                width: 86,
                child: Stack(                                             
                  children: [      
                    /* Container(  //..... contribution
                      padding: const EdgeInsets.all(28),
                      height: 316,
                      width: 64,    
                      child: const Text("Contribution",style: TextStyle(fontSize: 16, height: 1.4))      
                    ), */
                    Positioned(  //..... side triangle
                      bottom: 0,
                      height: 240,
                      width: 90,
                      child: CustomPaint(foregroundPainter: SideTrianglePainter()),
                    ),
                    Positioned( //.........projects             
                      bottom: 156,
                      right: 16,
                      child: Text(profile.contribution.toString(), style: const TextStyle(color: Colors.white, fontSize: 26,fontWeight: FontWeight.bold))
                    ),
                    const Positioned(                    
                      bottom: 134,
                      right: 4,
                      child: Text("projects", style: TextStyle(color: Colors.white, fontSize: 16))
                    ),
                  ],
                ),
              )
            ],          
          ),
          Container(  //........... logout , submit  
            height: 80,
            padding: const EdgeInsets.fromLTRB(14,0,14,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _logout(), //logout method call
                  child: Row(
                    children: const [
                      Icon(Icons.logout_outlined),
                      Text("Logout", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                ElevatedButton(         
                  onPressed: _putProfile,
                  child: const Text(
                    "update",
                  ),
                  style: constants.updateButtonStyle,
                )
              ],
            ),
          ),
        ],      
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: actualBody(),
    );
  }
}

class TopTrianglePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paintTriangle = Paint()..color = const Color.fromARGB(255, 46,237,230)..strokeWidth=10..style=PaintingStyle.fill;
    final pathTriangle = Path();
    pathTriangle.lineTo(0, size.height);
    pathTriangle.lineTo(size.width, 0);
    pathTriangle.close();
    canvas.drawPath(pathTriangle, paintTriangle);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
class SideTrianglePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paintTriangle = Paint()..color = const Color.fromARGB(255, 46,237,230)..strokeWidth=10..style=PaintingStyle.fill;
    final pathTriangle = Path();
    pathTriangle.moveTo(size.width, 0);
    pathTriangle.lineTo(0,size.height/3);
    pathTriangle.lineTo(size.height*2,size.height*3);
    pathTriangle.close();
    canvas.drawPath(pathTriangle, paintTriangle);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}