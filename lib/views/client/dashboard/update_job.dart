import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/repository/models/client_model.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/client/dashboard/job_form.dart';

class UpdateJob extends StatefulWidget {
  dynamic jobId;
  UpdateJob({ Key? key , required this.jobId}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<UpdateJob> createState() => _UpdateJobState(jobId);
}

class _UpdateJobState extends State<UpdateJob> {

  String jobIdSend;
  _UpdateJobState(this.jobIdSend);
  late Response response;
  bool _isloading = false;
  dynamic responseBody;
  JobGet client = JobGet();
  List selectedskillList = [];

  @override
  void initState(){
    _jobget();
    super.initState();
  }

  _jobget() async{
    _isloading = true;
    final api = apiRoutes['job_single_get'].toString();
    response = await NetworkServices().getService(api+jobIdSend); // call api
    if(response.statusCode == 200){
      responseBody = jsonDecode(response.body); // json Decode

      print("hei re : "+responseBody.toString()); 

      client = JobGet.fromJson(responseBody);
      setState(() {
        jobTitleController.text = client.title.toString();
        descriptionController.text = client.description.toString();
        durationController.text = client.duration.toString();
        maxPayController.text = client.maxPay.toString();
        _isloading = false;
      });
    }
  }

  _putJob(String jobId) async{
    _isloading = true;
    final api = apiRoutes['job_put'].toString();
    Map<String,dynamic> body ={
      'title': jobTitleController.text,
      'description': descriptionController.text,
      'duration': durationController.text,
      'max_pay': maxPayController.text,
      'skill': selectedskillList.toString()
    };
    Response updateJobResponse = await NetworkServices().putService(api+jobIdSend, body); //call api
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (updateJobResponse.statusCode == 200)?
          const Text("Job updated Successfully ."):
          const Text("Something went Wrong !!"),
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
    setState(() {
      _isloading = false;
    });
  }

//---------------------------------------------  

/*   SkillsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //Here we will build the content of the dialog
        return AlertDialog(
          title: const Text("Select skills"),
          content: MultiSelectChip(
            skillList,
            onSelectionChanged: (selectedList) {
              setState(() {
                selectedskillList = selectedList;
              });
            },
            maxSelection: 6,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("submit"),
              style: constants.updateButtonStyle,
              onPressed: () => Navigator.of(context).pop(),
              //selectedskillList
            )
          ],
        );
      }
    );
  } */
  //---------------------------------------------

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.fromLTRB(0,0,204,0),
              child: Text("Update job",  //update-text
                style: TextStyle(       
                  fontFamily: 'serif',     
                  color: Color.fromARGB(255, 29, 152, 227),
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(      
              shape: RoundedRectangleBorder(
                //side: const BorderSide(color: Color.fromARGB(255, 29, 152, 227),width: 1),
                borderRadius: BorderRadius.circular(20)
              ),
              elevation: 6,            
              margin: const EdgeInsets.all(8),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    children: [
                      AddJobForm(), // add-job form
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /* ElevatedButton(  // ...............add skills
                            child: const Text("set skills"),
                            style: constants.addJobButtonStyle,
                            onPressed: () => SkillsDialog(),
                          ),  */
                          ElevatedButton(
                            onPressed: () =>_putJob(jobIdSend), 
                            child: const Text("update job"),  //update btn
                            style: constants.updateButtonStyle,
                          ),
                        ],
                      )
                    ],
                  )
                ),
              )
            )
          ],
        ),
      ),
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