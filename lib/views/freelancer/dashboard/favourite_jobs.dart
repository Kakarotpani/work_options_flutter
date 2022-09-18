import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/repository/models/freelancer_model.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/freelancer/search/add_bid_form.dart';

class FavouriteJobs extends StatefulWidget {
  const FavouriteJobs({ Key? key }) : super(key: key);

  @override
  State<FavouriteJobs> createState() => _FavouriteJobsState();
}

class _FavouriteJobsState extends State<FavouriteJobs> {
  late Response response;
  bool _isloading = false;
  List<FreelancerFavourites> freelancers = [];
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
    final api = apiRoutes['freelancer_favourite_get'].toString();
    response = await NetworkServices().getService(api); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      freelancers = responseBody.map<FreelancerFavourites>((json) => FreelancerFavourites.fromJson(json)).toList(); // response to List<Jobs>
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

  _addBid(String jobId) async{
    _isloading = true;
    final api = apiRoutes['freelancer_bid_post'].toString();
    Map<String,String> body ={
      'amount': bidAmountController.text,
      'about': aboutYouController.text
    };
    Response reviewResponse = await NetworkServices().postService(api+jobId, body);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (reviewResponse.statusCode == 200)?
          const Text("Bid added ..!!"):
          const Text("Something went Wrong !!"),
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

  _removeFavourite(String fId) async{
    final api = apiRoutes['freelancer_favourite_delete'].toString();
    response = await NetworkServices().deleteService(api+fId); // call api
    if(response.statusCode == 200){
      setState(() {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Successfully removed from Favourite."),
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
    else{
      setState(() {
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Couldn't removed from Favourite"),
            actions: <Widget>[
              ElevatedButton(
                style: constants.addJobButtonStyle,
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pushNamed('/freelancer/job/favourite');
                }
              )
            ],
          );
        } 
      );
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

  addYourBid(String jobId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //Here we will build the content of the dialog
        return AlertDialog(
          title: const Text("Add bid"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              AddYourBidForm() //.................. add your bid form
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              style: constants.updateButtonStyle,
              child: const Text("add"),
              onPressed: () => _addBid(jobId)
              //selectedskillList
            )
          ],
        );
      }
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
              child: Text("Favourite jobs",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Job id : ", style: insideTextBold), //job id
                                      Text(freelancer.jobId.toString(), style: insideText,)
                                    ],
                                  ),
                                  InkWell(
                                    onTap: (() {
                                      _removeFavourite(freelancer.favId.toString());
                                    }),
                                    child: const Icon(Icons.favorite_outlined, color: Colors.pink, size: 40),
                                  )
                                  
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("Bids : ", style: insideTextBold), //bids
                                  Text(freelancer.bids.toString(), style: insideText)
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
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text("Description : ", style: insideTextBold), //description                              
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(freelancer.description.toString(), style: insideText),
                              const SizedBox(height: 6),
                              Container(
                                alignment: Alignment.topRight,
                                child: ElevatedButton(
                                  onPressed: () => addYourBid(freelancer.jobId.toString()),
                                  child: const Text("add your bid"),
                                  style: constants.updateButtonStyle,
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
