import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'Message.g.dart';


@JsonSerializable()
class Message {
  final String subject;
  final String body;


  Message(this.subject, this.body);

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  static Future<List<Message>> browse({status = 'important'}) async {

    String url = status == 'important'
        ? 'https://run.mocky.io/v3/171a367e-af83-41e9-816f-7ffe2b955c99'
        : 'https://run.mocky.io/v3/9c130d0a-d0b5-4021-9967-d0d0b84999e3';

    http.Response response =
          await http.get(Uri.parse(url));

    await Future.delayed(Duration(milliseconds: 500));

    String content = response.body;
    List collection = json.decode(content); // Take json string data and turn into a collection of Map data set
    List<Message> _messages = collection.map((json) => Message.fromJson(json)).toList(); // Transform from collection of Map data set to a list of Message Objects

    return _messages;
  }
}