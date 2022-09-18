import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart';

TextEditingController jobTitleController = TextEditingController();
TextEditingController durationController = TextEditingController();
TextEditingController maxPayController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

class AddJobForm extends StatefulWidget {
  const AddJobForm({ Key? key }) : super(key: key);

  @override
  State<AddJobForm> createState() => _AddJobFormState();
}

class _AddJobFormState extends State<AddJobForm> {
  final _formKey = GlobalKey<FormState>();
    
  @override
  Widget build(BuildContext context) {
    return Container(
      key: _formKey,
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
      child: SingleChildScrollView(       
        child: Column(
          children: [
            addBidInputText("Job title", jobTitleController),
            addBidInputText("Duration", durationController),
            addBidInputText("Max Pay", maxPayController),
            addBidInputText("Decsription", descriptionController),
          ],
        ) 
      ),
    );
  }
}
