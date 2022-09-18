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

class SearchView extends StatefulWidget {
  const SearchView({ Key? key }) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
    suggetions();
    super.initState();
  }

  _getRecommend() async{
    _isloading = true;
    final api = apiRoutes['freelancer_recommend'].toString();
    response = await NetworkServices().getService(api); // call api
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
        noJobWidget();
      });
    }
  }

  _getSearch(String searchItem) async{
    _isloading = true;
    Map<String,dynamic> body={
      'search': searchItem
    };
    final api = apiRoutes['freelancer_search'].toString();
    response = await NetworkServices().postService(api, body); // call api
    if(response.statusCode == 200){
      searchResponseBody = jsonDecode(response.body); // json Decode
      jobs = searchResponseBody.map<FreelancerSearch>((json) => FreelancerSearch.fromJson(json)).toList(); // response to List<Jobs>
      setState(() {
        _isloading = false;
        searchResult();
      });
    }
    else{
      setState(() {
        _isloading= false;
        noJobWidget();
      });
    }
  }

  _addFavourite(String jobId) async{
    _isloading = true;
    final api = apiRoutes['freelancer_favourite_post'].toString();
    Map<String,String> body ={};
    Response reviewResponse = await NetworkServices().postService(api+jobId, body);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (reviewResponse.statusCode == 200)?
          const Text("Added to Favourite .."):
          const Text("Something went Wrong !!"),
          actions: <Widget>[
            ElevatedButton(
              style: addJobButtonStyle,
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

  _deleteFav(String fId) async{
    _isloading = true;
    final api = apiRoutes['freelancer_favourite_delete'].toString();
    response = await NetworkServices().deleteService(api+fId); // call api
    if(response.statusCode == 200){
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (response.statusCode == 200)?
          const Text("Removed from Favourite ..!!"):
          const Text("Something went Wrong !!"),
          actions: <Widget>[
            ElevatedButton(
              style: addJobButtonStyle,
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
              style: addJobButtonStyle,
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
          child: const Text("Not found..", textScaleFactor: 1.8)
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
              style: updateButtonStyle,
              child: const Text("add"),
              onPressed: () => _addBid(jobId)
            )
          ],
        );
      }
    );
  }

  Widget searchResult(){  //.................. search result
  var jobcount = jobs.length; 
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container( // ......................   searched result text
          padding: const EdgeInsets.only(left: 12),
          alignment: Alignment.topLeft,
          child: const Text(             
            "Search Results", 
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(height: 30),
        (jobcount==0)? noJobWidget():
          Column(  //................................ searched result card
            children: [
              for(var job in jobs) //.........loop
              Card(
                margin: const EdgeInsets.all(8),
                semanticContainer: true,
                elevation: 10,
                child: ExpansionTile(
                  title: Text(job.job.toString(), // ............ job title
                    style: const TextStyle(fontSize: 18, color: Colors.pink)
                  ),
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                (job.isVerified!)? const  Icon(Icons.verified_outlined, color: Colors.green):
                                const Icon(Icons.dangerous_outlined, color: Colors.red),//...... verified
                                const SizedBox(width: 10),
                                InkWell(
                                  child: Text(job.client.toString(), // .........................client name
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,                       
                                    )
                                  ),
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ClientProfileView(jid: job.id.toString()))) // navigate to client profile
                                ),
                              ],
                            ),
                            (job.isFavourite!) ? // fav_check
                            InkWell(
                              child: const Icon(Icons.favorite_rounded,color: Colors.pink,size: 40),
                              onTap: ()=> _deleteFav(job.fId.toString())
                            ):
                            InkWell(
                              child: const Icon(Icons.favorite_outline_outlined,color: Colors.pink,size: 40),
                              onTap: ()=> _addFavourite(job.id.toString()),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Card( // ....................................... inside content card
                          elevation: 8,
                          child: Container(
                            alignment: Alignment.topCenter,
                            width: 350,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [  
                                    Text("post id : ", style: insideTextBold), //post_ID
                                    Text(job.id.toString(), style: insideText,)
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text("Post date : ", style: insideTextBold), //post_dt
                                    Text(job.postDate.toString(), style: insideText),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text("Duration : ", style: insideTextBold), //duration
                                    Text(job.duration.toString(), style: insideTextBold),
                                    Text(" days", style: insideText),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text("Max pay : ", style: insideTextBold),
                                    Text("₹", style: insideTextBold),
                                    Text(job.maxPay.toString(), style: insideText),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Text("Description : ", style: insideTextBold),                                  
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(job.description.toString(), style: insideText),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Text("bids : ", style: insideTextBold),
                                          Text(job.bids.toString(), style: insideText),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(  //..................... add your bid
                                      onPressed: ()=> addYourBid(job.id.toString()),  //....................... add your bid form
                                      child: const Text("add your bid"),
                                      style: updateButtonStyle,
                                    )
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
            ],
          )
      ],
    );
  }

  Widget suggetions(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container( // .................................. jobs for you text
          padding: const EdgeInsets.only(left: 12),
          alignment: Alignment.topLeft,
          child: const Text(             
            "Jobs for you", 
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
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
                    color: Colors.pink
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
                          (rcmnd.isFavourite!) ? // fav_check
                          InkWell(
                            child: const Icon(Icons.favorite_rounded,color: Colors.pink,size: 40),
                            onTap: ()=> _deleteFav(rcmnd.fId.toString())
                          ):
                          InkWell(
                            child: const Icon(Icons.favorite_outline_outlined,color: Colors.pink,size: 40),
                            onTap: ()=> _addFavourite(rcmnd.jobId.toString()),
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
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Text("bids : ", style: insideTextBold), //bids
                                        Text(rcmnd.bids.toString(), style: insideText),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(  //..................... add your bid
                                    child: const Text("add your bid"),
                                    onPressed: ()=> addYourBid(rcmnd.jobId.toString()), 
                                    style: updateButtonStyle,
                                  )
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
          Row(        
            children: [
              Stack(
                children: [
                  Container(  //........ triangle
                    padding: const EdgeInsets.all(0),
                    height: 140,
                    width: 390,
                    child: CustomPaint(foregroundPainter: TopTrianglePainter()),            
                  ),
                  const SearchForm(), // ............ search form    
                  Positioned(
                    bottom: 30,
                    right: 20,
                    child: InkWell(
                      child: const Icon(Icons.search),
                      onTap: ()=> _getSearch(searchController.text)
                    ),
                  )
                ],
              )
            ] 
          ), 
          const SizedBox(height: 60),
          suggetions(),
          const SizedBox(height: 60),
          searchResult()
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: actualBody(),
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

