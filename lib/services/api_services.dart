import 'package:http/http.dart';
import 'dart:convert';
import 'package:work_options/config/routes/api_routes.dart';
import 'package:work_options/repository/secure_storage.dart';

class NetworkServices{

  final String baseUrl = 'http://10.0.2.2:8000/';
  //final String baseUrl = 'https://dashgirija.pythonanywhere.com/';

  // Login Service
  Future loginService(String email, String password) async {
    Response response = await post(Uri.parse(baseUrl+apiRoutes['login_api'].toString()), body: {"email": email,"password": password});  
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body);
      UserSecureStorage.setAccessToken(responseBody['access_token'].toString());  
      UserSecureStorage.setRefreshToken(responseBody['refresh_token'].toString());
      print(responseBody.toString());
    }
    else{
      dynamic responseBody = "Login Failed !!";
      print(responseBody);      
    }
    return response;
  }

  // Register Service
  Future registerService(Map<String,dynamic> body) async {
    String isFreelancer = (body['userType'] == "freelancer") ? "true" : "false";
    String isClient = (body['userType'] == "client") ? "true": "false";
    Map<String,dynamic> bodySend = body;
    print(bodySend);

    Response response = await post(Uri.parse(baseUrl+apiRoutes['register_api'].toString()), body: bodySend);
    if (response.statusCode == 200){
      final responseBody = jsonDecode(response.body);
      print(responseBody.toString());
    }
    else{
      dynamic responseBody = "Couldn't register !!";
      print("isFreelancer "+ isFreelancer);
      print("isClient "+ isClient);
    }
    return response;
  }

  // Post Service
  Future postService(String api, Map<String,dynamic> body) async{
    final apiSend = api.toString();
    Map<String,dynamic> bodySend = body;
    print("BODY : $body");
    String? accessToken = await UserSecureStorage.getAccessToken();                      

    Response response = await post(Uri.parse(baseUrl+apiSend), headers: {"Authorization" : "Bearer $accessToken"}, body: bodySend);
    print("send url : "+baseUrl+apiSend);
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body).toString();
      return response;
    }
    else if(response.statusCode == 401){
      await newAccessToken(); // ask for new token
      postService(api, body); // recursive call
      print("ask for new access token");
    }
    else{
      dynamic responseBody = "No data not 200, not 400";
      print(responseBody);
      return response;
    }
  }

  // Get Service
  Future getService(String api) async{
    String? accessToken = await UserSecureStorage.getAccessToken();
    Map<String,String> headerSend = {    
      "Authorization" : "Bearer $accessToken"
    };
    Response response = await get(Uri.parse(baseUrl+api), headers : headerSend);
    if(response.statusCode == 200){  
      print("Done : "+jsonDecode(response.body).toString());
      return response;
    }
    else if(response.statusCode == 401){ // token expired
      dynamic accessResponse = await newAccessToken(); // ask for new token
      if (accessResponse.statusCode == 200){
        await getService(api); // recursive call
      }
    }
    else{
      print("status cOdE from SERVICE : ");
      print(response.statusCode);
      return response;
    }
  }

  // put Service
  Future putService(String api, Map<String, dynamic> body) async{
    String? accessToken = await UserSecureStorage.getAccessToken();
    final response = await put(Uri.parse(baseUrl+api), headers: {"Authorization" : "Bearer $accessToken", "Accept": "application/json"}, body: body);
    print(baseUrl+api);
    print(body);
    if (response.statusCode == 200){
      return response;
    }
    else if(response.statusCode == 401){ // token expired
      await newAccessToken(); // ask for new token
      postService(api, body); // recursive call
      print("ask for new access token");
    }
    else{
      dynamic responseBody = "No data not 200, not 400";
      print(responseBody);
      return response;
    }
  }

  // delete Service
  Future deleteService(String api) async{
    String? accessToken = await UserSecureStorage.getAccessToken();
    Map<String,String> headerSend = {    
      "Authorization" : "Bearer $accessToken"
    };
    Response response = await delete(Uri.parse(baseUrl+api), headers : headerSend);
    if(response.statusCode == 200){
      return response;
    }
    else if(response.statusCode == 401){ // token expired
      dynamic accessResponse = await newAccessToken(); // ask for new token
      if (accessResponse.statusCode == 200){
        await getService(api); // recursive call
      }
    }
    else{
      print("status cOdE from SERVICE : ");
      print(response.statusCode);
      return response;
    }
  }

  // New Access Token Service
  Future newAccessToken() async{
    String? refreshToken = await UserSecureStorage.getRefreshToken();

    Response response =  await post(Uri.parse(baseUrl+apiRoutes['refresh_token_api'].toString()), body: {"refresh": refreshToken});
    if (response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      UserSecureStorage.setAccessToken(responseBody['access'].toString()); //set new access token
      return response;
      print("new access token fetched !!");
      print("new access token : "+responseBody['access'].toString());
    }
    else{
      print("Couldn't fetch new access token");
      return response;
    }
  }

 // forget password
  Future forgetService(Map<String,dynamic> body) async{
    const apiSend = 'api/password_reset/';
    Map<String,dynamic> bodySend = body;
    print("BODY : $body");
    String? accessToken = await UserSecureStorage.getAccessToken();                      

    Response response = await post(Uri.parse(baseUrl+apiSend), body: bodySend);
    print("send url : "+baseUrl+apiSend);
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body).toString();
      return response;
    }
    else{
      dynamic responseBody = "No data not 200, not 400";
      print(responseBody);
      return response;
    }
  }

 // forget password
 Future newPassService(Map<String,dynamic> body) async{
    const apiSend = 'api/password_reset/confirm/';
    Map<String,dynamic> bodySend = body;
    print("BODY : $body");
    String? accessToken = await UserSecureStorage.getAccessToken();                      

    Response response = await post(Uri.parse(baseUrl+apiSend), body: bodySend);
    print("send url : "+baseUrl+apiSend);
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body).toString();
      return response;
    }
    else{
      dynamic responseBody = "No data not 200, not 400";
      print(responseBody);
      return response;
    }
  }


  // Freelancer Profile upload
  Future freelancerProfileUpload(String api, Map<String,dynamic> body) async{
    String? accessToken = await UserSecureStorage.getAccessToken();  
    Map<String ,String> headerSend ={
      "Authorization" : "Bearer $accessToken",
      "Content-type": "multipart/form-data"
    };
    var request = MultipartRequest('POST', Uri.parse(baseUrl+api));
    request.headers.addAll(headerSend);
    request.files.add(await MultipartFile.fromPath('f_photo', body['photo']));
    request.fields['tag'] = body['tag'];
    request.fields['f_sex'] = body['sex'];
    request.fields['dob'] = body['dob'];
    request.fields['f_location'] = body['location'];
    request.fields['qualification'] = body['qualification'];
    request.fields['experience'] = body['experience'];
    print("REQUEST ---- "+ request.fields.toString());
    var res = await request.send();
    return res;
  }

  // Freelancer profile update
  Future freelancerProfileUpdate(String api, Map<String,dynamic> body) async{
    String? accessToken = await UserSecureStorage.getAccessToken();  
    Map<String ,String> headerSend ={
      "Authorization" : "Bearer $accessToken",
      "Content-type": "multipart/form-data"
    };
    var request = MultipartRequest('PUT', Uri.parse(baseUrl+api));
    request.headers.addAll(headerSend);
    if(body['photo'] != null){
      request.files.add(await MultipartFile.fromPath('f_photo', body['photo']));
    }
    else{
      // no photo selected
    }
    request.fields['first_name'] = body['first_name'];
    request.fields['last_name'] = body['last_name'];
    request.fields['email'] = body['email'];
    request.fields['phone'] = body['phone'];
    request.fields['tag'] = body['tag'];
    request.fields['f_sex'] = body['sex'];
    request.fields['dob'] = body['dob'];
    request.fields['f_location'] = body['location'];
    request.fields['qualification'] = body['qualification'];
    request.fields['experience'] = body['experience'];
    print("REQUEST ---- "+ request.fields.toString());
    var res = await request.send();
    return res;
  }

  // Client Profile upload
  Future clientProfileUpload(String api, Map<String,dynamic> body) async{
    String? accessToken = await UserSecureStorage.getAccessToken();  
    Map<String ,String> headerSend ={
      "Authorization" : "Bearer $accessToken",
      "Content-type": "multipart/form-data"
    };
    var request = MultipartRequest('POST', Uri.parse(baseUrl+api));
    request.headers.addAll(headerSend);
    request.files.add(await MultipartFile.fromPath('photo', body['photo']));
    request.fields['location'] = body['location'];
    request.fields['sex'] = body['sex'];
    request.fields['company'] = body['company'];
    print("REQUEST ---- "+ request.fields.toString());
    var res = await request.send();
    return res;
  }

  // Client profile update
  Future clientProfileUpdate(String api, Map<String,dynamic> body) async{
    String? accessToken = await UserSecureStorage.getAccessToken();  
    Map<String ,String> headerSend ={
      "Authorization" : "Bearer $accessToken",
      "Content-type": "multipart/form-data"
    };
    var request = MultipartRequest('PUT', Uri.parse(baseUrl+api));
    request.headers.addAll(headerSend);
    if(body['photo'] != null){
      request.files.add(await MultipartFile.fromPath('photo', body['photo']));
    }
    else{
      // no photo selected
    }
    request.fields['first_name'] = body['first_name'];
    request.fields['last_name'] = body['last_name'];
    request.fields['email'] = body['email'];
    request.fields['phone'] = body['phone'];
    request.fields['location'] = body['location'];
    request.fields['sex'] = body['sex'];
    request.fields['company'] = body['company'];
    print("REQUEST ---- "+ request.fields.toString());
    var res = await request.send();
    return res;
  }
  Future getJobService(String api) async{
    String? accessToken = await UserSecureStorage.getAccessToken();
    
    Response response = await get(Uri.parse(baseUrl+api));
    if(response.statusCode == 200){  
      print("Done : "+jsonDecode(response.body).toString());
      return response;
    }
    else{
      print("status cOdE from SERVICE : ");
      print(response.statusCode);
      return response;
    }
  }

  Future GuestpostService(String api, Map<String,dynamic> body) async{
    final apiSend = api.toString();
    Map<String,dynamic> bodySend = body;
    print("BODY : $body");
    String? accessToken = await UserSecureStorage.getAccessToken();                      

    Response response = await post(Uri.parse(baseUrl+apiSend), headers: {"Authorization" : "Bearer $accessToken"}, body: bodySend);
    print("send url : "+baseUrl+apiSend);
    if(response.statusCode == 200){
      final responseBody = jsonDecode(response.body).toString();
      return response;
    }
    else{
      dynamic responseBody = "No data not 200, not 400";
      print(responseBody);
      return response;
    }
  }

}


