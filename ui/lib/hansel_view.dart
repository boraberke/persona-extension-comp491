import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:ui/customization_view.dart';
import 'package:ui/keyword_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HanselView extends StatefulWidget {
  const HanselView({Key? key}) : super(key: key);

  @override
  State<HanselView> createState() => _HanselViewState();
}

class _HanselViewState extends State<HanselView> {
  late final TextEditingController _accessIdInputController;

  @override
  void initState() {
    super.initState();
    _accessIdInputController = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add the UI code here
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xfffff6ec),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 10, left: 10)),
              Row(
                children: [
                  //TODO: Logo
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Image.asset('assets/images/hansel30x30.png'),
                  const Padding(padding: EdgeInsets.only(left: 10)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Access ID:',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xff87633e),
                          fontWeight: FontWeight.w600,
                          fontSize: 13.1,
                        )),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 5)),
                  SizedBox(
                      width: 80,
                      height: 30,
                      child: MacosTextField(
                        controller: _accessIdInputController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        placeholder: "mtsezgin",
                        placeholderStyle: const TextStyle(
                          color: Color(0x665f5f5f),
                        ),
                      )),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
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
                        backgroundColor: const Color(0xff87633e),
                        shadowColor: const Color(0xff87633e),
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
                      onPressed: (){
                        if (_accessIdInputController.text.isNotEmpty) {
                          String accessID = _accessIdInputController.text;
                          Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) => CustomizationView(accessID: accessID,))
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        fixedSize: const Size(180, 78),
                        backgroundColor: const Color(0xffedbe8e),
                        shadowColor: const Color(0xffedbe8e),
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
                  // TODO: Github Icon Link
                  SizedBox(
                    child: IconButton(
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
                  ),
                ],
              ),
            ],
          ),
    );
  }
}