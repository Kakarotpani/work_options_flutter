import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/repository/models/client_model.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/client/freelancer_profile/freelancer_profile_view.dart';

class PendingRequests extends StatefulWidget {
  const PendingRequests({ Key? key }) : super(key: key);

  @override
  State<PendingRequests> createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  
  late Response response;
  bool _isloading = false;
  List<ClientPendingRequests> clients = [];
  dynamic responseBody;

  @override
  void initState(){    
    _getCurrentJobs(); 
    super.initState();
  }

  _getCurrentJobs() async{
    _isloading = true;
    final api = apiRoutes['client_bid_get'].toString();
    response = await NetworkServices().getService(api); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      print(responseBody.toString());
      clients = responseBody.map<ClientPendingRequests>((json) => ClientPendingRequests.fromJson(json)).toList(); // response to List<Jobs>
      setState(() {
        _isloading = false;
      });
    }
  }

  _selectBid(String bidId) async{
    _isloading = true;
    final api = apiRoutes['contract_post'].toString();
    Map<String,String> body={};
    Response selectBidResponse = await NetworkServices().postService(api+bidId, body);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (selectBidResponse.statusCode == 200)?
          const Text("Contract Placed ."):
          const Text("Something went Wrong !!"),
          actions: <Widget>[
            ElevatedButton(
              style: constants.addJobButtonStyle,
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pushNamed('/client/job/current'),
            )
          ],
        );
      }  
    );
    setState(() {
      _isloading = false;
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

  Widget noBidWidget(){
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
          child: const Text("No bids Yet ... !!", textScaleFactor: 1.8)
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var jobList = clients.length; // no of job
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
              padding: EdgeInsets.fromLTRB(0,8,100,0),
              child: Text("Pending requests",
                style: TextStyle(       
                  fontFamily: 'serif',     
                  color: Color.fromARGB(255, 29, 152, 227),
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 28),
            jobList==0 ? noBidWidget() : //no Bid check     
            Column(
              children: [
                for(var client in clients)
                (_isloading==true)? const CircularProgressIndicator():
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
                                  Text(client.postDate.toString(), style: insideText,)
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
                                  Text("₹ ", style: insideTextBold),
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
                                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FreelancerProfileView(fid: client.fid.toString()))) // navigate to freelancer profile view
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("applied bid : ", style: insideTextBold), //applied bid
                                          Text("\₹ ", style: insideTextBold),
                                          Text(client.amount.toString(), style: insideText)
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("bid date : ", style: insideTextBold), //bid dt
                                          Text(client.bidDate.toString(), style: insideText),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("about : ", style: insideTextBold), //about                                        
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(client.about.toString(), style: insideText),
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
                                            onPressed: () => _selectBid(client.bidId.toString()), 
                                            child: const Text("select bid"),  //select btn
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
      ),
    );
  }
}
