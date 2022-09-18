import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/repository/models/client_model.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/client/freelancer_profile/freelancer_profile_view.dart';
import 'package:work_options/views/client/search/search_form.dart';
import 'package:work_options/views/client/search/search_result_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({ Key? key }) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late Response response;
  bool _isloading = false;
  List<ClientRecommend> rcmnds = [];
  List<ClientSearch> jobs = [];
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
    final api = apiRoutes['client_recommend'].toString();
    response = await NetworkServices().getService(api); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      rcmnds = responseBody.map<ClientRecommend>((json) => ClientRecommend.fromJson(json)).toList(); // response to List<Jobs>
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

  _getSearch(String searchItem) async{
    _isloading = true;
    Map<String,dynamic> body={
      'search': searchItem
    };
    final api = apiRoutes['client_search'].toString();
    response = await NetworkServices().postService(api, body); // call api
    if(response.statusCode == 200){
      searchResponseBody = jsonDecode(response.body); // json Decode
      jobs = searchResponseBody.map<ClientSearch>((json) => ClientSearch.fromJson(json)).toList(); // response to List<Jobs>
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => SearchResult(text: searchController.text),
        ));
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
          child: const Text("No Content..", textScaleFactor: 1.8)
        ),
      )
    );
  }

  Widget searchResult(){  //...................search result
  var jobcount = jobs.length; 
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container( //....................................searched result Text
          padding: const EdgeInsets.only(left: 16),
          alignment: Alignment.topLeft,
          child: const Text(             
            "Searched Results", 
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(height: 30),
        (jobcount==0)? noJobWidget():
        Column(
          children: [
            for(var job in jobs) //.........loop
            Card(
              margin: const EdgeInsets.all(8),
              semanticContainer: true,
              elevation: 10,
              child: ExpansionTile(
                title: InkWell(
                  child: Text(job.freelancer.toString(), // freelancer
                    style: const TextStyle(fontSize: 18)
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FreelancerProfileView(fid: job.fid))) // navigate to freelancer profile view
                ),
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              (job.tag == null)?  // tag null check
                              const Text("Freelancer", style: TextStyle(fontSize: 18,color: Colors.pink)):
                              Text(job.tag.toString(), style: const TextStyle(fontSize: 18,color: Colors.pink)),
                              (job.isVerified!)? const Icon(Icons.verified_outlined, color: Colors.green):
                              const Icon(Icons.dangerous_outlined, color: Colors.red), //...... verified
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16), Column(
                        children: [ // ............ exp. & contribution
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Experience : ", style: insideTextBold),
                              Text(job.experience.toString(), style: insideText),
                              Text(" Years", style: insideTextBold),
                            ]
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Contribution : ", style: insideTextBold),
                              Text(job.contribution.toString(), style: insideText),
                              Text(" Projects", style: insideTextBold),
                            ]
                          ),
                        ]
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
        Container( //....................................searched result Text
          padding: const EdgeInsets.only(left: 16),
          alignment: Alignment.topLeft,
          child: const Text(             
            "Freelancers for you", 
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(height: 30),
        Column(
          children: [
            for(var r in rcmnds) //.........loop
            Card(
              margin: const EdgeInsets.all(8),
              semanticContainer: true,
              elevation: 10,
              child: ExpansionTile(
                title: InkWell(
                  child: Text(r.freelancer.toString(), // freelancer
                    style: const TextStyle(fontSize: 18)
                  ),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FreelancerProfileView(fid: r.fid.toString()))) // navigate to freelancer profile view
                ),
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              (r.tag == null)?  // tag null check
                              const Text("Freelancer", style: TextStyle(fontSize: 18,color: Colors.pink)):
                              Text(r.tag.toString(), style: const TextStyle(fontSize: 18,color: Colors.pink)),
                              (r.isVerified!)? const  Icon(Icons.verified_outlined, color: Colors.green):
                              const Icon(Icons.dangerous_outlined, color: Colors.red), //...... verified
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16), Column(
                        children: [ // ............ exp. & contribution
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Experience : ", style: insideTextBold),
                              Text(r.experience.toString(), style: insideText),
                              Text(" Years", style: insideTextBold),
                            ]
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Contribution : ", style: insideTextBold),
                              Text(r.contribution.toString(), style: insideText),
                              Text(" Projects", style: insideTextBold),
                            ]
                          ),
                        ]
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
                      onTap: ()=> Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => SearchResult(text: 'Hello',),
                      )),
                      //_getSearch(searchController.text)
                    ),
                  )
                ],
              )
            ] 
          ),
          const SizedBox(height: 60),
          suggetions(),
          const SizedBox(height: 60),
          //searchResult()
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
