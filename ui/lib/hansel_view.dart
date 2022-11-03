import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/keyword_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HanselView extends StatefulWidget {
  const HanselView({Key? key}) : super(key: key);

  @override
  State<HanselView> createState() => _HanselViewState();
}

class _HanselViewState extends State<HanselView> {

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add the UI code here
    return CupertinoPageScaffold(
      backgroundColor: Color(0xfffff6ec),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 10, left: 10)),
              Row(
                children: [
                  //TODO: Logo
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Image.asset('assets/images/hansel30x30.png'),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    'Hansel',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xff87633e),
                          fontWeight: FontWeight.w600,
                          fontSize: 25.4,
                        )),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            CupertinoPageRoute(builder: (context) => const KeywordView())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        fixedSize: const Size(180, 78),
                        backgroundColor: Color(0xff87633e),
                        shadowColor: Color(0xff87633e),
                      ),
                      child: Column(
                        children: [
                          // TODO: Keyword Input Logo and Text
                          const Padding(padding: EdgeInsets.only(top: 11)),
                          Image.asset('assets/images/keyword-icon-62x34.png'),
                          const Padding(padding: EdgeInsets.only(top: 8)),
                          Text(
                            'Keyword Input',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.4,
                                )),
                          ),
                        ],
                      )
                  ),
                  // TODO: OR lines and text (include padding in asset)
                  Image.asset('assets/images/or-divider-180x24.png'),
                  ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        fixedSize: const Size(180, 78),
                        backgroundColor: Color(0xffedbe8e),
                        shadowColor: Color(0xffedbe8e),
                      ),
                      child: Column(
                        // TODO: Persona Customization Logo and Text
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 11)),
                          Image.asset('assets/images/persona-customization-icon-62x34.png'),
                          const Padding(padding: EdgeInsets.only(top: 8)),
                          Text(
                            'Persona Customization',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.4,
                                )),
                          ),
                        ],
                      )
                  ),
                  const Padding(padding: EdgeInsets.only(top: 15)),
                  // TODO: Github Icon Link
                  IconButton(
                    onPressed: () async {
                      Uri url = Uri(
                          scheme: 'https',
                          host: 'github.com',
                          path: '/boraberke/persona-extension-comp491'
                      );
                      var urlLaunchable = await canLaunchUrl(url); //canLaunch is from url_launcher package
                      if(urlLaunchable){
                        await launchUrl(url); //launch is from url_launcher package to launch URL
                      }
                    },
                    icon: Image.asset('assets/images/github-icon-20x20.png'),
                  ),
                ],
              ),
            ],
          ),
    );
  }
}