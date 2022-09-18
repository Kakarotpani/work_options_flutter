import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart' as constants;


class DashboardView extends StatefulWidget {
  const DashboardView({ Key? key }) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final Shader linearGradient = const LinearGradient(
    colors: [Color.fromARGB(236, 233, 81, 220),Color.fromARGB(255, 77, 5, 83)]
    ).createShader(const Rect.fromLTWH(0, 0, 240,60)
  );
  final double cardElevation = 8;
  final RoundedRectangleBorder cardBorderRadius = RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
  static const TextStyle cardTextStyleWhite = TextStyle(
    color: Colors.white,
    fontFamily: 'serif',
    fontSize: 18
  );
  static const TextStyle cardTextStyleBlack = TextStyle(
    color: Colors.black,
    fontFamily: 'serif',
    fontSize: 18
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Image.asset(
            constants.dashBoardImage,
            height: 200,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,        
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: Text("Client Dashboard",
            textAlign: TextAlign.start,
            style: TextStyle(
              foreground: Paint()..shader = linearGradient,
              fontSize: 30,
              fontFamily: 'serif',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 26),

        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed('/client/job/current'),
                  child: Card(  //................ Current job
                    color: const Color.fromARGB(255,41,249,26),
                    elevation: cardElevation,
                    shape: cardBorderRadius,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 154,
                          width: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 18),
                                alignment: Alignment.topRight,
                                child: const Icon(Icons.file_open_outlined,size: 40),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.only(left: 16),
                                child: const Text("Current job",style: cardTextStyleBlack),
                              )
                            ],
                          ),
                        ),  
                      ],
                    ),
                  ),
                ),
       
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed('/client/job/add'),
                  child: Card(  //................ add job
                    color: const Color.fromARGB(255,255,0,128),
                    elevation: cardElevation,
                    shape: cardBorderRadius,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 98,
                          width: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 20),
                                alignment: Alignment.topRight,
                                child: const Icon(Icons.add_business_outlined,color: Colors.white,size: 40),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.only(left: 20),
                                child: const Text("Add job",style: cardTextStyleWhite),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],  
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed('/client/requests/pending'),
                  child: Card(  //................ pending requests
                    color: const Color.fromARGB(255, 46,237,230),
                    elevation: cardElevation,
                    shape: cardBorderRadius,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                          width: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(Icons.lock_clock_outlined,size: 40),
                              Text("Pending Requests",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "serif"
                                )
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ), 

                InkWell(
                  onTap: () => Navigator.of(context).pushNamed('/client/job/manage'),
                  child: Card(  //................ manage jobs
                    color: const Color.fromARGB(255,255,255,0),
                    elevation: cardElevation,
                    shape: cardBorderRadius,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 124,
                          width: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 20),
                                alignment: Alignment.topRight,
                                child: const Icon(Icons.work_outline,size: 40),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.only(left: 20),
                                child: const Text("Manage jobs",style: cardTextStyleBlack),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],  
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed('/client/job/history'),
                    child: Card(  //................ job history
                    color: const Color.fromARGB(255,24,31,249),
                    elevation: cardElevation,
                    shape: cardBorderRadius,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 64,
                          width: 352,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text("Job history",style: cardTextStyleWhite),
                              Icon(Icons.history, size: 40, color: Colors.white)                            
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}