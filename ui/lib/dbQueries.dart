import 'dart:convert';
import 'dart:io';
import 'dart:js';

import 'package:http/http.dart' as http;
import 'objects/Persona.dart';

Future<List<Persona>> getPersonaList(String accessID) async {
  var uri = 'https://370sl8.deta.dev/users/${accessID}';
  var response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    try {
      Iterable l = json.decode(response.body);
      List<Persona> personas =
          List<Persona>.from(l.map((model) => Persona.fromJson(model)));

      return personas;
    } catch (e) {
      throw Exception('Failed to load personas.');
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load personas.');
  }
}

Future<String> deletePersonaFromList(String accessID, String name) async {
  var uri = 'https://370sl8.deta.dev/users/${accessID}/${name}';
  var response = await http.delete(Uri.parse(uri));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to remove persona from list.');
  }
}

void getWebsitesToSearchfromPersona(Persona persona) async {
  var uri = 'https://370sl8.deta.dev/search-persona';
  var headers = {'Content-Type': 'application/json'};
  var temp =
      '''{"age": 23,"location": "Istanbul","profession": "Student","gender": "Male","marital_status": "Single","education": "Bachelor\'s in Computer Science","income": "<\$25,000","book_interest": ["Andrzej Sapkowski"],"movies_interest": ["Henry Cavill"],"music_interest": ["Ramin Djawadi"],\n"sport_interest": ["Lionel Messi"],"hobby": ["FIFA 23"],"key": "9pi57ar6gvfu","name": "Kerem"}''';
  var response = await http.post(Uri.parse(uri),
      body: jsonEncode(persona), headers: headers);
  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
    var firstPageLink = body[0]['links'][0];
    print(firstPageLink);
    print('word:${body[0]['query']},link: ${firstPageLink}');
    int screenWidth = context['screen']['availWidth'];
    int screenHeight = context['screen']['availHeight'];
    int windowWidth = screenWidth ~/ 2;
    int windowHeight = screenHeight ~/ 2;
    int windowLeft = (screenWidth - windowWidth) ~/ 2;
    int windowTop = (screenHeight - windowHeight) ~/ 2;
    context['chrome']['windows'].callMethod('create', [
      JsObject.jsify({
        'url': firstPageLink,
        'width': windowWidth,
        'height': windowHeight,
        'left': windowLeft,
        'top': windowTop,
      }),
      (JsObject window) {
        int windowId = window['id'];
        for (var i = 0; i < body.length; i++) {
          // first page should be opened in a new window and return the window id.
          for (var j = 0; j < body[i]['links'].length; j++) {
            var link = body[i]['links'][j];
            context['chrome']['tabs'].callMethod('create', [
              JsObject.jsify({
                'windowId': windowId,
                'url': link,
              })
            ]);
          }
        }
      },
    ]);
  } else {
    print(response.statusCode);
  }
}

void getWebsitesToSearch(String words) async {
  var uri = 'https://370sl8.deta.dev/?input=${words}';
  var wordArray = words.split(' ');
  var response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    Map<String, dynamic> body = jsonDecode(response.body);
    var firstPageLink = body[0]['links'][0];
    print(firstPageLink);
    print('word:${body[0]['query']},link: ${firstPageLink}');
    int screenWidth = context['screen']['availWidth'];
    int screenHeight = context['screen']['availHeight'];
    int windowWidth = screenWidth ~/ 2;
    int windowHeight = screenHeight ~/ 2;
    int windowLeft = (screenWidth - windowWidth) ~/ 2;
    int windowTop = (screenHeight - windowHeight) ~/ 2;
    context['chrome']['windows'].callMethod('create', [
      JsObject.jsify({
        'url': firstPageLink,
        'width': windowWidth,
        'height': windowHeight,
        'left': windowLeft,
        'top': windowTop,
      }),
      (JsObject window) {
        int windowId = window['id'];
        for (var i = 0; i < body.length; i++) {
          // first page should be opened in a new window and return the window id.
          for (var j = 0; j < body[i]['links'].length; j++) {
            var link = body[i]['links'][j];
            context['chrome']['tabs'].callMethod('create', [
              JsObject.jsify({
                'windowId': windowId,
                'url': link,
              })
            ]);
          }
        }
      },
    ]);
  } else {
    print(response.statusCode);
  }
}

void openWebPageTab(String url, int windowId) {
  var options =
      new JsObject.jsify({'url': url, 'active': false, 'windowId': windowId});
  context['chrome']['tabs'].callMethod('create', [options]);
}
