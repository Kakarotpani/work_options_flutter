import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/constants/constants.dart';
import 'package:work_options/repository/models/freelancer_model.dart';
import 'package:work_options/repository/secure_storage.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/freelancer/profile/profile_form.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({ Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  late Response response;
  bool _isloading = false;
  List<FreelancerProfile> freelancers = [];
  FreelancerProfile profile = FreelancerProfile();
  dynamic responseBody;
  dynamic contribution;
  dynamic isVerified;
  dynamic ratings;

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
    final api = apiRoutes['freelancer_profile_get'].toString();
    response = await NetworkServices().getService(api); // call api
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
      setState(() {
        noProfile();
      });
    }
  }

  _putProfile() async{
    _isloading = true;
    final api = apiRoutes['freelancer_profile_put'].toString();
    Map<String,dynamic> body = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'tag': tagController.text,
      'sex': sexController.text,
      'dob': dobController.text,
      'location': locationController.text,
      'qualification': qualificationController.text,
      'experience': experienceController.text,
      'photo': (file != null) ? file!.path.toString(): null
    };
    dynamic fProfileResponse = await NetworkServices().freelancerProfileUpdate(api, body); //call api
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (fProfileResponse.statusCode == 200)?
          const Text("profile updated Successfully ."):
          const Text("Something Wrong !!"),
          actions: <Widget>[
            ElevatedButton(
              style: constants.addJobButtonStyle,
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pushNamed('/freelancer/bottom/nav')
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
          child: Row(
            children: [
              ElevatedButton(
                style: constants.addJobButtonStyle,
                child: const Text("skip"),
                onPressed: () => Navigator.of(context).pushNamed('/freelancer/bottom/nav')
              ),
              ElevatedButton(
                style: constants.addJobButtonStyle,
                child: const Text("set up"),
                onPressed: () => Navigator.of(context).pushNamed('/freelancer/upload')
              )
            ],
          )
        ),
      )
    );
  }
  
  _showReportDialog() { // skill padobeop-up
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //Here we will build the content of the dialog
        return AlertDialog(
          title: const Text("Add skills"),
          content: HomeScreen(), 
          /* MultiSelectChip(
            skillList,
            onSelectionChanged: (selectedList) {
              setState(() {
                selectedskillList = selectedList;
              });
            },
            maxSelection: 6,
          ), */
        );
      }
    );
  }
  //---------------------------------------------

  buildmystar(num ratings){
    for(int i=0;i< ratings;i++) {
      starWidget(i);
    } // ................. star
    for(int j=0;j< 5-ratings;j++){
      nonStarWidget(j);
    }
  }

  Container starWidget(dynamic ratings){
    return Container(
      color: Colors.transparent,
      child: const Icon(Icons.star,color: Color.fromARGB(255, 231, 203, 45),),
    );
  } 
  Container nonStarWidget(dynamic ratings){
    return Container(
      color: Colors.transparent,
      child: const Icon(Icons.star,color: Color.fromARGB(255, 207, 207, 203),),
    );
  }

  /* Widget _buildPopupDialog(BuildContext context) {  // ..............................  POPUP View
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

  actualBody(){
    var photoApi = imageUrl+profile.photo.toString();
    print("------------------------------"+photoApi);
    var rating = 3;
    return 
    SingleChildScrollView(    
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
                  
                  Positioned(  //....... edit profile icon
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
              Container(  //...... freelancer profile
                height: 126,
                width: 242,             
                padding: const EdgeInsets.only(top: 42),
                child: Column(                   
                  children: [
                    Container(  //........... client profile Text
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
                            //const Text("Ratings", style: TextStyle(fontSize: 14)),
                            //Text(ratings.toString()+".0", style:const TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w600))
                          ],
                        ),
                        Container(
                          child: Row(children: [
                            //buildmystar(rating),
                          for(int i=0;i< rating;i++)
                            starWidget(i),  // ................. star
                          for(int j=0;j< 5-rating;j++)
                            nonStarWidget(j),
                          const SizedBox(width: 50),
                          Row(  // verified
                            children: [
                              if (isVerified == true) Row(
                                children: const [
                                  Text("Verified"),
                                  Icon(Icons.verified_outlined, color: Colors.green)
                                ],
                              ) 
                              else Row(
                                children: const [
                                  //Text("Not Verified"),
                                  Icon(Icons.dangerous_outlined, color: Colors.red)
                                ],
                              ) ,
                            ],
                          )
                          ]),
                          
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [  //......................  profile form
              const SizedBox(
                //color: Colors.yellow,
                height: 600,
                width: 300,
                child: ProfileForm()
              ),
              SizedBox(  // ......................... right column
                height: 550,
                width: 90,
                child: Stack(                                             
                  children: [
                    Positioned(
                      top: 20,
                      right: 8,
                      child: ElevatedButton(  // .................. skills
                        child: const Text("skills"),
                        style: constants.updateButtonStyle,
                        onPressed: () => _showReportDialog(),   
                      )
                    ),
                    Positioned(  // ............. logout
                      top: 102,
                      left: 8,
                      child: InkWell(
                        onTap: () => _logout(), //logout method call
                        child: Row(
                          children: const [
                            Icon(Icons.logout_outlined),
                            Text("Logout",
                              style: TextStyle(fontSize: 16)
                            ),
                          ]
                        ),
                      )
                    ),
                    //Text(selectedskillList.join(" , ")),  // ====== ======= ====== === show selected
                    Positioned(  //..... side triangle
                      bottom: 60,
                      height: 240,
                      width: 90,
                      child: CustomPaint(foregroundPainter: SideTrianglePainter()),
                    ),
                    Positioned(  //.........projects             
                      bottom: 208,
                      right: 16,
                      child: Text(profile.contribution.toString(), style: const TextStyle(color: Colors.white, fontSize: 26,fontWeight: FontWeight.bold))
                    ),
                    const Positioned(                    
                      bottom: 188,
                      right: 4,
                      child: Text("projects", style: TextStyle(color: Colors.white, fontSize: 16))
                    ),
                    Positioned(  // .......... update
                      bottom: 10,
                      child: ElevatedButton(         
                        onPressed: ()=> _putProfile(), // update method
                        child: const Text(
                          "update",
                        ),
                        style: constants.updateButtonStyle,
                      )
                    )
                  ],
                ),
              )
            ],          
          ),
          /* Container(  //........... logout , submit
            //color: Colors.red,  
            height: 38,
            padding: const EdgeInsets.fromLTRB(14,0,14,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){},
                  child: Row(
                    children: const [
                      Icon(Icons.logout_outlined),
                      Text("Logout", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
                ElevatedButton(         
                  onPressed: (){},
                  child: const Text(
                    "update",
                  ),
                  style: constants.updateButtonStyle,
                )
              ],
            ),
          ), */
        ],      
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: actualBody()
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

  FilterChipWidget({Key? key, required this.chipName}) : super(key: key);
  
  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();

}

