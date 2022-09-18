import 'package:flutter/material.dart';

import 'package:work_options/views/client/dashboard/current_jobs.dart' as c1;
import 'package:work_options/views/client/dashboard/add_jobs.dart' as c2;
import 'package:work_options/views/client/dashboard/manage_jobs.dart' as c3;
import 'package:work_options/views/client/dashboard/update_job.dart' as c4;
import 'package:work_options/views/client/dashboard/pending_requests.dart' as c5;
import 'package:work_options/views/client/dashboard/job_history.dart' as c6;

import 'package:work_options/views/freelancer/dashboard/current_jobs.dart' as f1;
import 'package:work_options/views/freelancer/dashboard/favourite_jobs.dart' as f2;
import 'package:work_options/views/freelancer/dashboard/applied_jobs.dart' as f3;
import 'package:work_options/views/freelancer/dashboard/job_history.dart' as f4;

import 'package:work_options/views/info/info.dart';

import 'package:work_options/views/client/dashboard/dashboard_view.dart' as cdashboard;
import 'package:work_options/views/client/search/search_view.dart' as csearch;
import 'package:work_options/views/client/profile/profile_upload_view.dart' as cprofile;

import 'package:work_options/views/freelancer/dashboard/dashboard_view.dart' as fdashboard;
import 'package:work_options/views/freelancer/search/search_view.dart' as fsearch;
import 'package:work_options/views/freelancer/profile/profile_upload_view.dart' as fprofile;


class ClientBottomNavView extends StatefulWidget {
  const ClientBottomNavView({ Key? key }) : super(key: key);

  @override
  State<ClientBottomNavView> createState() => _ClientBottomNavViewState();
}

class _ClientBottomNavViewState extends State<ClientBottomNavView> {
  int currentIndex = 0;

  _getBodyWidget(){  //....... navigation
    switch (currentIndex) {
      case 0 :
        return const cdashboard.DashboardView();
      case 1:
        return const csearch.SearchView(); 
      case 2 :
        return const cprofile.ClientProfileUpload(); 
      case 3:
        return const InfoView();
    }
  }

  Widget fixedNavBar(BuildContext context){
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: currentIndex,        
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      showUnselectedLabels: true,
      elevation: 0,
      onTap: (index){
        setState(() {
          currentIndex= index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "dashboard"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        BottomNavigationBarItem(icon: Icon(Icons.info), label: "info"),
      ]
    );
  }

  @override
  Widget build(BuildContext context) { //..... bottom nav
    return Scaffold(
      body: _getBodyWidget(),
      backgroundColor: Colors.white,  
      bottomNavigationBar: fixedNavBar(context)
    );
  }
}

class FreelancerBottomNavView extends StatefulWidget {
  const FreelancerBottomNavView({ Key? key }) : super(key: key);

  @override
  State<FreelancerBottomNavView> createState() => _FreelancerBottomNavViewState();
}

class _FreelancerBottomNavViewState extends State<FreelancerBottomNavView> {
  int currentIndex = 0;

  _getBodyWidget(){  //....... navigation
    switch (currentIndex) {
      case 0 :
        return const fdashboard.DashboardView();
      case 1:
        return const fsearch.SearchView(); 
      case 2 :
        return const fprofile.FreelancerProfileUpload(); 
      case 3:
        return const InfoView();
    }
  }

  @override
  Widget build(BuildContext context) { //..... bottom nav
    return Scaffold(
      body: _getBodyWidget(),
      backgroundColor: Colors.white,  
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,        
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
        elevation: 0,
        onTap: (index){
          setState(() {
            currentIndex= index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "info"),
        ]
      ),
    );
  }
}