import 'dart:convert';

class Persona {
  final String name;
  final String education;
  final String gender;
  final String profession;
  final String income;
  final String marital_status;
  final String location;
  final int age;
  final List<String> book_interest;
  final List<String> sport_interest;
  final List<String> movies_interest;
  final List<String> music_interest;
  final List<String> hobby;

  Persona(
      {required this.name,
      required this.education,
      required this.gender,
      required this.profession,
      required this.income,
      required this.location,
      required this.marital_status,
      required this.age,
      required this.book_interest,
      required this.sport_interest,
      required this.movies_interest,
      required this.music_interest,
      required this.hobby});

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      name: json['name'],
      education: json['education'],
      gender: json['gender'],
      location: json['location'],
      profession: json['profession'],
      income: json['income'],
      marital_status: json['marital_status'],
      age: json['age'],
      book_interest: json['book_interest'],
      sport_interest: json['sport_interest'],
      movies_interest: json['movies_interest'],
      music_interest: json['music_interest'],
      hobby: json['hobby'],
    );
  }
  Map toJson() => {
        'name': name,
        'age': age,
        'education': education,
        'gender': gender,
        'profession': profession,
        'income': income,
        'marital_status': marital_status,
        'location': location,
        'book_interest': book_interest,
        'sport_interest': sport_interest,
        'movies_interest': movies_interest,
        'music_interest': music_interest,
        'hobby': hobby
      };
}
