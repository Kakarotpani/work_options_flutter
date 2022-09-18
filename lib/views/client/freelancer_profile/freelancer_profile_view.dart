import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/constants/constants.dart';
import 'package:work_options/repository/models/freelancer_model.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/freelancer/profile/profile_form.dart';

class FreelancerProfileView extends StatefulWidget {
  dynamic fid;
  FreelancerProfileView({ Key? key , required this.fid}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<FreelancerProfileView> createState() => _FreelancerProfileViewState(fid);
}

class _FreelancerProfileViewState extends State<FreelancerProfileView> {
 /*  List<String> skillList = ['adobe','adobe-XD','c','css','c++','Django','Excel','html','java','javaScript','restframework'];
  List<String> selectedskillList = []; */

  dynamic fidSend;
  _FreelancerProfileViewState(this.fidSend);

  late Response response;
  bool _isloading = false;
  List<FreelancerProfile> freelancers = [];
  FreelancerProfile profile = FreelancerProfile();
  dynamic responseBody;
  dynamic contribution;
  dynamic isVerified;
  dynamic ratings;

  @override
  void initState(){    
    _getProfile(); 
    super.initState();
  }

  _getProfile() async{
    _isloading = true;
    final api = apiRoutes['bid_freelancerprofile_get'].toString();
    response = await NetworkServices().getService(api+fidSend.toString()); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      profile = FreelancerProfile.fromJson(responseBody); // map response to Model, store in profile instance 
      setState(() {
        tagController.text = profile.tag.toString();
        firstNameController.text = profile.firstName.toString();
        lastNameController.text = profile.lastName.toString();
        emailController.text = profile.email.toString();
        phoneController.text = profile.phone.toString();
        locationController.text = profile.location.toString();
        sexController.text = profile.sex.toString();
        dobController.text = profile.dob.toString();
        qualificationController.text = profile.qualification.toString();
        experienceController.text = profile.experience.toString();
        contribution = profile.contribution.toString();
        isVerified = profile.isVerified;
        ratings = profile.ratings;
        _isloading = false;
      });
    }
    else{
      noProfile();
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

  Column profileTextBox(String title, String data){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(title, 
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey
            )
          )
        ),
        const SizedBox(height: 8),
        Container(
          alignment: Alignment.topLeft,
          child: Text(data,
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'bell MT',
              color: Colors.black
            )
          )
        ),
        const Divider(
          height: 4, 
          color: Colors.black,
          indent: 1,
          endIndent: 4
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  /*   Widget _buildPopupDialog(BuildContext context) {  // ..............................  POPUP View
      return AlertDialog(
        title: const Text('Skill tags'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(  // ............................skill chips
              spacing: 5,
              runSpacing: 3,
              children: [
                for(int i=0;i<skills.length;i++)
                FilterChipWidget(chipName: skills[i])
              ],
            )
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();          
            },
            child: const Text('Close'),
          ),
        ],
      );
    } */

  @override
  Widget build(BuildContext context) {
    var photoApi = imageUrl+profile.photo.toString();
    return Scaffold(
      body: SingleChildScrollView(
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
                      child: (_isloading == true)?const CircularProgressIndicator():
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
                  ],
                ),
                Container(  //...... freelancer profile
                  height: 126,
                  width: 240,             
                  padding: const EdgeInsets.only(top: 42),
                  child: Column(                   
                    children: [
                      Container(  //........... freelancer profile Text
                        padding: const EdgeInsets.fromLTRB(0, 8, 46, 0),
                        child: const Text("Freelancer Profile",
                          style: TextStyle(                        
                            color:Color.fromARGB(255, 36, 198, 241),
                            fontSize: 22,
                            fontFamily: "serif"
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text("Ratings  : "),
                              Text(profile.ratings.toString()+".0",
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color.fromARGB(255, 30, 33, 210))
                              ),
                            ]
                          ),
                          /* for(int i=0;i< ratings;i++)
                            starWidget(i), // ............................star
                          for(int j=0;j< 5-ratings;j++)
                            nonStarWidget(j), */
                          //const SizedBox(width: 50),
                          Row( // verified
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
                      )
                    ],
                  ),
                ),
              ],
            ),
            
            Row(  //..................... row 2
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [  
                Card(             
                  elevation: 12,
                  child: Container(
                    color: Colors.transparent,
                    height: 570,
                    width: 280,
                    child: Column(
                      children: [
                        Wrap(    
                          children: [
                            Text(tagController.text, //...............tag
                              style: const TextStyle(
                                color: Color.fromARGB(255,255,0,128),
                                fontSize: 18 ,
                                fontFamily: 'serif'
                              )
                            )
                          ]
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.only(left: 4),
                          child:Column(                        
                            children: [
                              const SizedBox(height: 4),
                              Wrap(children: [  // ................. profile content
                                profileTextBox("First name", profile.firstName.toString()),
                                profileTextBox("Last name", profile.lastName.toString()),
                                profileTextBox("email", profile.email.toString()),
                                profileTextBox("Phone", profile.phone.toString()),
                                profileTextBox("Location", profile.location.toString()),
                                profileTextBox("Sex", profile.sex.toString()),
                                profileTextBox("Birth Date", profile.dob.toString()),
                                profileTextBox("Qualification", profile.qualification.toString()),
                                profileTextBox("Experience", profile.experience.toString()),
                              ],)
                            ] 
                          )
                        )
                      ],
                    )
                  ),
                ),
                SizedBox(  // ......................... right column
                  height: 480,
                  width: 86,
                  child: Stack(                                             
                    children: [
                      Positioned(  //..... side triangle
                        bottom: 0,
                        height: 240,
                        width: 90,
                        child: CustomPaint(foregroundPainter: SideTrianglePainter()),
                      ),
                      Positioned(  //.........projects             
                        bottom: 156,
                        right: 16,
                        child: Text(profile.contribution.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          )
                        ),
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
          ],      
        ),
      ),
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

/* class FilterChipWidget extends StatefulWidget{
  final String chipName;

  const FilterChipWidget({Key? key, required this.chipName}) : super(key: key);
  
  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();

}

class  _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context){
    return FilterChip(
      label: Text(widget.chipName), 
      selected: _isSelected,
      onSelected: (isSelected){
        setState(() {
          _isSelected = isSelected;
        });
      },
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      selectedColor: const Color.fromARGB(255, 46,237,230),
    );
  }
} */

class MultiSelectChip extends StatefulWidget {   // Multi select class
  final List<String> skillList;
  final Function(List<String>)? onSelectionChanged;
  final Function(List<String>)? onMaxSelected;
  final int? maxSelection;

  MultiSelectChip(this.skillList, {Key? key, this.onSelectionChanged, this.onMaxSelected, this.maxSelection}) : super(key: key);

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = [];
  _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.skillList) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selectedColor: const Color.fromARGB(255, 46,237,230),
          backgroundColor: const Color.fromARGB(255, 224, 224, 224),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            if(selectedChoices.length == (widget.maxSelection  ?? -1) && !selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
                widget.onSelectionChanged?.call(selectedChoices);
              });
            }
          },
        ),
      ));
    }
    return choices;
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
