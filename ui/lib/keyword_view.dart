import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'dart:js';
import 'dart:convert';

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
    } else {
      print(response.reasonPhrase);
    }
  }

  void getWebsitesToSearch(String words) async {
    var uri = 'https://6cmpd1.deta.dev/?input=${words}';
    var wordArray = words.split(' ');
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      for (var i = 0; i < body.length; i++) {
        for (var j = 0; j < body[i]['links'].length; j++) {
          var link = body[i]['links'][j];
          print(link);
          print('word:${body[i]['query']},link: ${link}');
          openWebPage(link);
        }
      }
    } else {
      print(response.statusCode);
    }
  }

  void openWebPage(String url) {
    var options = new JsObject.jsify({'url': url, 'active': true});
    context['chrome']['tabs'].callMethod('create', [options]);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add the UI code here
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xfffff6ec),
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
                fixedSize: const Size(300, 42.5),
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
                    fontSize: 13.1,
                  )),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // USE PADDING IF LEFT ALIGNED
              // const Padding(padding: EdgeInsets.only(left: 10)),
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
              SizedBox(
                width: 180,
                height: 134,
                child: MacosTextField(
                  controller: _keywordInputController,
                  focusNode: _textFocus,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  placeholder:
                      "A wealthy 50 year old man\nwho lives in Malta and\ndrives a Ford Mustang",
                  placeholderStyle: const TextStyle(color: Color(0x665f5f5f)),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 15)),
              ElevatedButton(
                  onPressed: () {
                    getWebsitesToSearch(_keywordInputController.text);
                  },
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
                  ))
            ],
          )
        ],
      ),
    );
  }
}
