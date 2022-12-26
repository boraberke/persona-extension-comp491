import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Persona {
  String name = '';
  String age = '';
  String location = '';
  String profession = '';
  String gender = '';
  String maritalStatus = '';
  String education = '';
  String income = '';
  String bookInterest = '';
  String moviesTvInterest = '';
  String musicInterest = '';
  String sportInterest = '';
  String hobby = '';

  Map toJSON() => {
        'Name': name,
        'Age': age,
        'Location': location,
        'Profession': profession,
        'Gender': gender,
        'Marital Status': maritalStatus,
        'Education': education,
        'Income': income,
        'Book Interest': bookInterest,
        'Movies TV Interest': moviesTvInterest,
        'Music Interest': musicInterest,
        'Sport Interest': sportInterest,
        'Hobby': hobby
      };

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/saved_personas.txt');
  }

  Future<List<String>> getAllPersonasNames() async {
    // Read file
    final contents = loadAsset();

    // Wait for the contents
    String data = await contents;

    // Decode String into JSON
    Map<String, dynamic> body = jsonDecode(data);

    // Fill the list
    List<String> names = <String>[];
    body.forEach((personaName, personaInfo) {
      names.add(personaName);
    });

    return names;
  }

  Future<Persona> getPersona(String personaName) async {
    try {
      // Read file
      final contents = loadAsset();

      // Wait for the contents
      String data = await contents;

      // Decode String into JSON
      Map<String, dynamic> body = jsonDecode(data);

      Persona persona = Persona();

      if (body['success']) {
        final personaInfo = body[personaName];

        persona.name = personaInfo['Name'];
        persona.age = personaInfo['Age'];
        persona.location = personaInfo['Location'];
        persona.profession = personaInfo['Profession'];
        persona.gender = personaInfo['Gender'];
        persona.maritalStatus = personaInfo['Marital Status'];
        persona.education = personaInfo['Education'];
        persona.income = personaInfo['Income'];
        persona.bookInterest = personaInfo['Book Interest'];
        persona.moviesTvInterest = personaInfo['Movies TV Interest'];
        persona.musicInterest = personaInfo['Music Interest'];
        persona.sportInterest = personaInfo['Sport Interest'];
        persona.hobby = personaInfo['Hobby'];
      }

      return persona;
    } catch (e) {
      // If encountering an error, return empty Persona
      return Persona();
    }
  }

  Future<void> writePersona(Persona persona) async {
    final file = File('assets/saved_personas.txt');

    // Write String to file
    file.writeAsStringSync(persona.toJSON().toString(), mode: FileMode.append);
  }

  Future<File> deletePersona(String personaName) async {
    final file = File('assets/saved_personas.txt');

    List<Persona> personaList = <Persona>[];
    Persona persona;

    // Get all personas except target persona
    final contents = await file.readAsString();
    Map<String, dynamic> body = jsonDecode(contents);
    body.forEach((key, personaInfo) {
      if (personaInfo['Name'].toString() != personaName) {
        persona = Persona();

        persona.name = personaInfo['Name'];
        persona.age = personaInfo['Age'];
        persona.location = personaInfo['Location'];
        persona.profession = personaInfo['Profession'];
        persona.gender = personaInfo['Gender'];
        persona.maritalStatus = personaInfo['Marital Status'];
        persona.education = personaInfo['Education'];
        persona.income = personaInfo['Income'];
        persona.bookInterest = personaInfo['Book Interest'];
        persona.moviesTvInterest = personaInfo['Movies TV Interest'];
        persona.musicInterest = personaInfo['Music Interest'];
        persona.sportInterest = personaInfo['Sport Interest'];
        persona.hobby = personaInfo['Hobby'];

        personaList.add(persona);
      }
    });

    // Clear File
    file.writeAsString('');

    // Write remaining personas to file
    for (var persona in personaList) {
      file.writeAsString(persona.toJSON().toString(), mode: FileMode.append);
    }

    // Return new file
    return file;
  }
}
