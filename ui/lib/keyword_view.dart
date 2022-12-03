import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class KeywordView extends StatefulWidget {
  const KeywordView({Key? key}) : super(key: key);

  @override
  State<KeywordView> createState() => _KeywordViewState();
}

class _KeywordViewState extends State<KeywordView> {
  late final TextEditingController _keywordInputController;
  late final FocusNode _textFocus;
  String keywordInput = '';

  @override
  void initState() {
    _keywordInputController = TextEditingController(text: keywordInput);
    _textFocus = FocusNode();

    super.initState();
  }
  
   void sendRequest(String words) async {
    var uri = 'http://127.0.0.1:8000/?input=${words}';
    var request = http.Request('GET', Uri.parse(uri));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add the UI code here
    return CupertinoPageScaffold(
      backgroundColor: Color(0xfffff6ec),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                fixedSize: const Size(200, 42.5),
                backgroundColor: Color(0xff87633e)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/keyword-icon-40x22.png'),
                const Padding(padding: EdgeInsets.only(left: 10)),
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
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                'Describe your persona',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                  color: Color(0xff87633e),
                  fontWeight: FontWeight.w600,
                  fontSize: 13.1,
                )),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(top: 5)),
              Container(
                width: 180,
                height: 134,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0x555f5f5f),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CupertinoTextField(
                      controller: _keywordInputController,
                      focusNode: _textFocus,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Color(0x00000000)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffffffff),
                            spreadRadius: -3.0,
                            blurRadius: 3.0,
                          )
                        ]
                      ),
                      cursorColor: Color(0xff000000),
                      placeholder: "A wealthy 50 year old man\nwho lives in Malta and\ndrives a Ford Mustang",
                      placeholderStyle: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color(0x665f5f5f),
                            fontWeight: FontWeight.w300,
                            fontSize: 13.1,
                          )
                      ),
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color(0xff5f5f5f),
                            fontWeight: FontWeight.w300,
                            fontSize: 13.1,
                          )
                      ),
                    )
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
              ElevatedButton(
                  onPressed: () {sendRequest(_keywordInputController.text);},
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    fixedSize: const Size(130, 24),
                    backgroundColor: Color(0xffa6d374),
                    shadowColor: Color(0xffa6d374),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'GO!',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        )),
                      ),
                    ],
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
