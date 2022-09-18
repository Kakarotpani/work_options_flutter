import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/repository/models/client_model.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/client/dashboard/review_form.dart';

class CurrentJobs extends StatefulWidget {
  const CurrentJobs({ Key? key }) : super(key: key);

  @override
  State<CurrentJobs> createState() => _CurrentJobsState();
}

class _CurrentJobsState extends State<CurrentJobs> {

  late Response response;
  bool _isloading = false;
  List<ClientCurrentJob> clients = [];
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
    final api = apiRoutes['contract_get'].toString();
    response = await NetworkServices().getService(api); // call api
    print(response.statusCode);
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      clients = responseBody.map<ClientCurrentJob>((json) => ClientCurrentJob.fromJson(json)).toList(); // response to List<Jobs>
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
  
  _submitResponse(String contractId) async{
    _isloading = true;
    final api = apiRoutes['history_post'].toString();
    Map<String,String> body ={
      'ratings': ratingsController.text,
      'review': reviewController.text
    };
    Response reviewResponse = await NetworkServices().postService(api+contractId, body);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (reviewResponse.statusCode == 200)?
          const Text("Contract is over now ."):
          const Text("Something went Wrong !!"),
          actions: <Widget>[
            ElevatedButton(
              style: constants.addJobButtonStyle,
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pushNamed('/client/job/history')
            )
          ],
        );
      }  
    );
    setState(() {
      _isloading = false;
    });
  }

  reviewDialog(String contractId){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Project review"),
          content: const SizedBox(
            child: ReviewForm()
          ),
          actions: <Widget>[
            ElevatedButton(
              style: constants.addJobButtonStyle,
              child: const Text("submit"),
              onPressed: () => _submitResponse(contractId)
              //Navigator.of(context).pop(),
            )
          ],
        );
      }  
    );
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
          child: const Text("No job Yet ... !!", textScaleFactor: 1.8)
        ),
      )
    );
  }

  Widget actualBody(){
    var jobList = clients.length;  // no. of job
    
    return
    //(_isloading==true)? const CircularProgressIndicator():
    SingleChildScrollView(
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
          (_isloading == true)? const CircularProgressIndicator(): 
          Column(
            children: [
              //for(int i=0;i<jobList;i++) //.........loop
              for(var client in clients)
              Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color.fromARGB(255, 46,237,230),width: 0.8),
                  borderRadius: BorderRadius.circular(14)
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
                                Text("Post date : ", style: insideTextBold), //post dt
                                Text(client.postDate.toString(), style: insideText)
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text("Duration : ",style: insideTextBold), //duration
                                Text(client.duration.toString(),style: insideText),
                                Text(" days",style: insideTextBold)
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text("Max Pay : ", style: insideTextBold), //max_pay
                                Text("\₹ ", style: insideTextBold),
                                Text(client.maxPay.toString(), style: insideText)
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text("Description : ", style: insideTextBold), //description                              
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(client.description.toString(), style: insideText),
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
                                        Text("Freelancer : ", style: insideTextBold), //freelancer
                                        InkWell(
                                          child: Text(client.freelancer.toString(),
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
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text("Email : ",style: insideTextBold), //email
                                        Text(client.email.toString(),style: insideText),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text("Selected bid : ", style: insideTextBold), //selected bid
                                        Text("\₹ ", style: insideTextBold),
                                        Text(client.selectedBid.toString(), style: insideText)
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text("Start date : ", style: insideTextBold), //start dt
                                        Text(client.startDate.toString(), style: insideText),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text("deadline : ", style: insideTextBold), //deadline
                                        Text(client.deadline.toString(), style: insideText),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("job id : ", style: insideTextBold), //job id
                                            Text(client.jobId.toString(), style: insideText),
                                          ],
                                        ),
                                        ElevatedButton(
                                          onPressed: () => reviewDialog(client.contractId.toString()), // call review pop-up
                                          child: const Text("finish"),
                                          style: constants.updateButtonStyle,
                                        )
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: actualBody()
    );
  }
}

