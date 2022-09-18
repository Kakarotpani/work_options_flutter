import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/repository/models/client_model.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/client/freelancer_profile/freelancer_profile_view.dart';

class SearchResult extends StatefulWidget {
  String text;

  SearchResult({ Key? key, required this.text}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SearchResult> createState() => _SearchResultState(text);
}

class _SearchResultState extends State<SearchResult> {
  String text;
  _SearchResultState(this.text);

  late Response response;
  bool _isloading = false;
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

  _getSearch(String searchItem) async{
    _isloading = true;
    Map<String,dynamic> body={
      'search': searchItem
    };
    final api = apiRoutes['client_search'].toString();
    response = await NetworkServices().postService(api, body); // call api
    if(response.statusCode == 200){
      print(text);
      searchResponseBody = jsonDecode(response.body); // json Decode
      jobs = searchResponseBody.map<ClientSearch>((json) => ClientSearch.fromJson(json)).toList(); // response to List<Jobs>
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: searchResult()
      ),
    );
  }
}