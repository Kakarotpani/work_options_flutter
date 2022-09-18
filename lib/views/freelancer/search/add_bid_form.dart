import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart';

final TextEditingController bidAmountController = TextEditingController();
final TextEditingController aboutYouController = TextEditingController();

class AddYourBidForm extends StatefulWidget {
  const AddYourBidForm({ Key? key }) : super(key: key);

  @override
  State<AddYourBidForm> createState() => _AddYourBidFormState();
}

class _AddYourBidFormState extends State<AddYourBidForm> {
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
            addBidInputText("bid Amount", bidAmountController),
            addBidInputText("About You", aboutYouController)
          ],
        ) 
      ),
    );
  }
}
