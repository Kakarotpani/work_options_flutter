import 'package:flutter/material.dart';
import 'package:work_options/constants/constants.dart' as constants;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';



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
            height: 236,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,        
          padding: const EdgeInsets.fromLTRB(16, 24, 0, 0),
          child: Text("Freelancer Dashboard",
            textAlign: TextAlign.start,
            style: TextStyle(
              foreground: Paint()..shader = linearGradient,
              fontSize: 30,
              fontFamily: 'serif',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.only(left: 230),
          child: Column(
            children: [
              FloatingActionButton( 
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),  
                backgroundColor: const Color.fromARGB(255, 75, 230, 106),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const DownloadingDialog(),
                  );
                },
                tooltip: 'Download File',
                child: const Icon(Icons.download),
              ),
              const Text("srs templates")
            ],
          ),
        ),

        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed('/freelancer/job/current'),
                  child: Card(  //................ Current jobs
                    color: const Color.fromARGB(255,41,249,26),
                    elevation: cardElevation,
                    shape: cardBorderRadius,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 160,
                          width: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                alignment: Alignment.topRight,
                                child: const Icon(Icons.file_copy_outlined,size: 40),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.only(left: 16),
                                child: const Text("Current jobs",style: cardTextStyleBlack),
                              )
                            ],
                          ),
                        ),  
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () => Navigator.of(context).pushNamed('/freelancer/job/favourite'),
                  child: Card(  //................ favourite jobs
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
                                padding: const EdgeInsets.only(right: 18),
                                alignment: Alignment.topRight,
                                child: const Icon(Icons.favorite_outline_outlined,color: Colors.white,size: 40),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.only(left: 16),
                                child: const Text("Favourite jobs",style: cardTextStyleWhite),
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
                  onTap: () => Navigator.of(context).pushNamed('/freelancer/job/applied'),
                  child: Card(  //................ applied jobs
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
                              Text("Applied jobs",
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
                  onTap: () => Navigator.of(context).pushNamed('/freelancer/job/history'),
                  child: Card(  //................ job history
                    color: const Color.fromARGB(255,24,31,249),
                    elevation: cardElevation,
                    shape: cardBorderRadius,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 140,
                          width: 160,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,                          
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 18),
                                alignment: Alignment.topRight,
                                child: const Icon(Icons.history_outlined,size: 40,color: Colors.white,),
                              ),
                              Container(
                                alignment: Alignment.bottomLeft,
                                padding: const EdgeInsets.only(left: 16),
                                child: const Text("job history",style: cardTextStyleWhite)
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
          ],
        ),
      ],
    );
  }
}

class DownloadingDialog extends StatefulWidget {
  const DownloadingDialog({Key? key}) : super(key: key);

  @override
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading() async {
    const String url = 'https://drive.google.com/uc?id=1gNYUPMPeg7f5HupM5O2SnvTSVYdz3yUY&export=download'; 
    //const String url = 'https://blog.cm-dm.com/public/Templates/software-requirements-specifications-template-2018.doc';
    //const String url = 'https://firebasestorage.googleapis.com/v0/b/e-commerce-72247.appspot.com/o/195-1950216_led-tv-png-hd-transparent-png.png?alt=media&token=0f8a6dac-1129-4b76-8482-47a6dcc0cd3e';

    const String fileName = "srs.doc";

    String path = await _getFilePath(fileName);

    await dio.download(
      url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        setState(() {
          progress = recivedBytes / totalBytes;
        });

        print(progress);
      },
      deleteOnError: true,
    ).then((_) {
      Navigator.pop(context);
    });
  }

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$filename";
  }

  @override
  void initState() {
    super.initState();
    startDownloading();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}