import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/repository/models/client_model.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/client/dashboard/update_job.dart';

class ManageJobs extends StatefulWidget {
  const ManageJobs({ Key? key }) : super(key: key);

  @override
  State<ManageJobs> createState() => _ManageJobsState();
}

class _ManageJobsState extends State<ManageJobs> {

  late Response response;
  bool _isloading = false;
  List<JobGet> clients = [];
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
    _jobget(); 
    super.initState();
  }

  _jobget() async{
    _isloading = true;
    final api = apiRoutes['job_get'].toString();
    response = await NetworkServices().getService(api); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode
      clients = responseBody.map<JobGet>((json) => JobGet.fromJson(json)).toList(); // response to List<Jobs>
      setState(() {
        _isloading = false;
      });
    }
    else if(response.statusCode == 204){
      noJobWidget();
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Something Wrong !!"),
            actions: <Widget>[
              ElevatedButton(
                style: constants.addJobButtonStyle,
                child: const Text("OK"),
                onPressed: () => Navigator.of(context).pushNamed('/client/bottom/nav')
              )
            ],
          );
        }  
      );
    }
  }

  _deleteJob(String jobID) async{
    _isloading = true;
    final api = apiRoutes['job_delete'].toString();
    response = await NetworkServices().deleteService(api+jobID); // call api
    if(response.statusCode == 200){
      setState(() {
        _isloading = false;
      });
    }
  }

  deleteDialog(String jobId){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete this job ??"),
          actions: <Widget>[
            ElevatedButton(
              style: constants.addJobButtonStyle,
              child: const Text("delete"),
              onPressed: () {
                _deleteJob(jobId); //call delete function
                Navigator.of(context).pushNamed('/client/bottom/nav');
              }
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
          child: const Text("No jobs Yet ... !!", textScaleFactor: 1.8)
        ),
      )
    );
  }

  Widget _actualBody(){
    var jobList = clients.length;  // no. of job
    return SingleChildScrollView(
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
            child: Text("Manage jobs",
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
                            Row(
                              children: [
                                Text("Post date : ", style: insideTextBold), //post dt
                                Text(client.postdate.toString(), style: insideText,)
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text("Duration : ",style: insideTextBold), //duration                                
                                Text(client.duration.toString(),style: insideTextBold),
                                Text(" days", style: insideText),
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
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton( 
                                  child: const Text("update"),
                                  style: constants.updateButtonStyle,
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateJob(jobId: client.id.toString())))  // nav to update page           
                                ), 
                                ElevatedButton(
                                  onPressed: () => deleteDialog(client.id.toString()), // delete-job pop-up
                                  child: const Text("delete"),  // delete
                                  style: constants.deleteButtonStyle,
                                ),
                              ],
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
      body: _actualBody()
    );
  }
}

class MultiSelectChip extends StatefulWidget {   // Multi select class
  final List<String> skillList;
  final Function(List<String>)? onSelectionChanged;
  final Function(List<String>)? onMaxSelected;
  final int? maxSelection;

  MultiSelectChip(this.skillList, {Key? key, this.onSelectionChanged, this.onMaxSelected, this.maxSelection}) : super(key: key);

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = [];
  _buildChoiceList() {
    List<Widget> choices = [];

    widget.skillList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selectedColor: const Color.fromARGB(255, 46,237,230),
          backgroundColor: const Color.fromARGB(255, 224, 224, 224),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            if(selectedChoices.length == (widget.maxSelection  ?? -1) && !selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
                widget.onSelectionChanged?.call(selectedChoices);
              });
            }
          },
        ),
      ));
    });
    return choices;
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
