import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart';

final TextEditingController reviewController = TextEditingController();
final TextEditingController ratingsController = TextEditingController();

class ReviewForm extends StatefulWidget {
  const ReviewForm({ Key? key }) : super(key: key);

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _formKey,
      child: SingleChildScrollView(       
        child: Column(
          children: [
            reviewInputText("Review", "review",reviewController),
            reviewInputText("Ratings", "(1-5)",ratingsController),
          ],
        ) 
      ),
    );
  }
}
