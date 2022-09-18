import 'package:flutter/material.dart';

import 'package:work_options/views/client/freelancer_profile/freelancer_profile_view.dart';
import 'package:work_options/views/client/profile/profile_upload_view.dart';
import 'package:work_options/views/client/profile/profile_view.dart';
import 'package:work_options/views/client/search/search_result_view.dart';
import 'package:work_options/views/freelancer/client_profile/client_profile_view.dart';
import 'package:work_options/views/freelancer/profile/profile_upload_view.dart';
import 'package:work_options/views/freelancer/profile/profile_view.dart' as fp;
import 'package:work_options/views/guest_view.dart';
import 'package:work_options/views/login/forget_pass_view.dart';
import 'package:work_options/views/login/new_pass_view.dart';

import 'package:work_options/views/splash/splash_view.dart';
import 'package:work_options/views/login/login_view.dart';
import 'package:work_options/views/register/register_view.dart';

import 'package:work_options/views/bottom_navigation/bottom_nav_view.dart';

import 'package:work_options/views/client/dashboard/dashboard_view.dart' as cdashboard;
import 'package:work_options/views/client/dashboard/current_jobs.dart' as c1;
import 'package:work_options/views/client/dashboard/add_jobs.dart' as c2;
import 'package:work_options/views/client/dashboard/manage_jobs.dart' as c3;
import 'package:work_options/views/client/dashboard/update_job.dart' as c4;
import 'package:work_options/views/client/dashboard/pending_requests.dart' as c5;
import 'package:work_options/views/client/dashboard/job_history.dart' as c6;

import 'package:work_options/views/freelancer/dashboard/dashboard_view.dart' as fdashboard;
import 'package:work_options/views/freelancer/dashboard/current_jobs.dart' as f1;
import 'package:work_options/views/freelancer/dashboard/favourite_jobs.dart' as f2;
import 'package:work_options/views/freelancer/dashboard/applied_jobs.dart' as f3;
import 'package:work_options/views/freelancer/dashboard/job_history.dart' as f4;

class AppRouter {
  static Route ? generateRoute(RouteSettings settings){
    switch(settings.name){
        //basic
      case "/":{
        return MaterialPageRoute(builder: (_) => const SplashView());
      }
      case "/login":{
        return MaterialPageRoute(builder: (_) => const LoginView());
      }
      case "/register":{
        return MaterialPageRoute(builder: (_) => const RegisterView());
      }
      case "/forgot":{
        return MaterialPageRoute(builder: (_) => const ForgetPassView());
      }
      case "/new/password":{
        return MaterialPageRoute(builder: (_) => const NewPass());
      }
      case "/guest":{
        return MaterialPageRoute(builder: (_) => const JobList());
      }
        // client
      case "/client/bottom/nav":{
        return MaterialPageRoute(builder: (_) => const ClientBottomNavView());
      }
      case "/client/job/current":{
        return MaterialPageRoute(builder: (_) => const c1.CurrentJobs());
      }
      case "/client/job/add":{
        return MaterialPageRoute(builder: (_) => const c2.AddJob());
      }
      case "/client/job/manage":{
        return MaterialPageRoute(builder: (_) => const c3.ManageJobs());
      }
      /* case "/client/job/update":{
        return MaterialPageRoute(builder: (_) => const c4.UpdateJob());
      } */
      case "/client/requests/pending":{
        return MaterialPageRoute(builder: (_) => const c5.PendingRequests());
      }
      case "/client/job/history":{
        return MaterialPageRoute(builder: (_) => const c6.JobHistory());
      }/* 
      case "/client/search/result":{
        return MaterialPageRoute(builder: (_) => const SearchResult());
      } */
      /* case "/client/freelancer/profile":{
        return MaterialPageRoute(builder: (_) => const FreelancerProfileView());
      }   */
        // freelancer
      case "/freelancer/bottom/nav":{
        return MaterialPageRoute(builder: (_) => const FreelancerBottomNavView());
      }  
      case "/freelancer/job/current":{
        return MaterialPageRoute(builder: (_) => const f1.CurrentJobs());
      }
      case "/freelancer/job/favourite":{
        return MaterialPageRoute(builder: (_) => const f2.FavouriteJobs());
      }
      case "/freelancer/job/applied":{
        return MaterialPageRoute(builder: (_) => const f3.AppliedJobs());
      }
      case "/freelancer/job/history":{
        return MaterialPageRoute(builder: (_) => const f4.JobHistory());
      }/* 
      case "/freelancer/search/result":{
        return MaterialPageRoute(builder: (_) => const SearchResultF());
      } */
      /* case "/freelancer/client/profile":{
        return MaterialPageRoute(builder: (_) => const ClientProfileView());
      } */
      case "/client/upload":{
        return MaterialPageRoute(builder: (_) => const ClientProfileUpload());
      }
      case "/client/profile/view":{
        return MaterialPageRoute(builder: (_) => const ProfileView());
      }
      case "/freelancer/upload":{
        return MaterialPageRoute(builder: (_) => const FreelancerProfileUpload());
      }
      case "/freelancer/profile/view":{
        return MaterialPageRoute(builder: (_) => const fp.ProfileView());
      }
    }
    return null;
  }
}