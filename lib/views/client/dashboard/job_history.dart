import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/repository/models/client_model.dart';
import 'package:work_options/services/api_services.dart';

class JobHistory extends StatefulWidget {
  const JobHistory({ Key? key }) : super(key: key);

  @override
  State<JobHistory> createState() => _JobHistoryState();
}

class _JobHistoryState extends State<JobHistory> {  

  late Response response;
  bool _isloading = false;
  List<ClientJobHistory> clients = [];
  dynamic responseBody;

  @override
  void initState(){    
    _getJobHistory(); 
    super.initState();
  }

  _getJobHistory() async{
    _isloading = true;
    final api = apiRoutes['history_get'].toString();
    response = await NetworkServices().getService(api); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      clients = responseBody.map<ClientJobHistory>((json) => ClientJobHistory.fromJson(json)).toList(); // response to List<Jobs>
      setState(() {
        _isloading = false;
      });
    }
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
          padding: const EdgeInsets.all(4),
          child: const Text("No jobs..!!", textScaleFactor: 1.8)
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var jobList = clients.length;  // no. of job
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                for(var client in clients)  //.........loop
                (_isloading==true)? const CircularProgressIndicator(): //check loading
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
                        Text(client.title.toString(), //title
                          textScaleFactor: 1,
                          style:const TextStyle(
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
                                  Text(client.jobId.toString(), style: insideText),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text("Post date : ", style: insideTextBold), //post dt
                                  Text(client.postDate.toString(), style: insideText)
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text("Review : ", style: insideTextBold), //Review
                                  Text(client.review.toString(), style: insideText)                             
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text("Description : ", style: insideTextBold), //description                              
                                ],
                              ),
                              Text(client.description.toString(), style: insideText),
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
                                          Text("Freelancer : ", style: insideTextBold), //freelancer
                                          InkWell(
                                            onTap: () {},  //nav-freelancer-profile
                                            child: Text( client.freelancer.toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'serif',
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w300,
                                                decoration: TextDecoration.underline
                                              )
                                            )
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("applied bid : ", style: insideTextBold), //applied bid
                                          Text("₹ ", style: insideTextBold),
                                          Text(client.bid.toString(), style: insideText)
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("start date : ", style: insideTextBold), //start dt
                                          Text(client.startDate.toString(), style: insideText)
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("End date : ", style: insideTextBold), //end dt
                                          Text(client.endDate.toString(), style: insideText)
                                        ],
                                      ),
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
