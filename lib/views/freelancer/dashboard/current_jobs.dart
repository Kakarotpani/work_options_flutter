import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/repository/models/freelancer_model.dart';
import 'package:work_options/services/api_services.dart';

class CurrentJobs extends StatefulWidget {
  const CurrentJobs({ Key? key }) : super(key: key);

  @override
  State<CurrentJobs> createState() => _CurrentJobsState();
}

class _CurrentJobsState extends State<CurrentJobs> {
  late Response response;
  bool _isloading = false;
  List<FreelancerCurrentJob> freelancers = [];
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
    final api = apiRoutes['freelancer_contract_get'].toString();
    response = await NetworkServices().getService(api); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      freelancers = responseBody.map<FreelancerCurrentJob>((json) => FreelancerCurrentJob.fromJson(json)).toList(); // response to List<Jobs>
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
              padding: EdgeInsets.fromLTRB(0,8,164,0),
              child: Text("Current jobs",
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
                        Text(freelancer.title.toString(), //title
                          textScaleFactor: 1,
                          style: const TextStyle(
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
                              Row(
                                children: [
                                  Text("job id : ", style: insideTextBold), //job id
                                  Text(freelancer.jobId.toString(), style: insideText,)
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
                                  Text("Duration : ",style: insideTextBold), //duration
                                  Text(freelancer.duration.toString(),style: insideText),
                                  Text(" days",style: insideTextBold)
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("Max Pay : ", style: insideTextBold), //max_pay
                                  Text("₹ ", style: insideTextBold),
                                  Text(freelancer.maxPay.toString(), style: insideText)
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
                              Row(
                                children: [
                                  Text("Email : ",style: insideTextBold), //email
                                  Text(freelancer.email.toString(),style: insideText),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("phone : ",style: insideTextBold), //phone
                                  Text(freelancer.phone.toString(),style: insideText),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("Description : ", style: insideTextBold), //description                              
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(freelancer.description.toString(), style: insideText),
                              const SizedBox(height: 6),

                              Card( // freelancer card
                                color: const Color.fromARGB(255, 185, 243, 226),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                margin: const EdgeInsets.all(4),
                                elevation: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Text("Selected bid : ", style: insideTextBold), //selected bid
                                          Text("\$ ", style: insideTextBold),
                                          Text(freelancer.amount.toString(), style: insideText)
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("Start date : ", style: insideTextBold), //start dt
                                          Text(freelancer.startDate.toString(), style: insideTextBold),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("deadline : ", style: insideTextBold), //deadline
                                          Text(freelancer.deadline.toString(), style: insideTextBold),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
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
