import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: 9)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 13.3)),
                  //TODO: Logo Here
                  Image.asset('assets/images/hansel30x30.png'),
                  Padding(padding: EdgeInsets.only(left: 13.3)),
                  Text(
                    'Hansel',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xff87633e),
                          fontWeight: FontWeight.w600,
                          fontSize: 26,
                        )),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 9)),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 13.3)),
                  ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        fixedSize: const Size(80, 50),
                        backgroundColor: Color(0xff87633e),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/create-persona-image.png'),
                          const Padding(padding: EdgeInsets.only(left: 7)),
                          Text(
                            'Create\nPersona',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 8,
                                )),
                          )
                        ],
                      )
                  ),
                  Padding(padding: EdgeInsets.only(left: 13.3)),
                  ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        fixedSize: const Size(80, 50),
                        backgroundColor: Color(0xffedbe8e),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/go-image.png'),
                          const Padding(padding: EdgeInsets.only(left: 7)),
                          Text(
                            'Go!',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                )),
                          )
                        ],
                      )
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}