class  _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;
  List selectedList = [];

  @override
  Widget build(BuildContext context){
    return FilterChip(
      label: Text(widget.chipName), 
      selected: _isSelected,
      onSelected: (isSelected){
        setState(() {
          _isSelected = isSelected;
          selectedList.add(widget.chipName);
        });
      },
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      selectedColor: const Color.fromARGB(255, 46,237,230),
    );
  }
} */

/* class MultiSelectChip extends StatefulWidget {   // Multi select class
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

    widget.skillList.forEach((item) {
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
    });
    return choices;
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
} */

// latest myMultiSelectionFormField.dart

class MyMultiSelectionField<T> extends StatelessWidget {

  MyMultiSelectionField({
    Key? key,
    required this.onChanged,
    required this.values,
  }) : super( key: key );

  ValueChanged<List> onChanged;
  List<String> values;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          onSubmitted: (String value) {
            values.add(value);
            onChanged(values);
          },
        ),
        MyChipList(
          values: values,
          chipBuilder: (String value) {
            return Chip(
              backgroundColor: const Color.fromARGB(255, 118, 250, 228),
              label: Text(value),
              onDeleted: () {
                values.remove(value);
                onChanged(values);
              },
            );
          }
        )
      ],
    );
  }
}

class MyMultiSelectionFormField<T> extends FormField<List<T>> {

  final InputDecoration decoration;

