import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/repository/models/freelancer_model.dart';
import 'package:work_options/services/api_services.dart';

class JobHistory extends StatefulWidget {
  const JobHistory({ Key? key }) : super(key: key);

  @override
  State<JobHistory> createState() => _JobHistoryState();
}

class _JobHistoryState extends State<JobHistory> {
  late Response response;
  bool _isloading = false;
  List<FreelancerHistory> freelancers = [];
  dynamic responseBody;
  
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
    _getCurrentJobs(); 
    super.initState();
  }

  _getCurrentJobs() async{
    _isloading = true;
    final api = apiRoutes['freelancer_history_get'].toString();
    response = await NetworkServices().getService(api); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      freelancers = responseBody.map<FreelancerHistory>((json) => FreelancerHistory.fromJson(json)).toList(); // response to List<Jobs>
      setState(() {
        _isloading = false;
      });
    }
    else{
      setState(() {
        _isloading= false;
        noJobWidget();
      });
    }
  }

  Widget noJobWidget(){
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
          child: const Text("No jobs Yet ... !!", textScaleFactor: 1.8)
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var jobList = freelancers.length; 
    return Scaffold(
      body: SingleChildScrollView(
        child: (_isloading==true)? const Center(  
          heightFactor: 20,
          widthFactor: 20,
          child: CircularProgressIndicator() // loading state
        ) : 
        Column(
          children: [
            Container( 
              alignment: Alignment.topLeft,
              child: Image.asset(              
                constants.addJobImage, // image 
                scale: 2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0,8,180,0),
              child: Text("Job history",
                style: TextStyle(       
                  fontFamily: 'serif',     
                  color: Color.fromARGB(255, 29, 152, 227),
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 28),
            jobList==0 ? noJobWidget() : //no job check     
            Column(
              children: [
                for(var freelancer in freelancers) //.........loop
                Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color.fromARGB(255, 46,237,230),width: 0.8),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 8,            
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        const Text("Want to automate my web app", //title
                          textScaleFactor: 1,
                          style:TextStyle(
                            color: Color.fromARGB(255, 13, 177, 149),
                            fontSize: 22,
                          )
                        ),
                        const SizedBox(height: 6),
                        const Divider(height: 4,color: Colors.black),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text("job id : ", style: insideTextBold), //job id
                                  Text(freelancer.jobId.toString(), style: insideText),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("Post date : ", style: insideTextBold), //post dt
                                  Text(freelancer.postDate.toString(), style: insideText,)
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("Client : ", style: insideTextBold), //client
                                  InkWell(
                                    child: Text(freelancer.client.toString(),
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                        fontSize: 16
                                      )
                                    ),
                                    onTap: (){}, // client-profile-view
                                  )
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text("Description : ", style: insideTextBold), //description                              
                                ],
                              ),
                              Text(freelancer.description.toString(), style: insideText),
                              const SizedBox(height: 6),

                              Card( // freelancer card
                                color: const Color.fromARGB(255, 185, 243, 226),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                margin: const EdgeInsets.all(4),
                                elevation: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Text("applied bid : ", style: insideTextBold), //applied bid
                                          Text("₹ ", style: insideTextBold),
                                          Text(freelancer.bid.toString(), style: insideText)
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text("Start date : ", style: insideTextBold), //start dt
                                            Text("freelancer.", style: insideText,)
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text("End date : ", style: insideTextBold), //end dt
                                            Text(freelancer.submitDate.toString(), style: insideText,)
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text("Review : ", style: insideTextBold), //review
                                          ],
                                        ),
                                        Text(freelancer.review.toString(), style: insideText),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}
