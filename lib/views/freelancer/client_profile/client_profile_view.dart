import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart';
import 'package:work_options/repository/models/client_model.dart';
import 'package:work_options/services/api_services.dart';

class ClientProfileView extends StatefulWidget {
  dynamic jid;
  ClientProfileView({ Key? key, required this.jid}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ClientProfileView> createState() => _ClientProfileViewState(jid);
}

class _ClientProfileViewState extends State<ClientProfileView> {
  String jidSend;
  _ClientProfileViewState(this.jidSend);

  late Response response;
  bool _isloading = false;
  FreelancerClientModel client = FreelancerClientModel();

  @override
  void initState(){    
    _getProfile(); 
    super.initState();
  }

  _getProfile() async{
    _isloading = true;
    final api = apiRoutes['bid_clientprofile_get'].toString();
    response = await NetworkServices().getService(api+jidSend); // call api
    final responseBody = jsonDecode(response.body); // json Decode
    client = FreelancerClientModel.fromJson(responseBody); // add to model
    setState(() {
      _isloading = false;
    });
  }

  Column profileTextBox(String title, String data){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(title, 
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey
            )
          )
        ),
        const SizedBox(height: 8),
        Container(
          alignment: Alignment.topLeft,
          child: Text(data,
            style: const TextStyle(
              fontSize: 14,
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
        const SizedBox(height: 12)
      ],
    );
  }

  Widget actualBody(){
    var photoApi = imageUrl+client.photo.toString();
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
                //color: Colors.red,
                height: 126,
                width: 256,             
                padding: const EdgeInsets.only(top: 42),
                child: Column(                   
                  children: [
                    Container(  //........... freelancer profile Text
                      padding: const EdgeInsets.fromLTRB(0, 8, 46, 0),
                      child: const Text("Client Profile",
                        style: TextStyle(                        
                          color:Color.fromARGB(255, 36, 198, 241),
                          fontSize: 22,
                          fontFamily: "serif"
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        (client.isVerified == false)?
                        Row(
                          children: const [
                            Text("Not verified"),  //......................verified
                            Icon(Icons.dangerous_outlined , color: Colors.grey),
                          ],
                        ):
                        Row(
                          children: const [
                            Text("verified"),  //......................verified
                            Icon(Icons.verified, color: Colors.green),
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
                  height: 500,
                  width: 298,
                  child: Column(
                    children: [                      
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.only(left: 4),
                        child:(_isloading == true)?const CircularProgressIndicator():
                        Column(                        
                          children: [
                            const SizedBox(height: 3),
                            Wrap(children: [  // ................. profile content
                              profileTextBox("id", client.id.toString()),
                              profileTextBox("First Name", client.firstName.toString()),
                              profileTextBox("Last Name", client.lastName.toString()),
                              profileTextBox("email", client.email.toString()),
                              profileTextBox("phone", client.phone.toString()),
                              profileTextBox("Company", client.company.toString()),
                              profileTextBox("Location", client.location.toString()),
                            ],)
                          ] 
                        )
                      )
                    ],
                  )
                ),
              ),
              Container(  // ......................... right column
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
                      child: Text(client.contribution.toString(),
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