  MyMultiSelectionFormField({
    Key? key,
    this.decoration = const InputDecoration(),
    FormFieldSetter<List>? onSaved,
    FormFieldValidator<List>? validator,
  }) : super(
    key: key,
    onSaved: onSaved,
    validator: validator,
    builder: (FormFieldState<List> field) {
      final InputDecoration effectiveDecoration =
          decoration.applyDefaults(
            Theme.of(field.context).inputDecorationTheme,
          );
      return InputDecorator(
        decoration: effectiveDecoration.copyWith(errorText: field.errorText),
        isEmpty: field.value?.isEmpty ?? true,
        child: MyMultiSelectionField(
          values: field.value?.map((e) => e.toString()).toList() ?? [],
          onChanged: field.didChange,
        ),
      );
    }
  );
}

//-------------------------------

class MyChipList<T> extends StatelessWidget {

  const MyChipList({
    Key? key, 
    required this.values,
    required this.chipBuilder,
  }) : super(key: key);

  final List<T> values;
  final Chip Function(T) chipBuilder;

  List<Widget> _buildChipList() {
    final List<Widget> items = [];
    for (T value in values) {
      items.add(chipBuilder(value));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChipList(),
    );
  }
}

// ===============================================

class HomeScreen extends StatefulWidget { // skill Widget
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  List _ingredients = [];
  bool _isloading= false;
  late Response response;
  dynamic responseBody;
  List<FreelancerSkill> skills = [];
  List<String> addSkill = [];

  @override
  void initState(){    
    _getSkills();
    super.initState();
  }

  _getSkills() async{
    _isloading = true;
    final api = apiRoutes['skill_get'].toString();
    response = await NetworkServices().getService(api); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      skills = responseBody.map<FreelancerSkill>((json) =>FreelancerSkill.fromJson(json)).toList(); // response to List<skill>
      setState(() {
        _isloading = false;
      });
    }
    else{
      setState(() {
        _isloading= false;
        noSkill();
      });
    }
  }

  _postSkill(List<dynamic> ingredients) async{
    _isloading = true;
    final api = apiRoutes['skill_post'].toString();
   
    String jsonSkill = jsonEncode(ingredients); // json serialization of List<String>
    Map<String,dynamic> body = {
      'skill': jsonSkill
    };
    Response jobPostResponse = await NetworkServices().postService(api, body); //call api
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (jobPostResponse.statusCode == 200)?
          const Text("skill added."):
          const Text("Something Wrong !!"),
          actions: <Widget>[
            ElevatedButton(
              style: constants.addJobButtonStyle,
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            )
          ],
        );
      }  
    );
    setState(() {
      _isloading = false;
    });
  }

  _removeSkill(String sId) async{
    final api = apiRoutes['skill_delete'].toString();
    response = await NetworkServices().deleteService(api+sId); // call api
    if(response.statusCode == 200){
      setState(() {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Skill removed."),
            actions: <Widget>[
              ElevatedButton(
                style: constants.addJobButtonStyle,
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              )
            ],
          );
        } 
      );
      });
    }
    else{
      setState(() {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Couldn't withdraw ..!!"),
            actions: <Widget>[
              ElevatedButton(
                style: constants.addJobButtonStyle,
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pushNamed('/freelancer/bottom/nav');
                }
              )
            ],
          );
        } 
      );
      });
    }
  }

  Widget noSkill(){
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
          child: const Text("No Skills.", textScaleFactor: 1.8)
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyMultiSelectionFormField(
                  decoration: const InputDecoration(
                    labelText: 'Add Skills',
                  ),
                  validator: (ingredients) => (ingredients?.length ?? 0) < 1
                    ? 'Please add at least 1 skills'
                    : null,
                  onSaved: (ingredients) {
                    _ingredients = ingredients!;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _formKey.currentState!.save();
                        _postSkill(_ingredients); // skill-post method call 
                      });
                    }
                  },
                  child: const Text('Submit'), // skill-submit btn
                  style: constants.updateButtonStyle,
                ),
                Wrap(
                  children: [
                    for(var s in skills) //loop
                      Chip(
                        backgroundColor: const Color.fromARGB(255, 118, 250, 228),
                        label: Text(s.skill.toString()),
                        deleteIcon: const Icon(Icons.delete_forever),
                        onDeleted: ()=> _removeSkill(s.skillId.toString()) // delete method
                      )
                  ],
                )
              ],
            )
          )
        ),
      ),
    );
  }
}
