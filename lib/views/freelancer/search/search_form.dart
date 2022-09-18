import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart';

final TextEditingController searchController = TextEditingController();

class SearchForm extends StatefulWidget {
  const SearchForm({ Key? key }) : super(key: key);

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: 50,
      width: 360,
      left: 20,
      bottom: 20,
      key: _formKey,    
      child: searchInputText("search skills", searchController),
    );
  }
}
