import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart';
import 'package:work_options/repository/models/freelancer_model.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/client/search/search_form.dart';
import 'package:work_options/views/freelancer/client_profile/client_profile_view.dart';
import 'package:work_options/views/freelancer/search/add_bid_form.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobList extends StatefulWidget {
  const JobList({ Key? key }) : super(key: key);

  @override
  State<JobList> createState() => JobListState();
}

class JobListState extends State<JobList> {
  late Response response;
  bool _isloading = false;
  List<FreelancerRecommend> rcmnds = [];
  List<FreelancerSearch> jobs = [];
  dynamic responseBody;
  dynamic searchResponseBody;
  
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
    _getRecommend();
    //suggetions();
    super.initState();
  }

  _getRecommend() async{
    _isloading = true;
    response = await NetworkServices().getJobService("api/guest/view"); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      rcmnds = responseBody.map<FreelancerRecommend>((json) => FreelancerRecommend.fromJson(json)).toList(); // response to List<Jobs>
      setState(() {
        _isloading = false;
        suggetions();
      });
    }
    else{
      setState(() {
        _isloading= false;
      });
    }
  }

  Future optioncService() async {
    Map<String,dynamic> body = {
      'is_freelancer' : "false"
    };
    Response response = await NetworkServices().GuestpostService("api/guest/option", body);
    if(response.statusCode == 200){
      setState(() {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Registered as a client."),
            actions: <Widget>[
              ElevatedButton(
                style: addJobButtonStyle,
                child: const Text("OK"),
                onPressed: () => Navigator.of(context).pushNamed('/login')
              )
            ],
          );
        }  
      );
      });   
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("didn't rgister yet ??"),
            actions: <Widget>[
              ElevatedButton(
                style: addJobButtonStyle,
                child: const Text("register"),
                onPressed: () => Navigator.of(context).pushNamed('/register')
              )
            ],
          );
        }  
      );
    }
  }

  Future optionfService() async {
    Map<String,dynamic> body = {
      'is_freelancer' : "true"
    };
    Response response = await NetworkServices().GuestpostService("api/guest/option", body);
    if(response.statusCode == 200){
      setState(() {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Reistered as a Freelancer."),
            actions: <Widget>[
              ElevatedButton(
                style: addJobButtonStyle,
                child: const Text("OK"),
                onPressed: () => Navigator.of(context).pushNamed('/login')
              )
            ],
          );
        }  
      );
      });   
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Didn't register ??"),
            actions: <Widget>[
              ElevatedButton(
                style: addJobButtonStyle,
                child: const Text("register"),
                onPressed: () => Navigator.of(context).pushNamed('/register')
              )
            ],
          );
        }  
      );
    }
  }

  void optionc(){
    optioncService();
  }
  void optionf(){
    optionfService();
  }

  Widget suggetions(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container( // .................................. jobs for you text
          padding: const EdgeInsets.only(left: 236),
          alignment: Alignment.topLeft,
          child: const Text(             
            "Recent  Jobs", 
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 30),
          for(var rcmnd in rcmnds) //.........loop
          SizedBox(  //................................ searched result card
            child:
            Card(
              margin: const EdgeInsets.all(8),
              semanticContainer: true,
              elevation: 10,
              child: ExpansionTile(
                title: Text(rcmnd.title.toString(), // ............ job title
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 0, 0, 0)
                  )
                ),
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              (rcmnd.verified!)? const Icon(Icons.verified_outlined, color: Colors.green)://...... verified
                              const Icon(Icons.dangerous_outlined,color: Colors.red),
                              const SizedBox(width: 10),
                              InkWell(
                                child: Text(rcmnd.client.toString(), // .........................client name
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,                  
                                  )
                                ),
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ClientProfileView(jid: rcmnd.jobId.toString()))) // navigate to client profile
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Card(  //............................................................. inside content card
                        elevation: 8,
                        child: Container(
                          alignment: Alignment.topCenter,
                          width: 350,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text("job id : ", style: insideTextBold), //job id
                                      Text(rcmnd.jobId.toString(), style: insideText),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("Post date : ", style: insideTextBold), //post dt
                                  Text(rcmnd.postDate.toString(), style: insideText),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("Duration : ", style: insideTextBold), //duration
                                  Text(rcmnd.duration.toString(), style: insideTextBold),
                                  Text(" days", style: insideText),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("Max pay : ", style: insideTextBold), //max_pay
                                  Text("₹ ", style: insideTextBold),
                                  Text(rcmnd.maxPay.toString(), style: insideText),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text("Description : ", style: insideTextBold), //description                               
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(rcmnd.description.toString(), style: insideText),
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        /* Text("bids : ", style: insideTextBold), //bids
                                        Text(rcmnd.bids.toString(), style: insideText), */
                                        ElevatedButton(  //..................... add your bid
                                          child: const Text("add your bid"),
                                          onPressed: ()=> showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Register as a freelancer to bid."),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    style: addJobButtonStyle,
                                                    child: const Text("register"),
                                                    onPressed: () => optionf(),
                                                  )
                                                ],
                                              );
                                            }  
                                          ), 
                                          style: updateButtonStyle,
                                        ),
                                        ElevatedButton(  //..................... add your bid
                                          child: const Text("Add similar posts"),
                                          onPressed: ()=> showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text("Register as a Client to post Job."),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    style: addJobButtonStyle,
                                                    child: const Text("register"),
                                                    onPressed: () => optionc(),
                                                  )
                                                ],
                                              );
                                            }  
                                          ), 
                                          style: updateButtonStyle,
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ),
                      const SizedBox(height: 12)
                    ],
                  )
                ],
              )
            ),
          )
      ],
    );
  }

  Widget actualBody(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(        
            children: [
              Container(  // register image
              padding: const EdgeInsets.only(right: 140),
              child: Image.asset(
                splashImage,
                height: 240            
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 12, 80, 40),
              child: Text("Work Options",  
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromARGB(255, 29, 152, 227),
                  fontSize: 42,
                  fontWeight: FontWeight.w400,            
                ),
              ),
            ),
            const SizedBox(height: 20),
            ] 
          ), 
          suggetions(),
          const SizedBox(height: 60),
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
    pathTriangle.lineTo(0, -size.height*2);
    pathTriangle.lineTo(size.width*2, 0);
    pathTriangle.lineTo(size.width, size.height*3/2);
    pathTriangle.lineTo(0, size.height);
    //
    pathTriangle.close();
    canvas.drawPath(pathTriangle, paintTriangle);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

