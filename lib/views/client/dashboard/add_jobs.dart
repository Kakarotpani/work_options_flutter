import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:work_options/repository/models/client_model.dart';
import 'package:work_options/services/api_services.dart';
import 'package:work_options/views/client/dashboard/job_form.dart';

List ingredients = [];

class AddJob extends StatefulWidget {
  const AddJob({ Key? key }) : super(key: key);

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {

  late Response response;
  bool _isloading = false;
  List<ClientCurrentJob> clients = [];

  List<String> skillList = ['adobe','adobe-XD','c','css','c++','Django','Excel','html','java','javaScript','restframework'];
  List<String> selectedskillList = [];

  @override
  void initState(){
    super.initState();
  }

  _postJob() async{
    _isloading = true;
    final api = apiRoutes['job_post'].toString();

    List<dynamic> _ingredients = ingredients;
    String jsonSkill = jsonEncode(_ingredients);
    Map<String,dynamic> body ={
      'title': jobTitleController.text,
      'description': descriptionController.text,
      'duration': durationController.text,
      'max_pay': maxPayController.text,
      'skill': jsonSkill
    };
    Response jobPostResponse = await NetworkServices().postService(api, body); //call api
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (jobPostResponse.statusCode == 200)?
          const Text("Job added Successfully ."):
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
  
  _showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //Here we will build the content of the dialog
        return AlertDialog(
          title: const Text("Select skills"),
          content: HomeScreen(), 
        );
      }
    );
  }
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
              child: Text("Add a job",
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
                      const AddJobForm(), // add job form
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(  // .................. skills
                            child: const Text("set skills"),
                            style: constants.addJobButtonStyle,
                            onPressed: () => _showReportDialog(),
                          ), 
                          ElevatedButton(
                            onPressed: () => _postJob(), 
                            child: const Text("add job"),  //add btn
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

// myMultiSelectionFormField.dart

class MyMultiSelectionField<T> extends StatelessWidget {

  MyMultiSelectionField({
    Key? key,
    required this.onChanged,
    required this.values,
  }) : super( key: key );

  ValueChanged<List> onChanged;
  List<String> values;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          onSubmitted: (String value) {
            values.add(value);
            onChanged(values);
          },
        ),
        MyChipList(
          values: values,
          chipBuilder: (String value) {
            return Chip(
              backgroundColor: const Color.fromARGB(255, 118, 250, 228),
              label: Text(value),
              onDeleted: () {
                values.remove(value);
                onChanged(values);
              },
            );
          }
        )
      ],
    );
  }
}

// ----------------------------------- skill

class MyMultiSelectionFormField<T> extends FormField<List<T>> {

  final InputDecoration decoration;

  MyMultiSelectionFormField({
    Key? key,
    this.decoration = const InputDecoration(),
    FormFieldSetter<List>? onSaved,
    FormFieldValidator<List>? validator,
  }) : super(
    key: key,
    onSaved: onSaved,
    validator: validator,
    builder: (FormFieldState<List> field) {
      final InputDecoration effectiveDecoration =
          decoration.applyDefaults(
            Theme.of(field.context).inputDecorationTheme,
          );
      return InputDecorator(
        decoration: effectiveDecoration.copyWith(errorText: field.errorText),
        isEmpty: field.value?.isEmpty ?? true,
        child: MyMultiSelectionField(
          values: field.value?.map((e) => e.toString()).toList() ?? [],
          onChanged: field.didChange,
        ),
      );
    }
  );
}

//-------------------------------

class MyChipList<T> extends StatelessWidget {

  const MyChipList({
    Key? key, 
    required this.values,
    required this.chipBuilder,
  }) : super(key: key);

  final List<T> values;
  final Chip Function(T) chipBuilder;

  List<Widget> _buildChipList() {
    final List<Widget> items = [];
    for (T value in values) {
      items.add(chipBuilder(value));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChipList(),
    );
  }
}


// ===============================================

class HomeScreen extends StatefulWidget { // skill Widget
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  
  bool _isloading= false;
  late Response response;
  dynamic responseBody;
  List<FreelancerSkill> skills = [];
  List<String> addSkill = [];

  _postSkill(List<dynamic> ingredients) async{
    _isloading = true;
    final api = apiRoutes['job_post'].toString();
   
    String jsonSkill = jsonEncode(ingredients); // json serialization of List<String>
    Map<String,dynamic> body = {
      'skill': jsonSkill
    };
    Response jobPostResponse = await NetworkServices().postService(api, body); //call api
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (jobPostResponse.statusCode == 200)?
          const Text("skill added."):
          const Text("Something Wrong !!"),
          actions: <Widget>[
            ElevatedButton(
              style: constants.addJobButtonStyle,
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            )
          ],
        );
      }  
    );
    setState(() {
      _isloading = false;
    });
  }

  Widget noSkill(){
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
          child: const Text("No Skills.", textScaleFactor: 1.8)
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyMultiSelectionFormField(
                  decoration: const InputDecoration(
                    labelText: 'Add Skills',
                  ),
                  validator: (ingredients) => (ingredients?.length ?? 0) < 1
                    ? 'Please add at least 1 skills'
                    : null,
                  onSaved: (sampleIngredients) {
                    ingredients = sampleIngredients!;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _formKey.currentState!.save();
                        Navigator.of(context).pop();

                        //_postSkill(ingredients); // skill-post method call 
                      });
                    }
                  },
                  child: const Text('Submit'), // skill-submit btn
                  style: constants.updateButtonStyle,
                ),
              ],
            )
          )
        ),
      ),
    );
  }
}