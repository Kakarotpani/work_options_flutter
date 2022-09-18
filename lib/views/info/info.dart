import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart' as constants;

class InfoView extends StatelessWidget {
  const InfoView({ Key? key }) : super(key: key);

  final TextStyle insideText = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400
  );
  final TextStyle insideTextBold = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(              
            constants.userAskImage, // image 
            height: 200,
          ),
          SizedBox(
            //padding: EdgeInsets.fromLTRB(0,8,164,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text("Work Options",
                  style: TextStyle(       
                    fontFamily: 'serif',     
                    color: Color.fromARGB(255, 29, 152, 227),
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text("(release  V 1.0.0)", style: insideTextBold)
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0,2,16,0),
            child: Text("The ultimate freelance solution",
              style: TextStyle(       
                fontFamily: 'serif',     
                color: Color.fromARGB(255, 89, 207, 188),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12,30,6,0),
            child: const Text("\" Opportunity to post jobs and find suitable candidates for your tasks . Yes , the exact platform for job applicants to get their preferred jobs and search among various job categories and wide range of recognized clients around the globe.\" ",
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 16,
                wordSpacing: 1.6
              ),
            )
          ),
          //const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.fromLTRB(0,20, 246, 10),
            child: const Text("User Types",
              style: TextStyle(       
                fontFamily: 'serif',     
                color: Color.fromARGB(255, 29, 152, 227),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 250),
                child: Text("1- Freelancer",style: insideTextBold)
              ),
              const SizedBox(height: 6),
              Container(
                width: 340,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("- Access DASHBOARD to manage your projects easily.", style: insideText),
                    Text("- Search jobs , add them to your favourite, add your bids.", style: insideText),
                    Text("- Grab the contract ,  submit your project  within time , get paid .", style: insideText),
                  ] 
                ),
              ),
              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.only(right: 284),
                child: Text("2- Client",style: insideTextBold)
              ),
              const SizedBox(height: 6),
              Container(
                width: 340,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("- Post your jobs , search freelancers according to your need.", style: insideText),
                    Text("- Access freelancer profiles, select suitable bids, assign contracts .", style: insideText),
                    Text("- Get your job done by time with WORK OPTIONS (Thanks).", style: insideText)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}