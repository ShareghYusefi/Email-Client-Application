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

  static Future<List<Message>> browse() async {
    http.Response response =
          await http.get(Uri.parse('https://run.mocky.io/v3/37398798-2df2-4838-9b19-d7d7d2fb0d28'));

    await Future.delayed(Duration(seconds: 3));

    String content = response.body;
    List collection = json.decode(content); // Take json string data and turn into a collection of Map data set
    List<Message> _messages = collection.map((json) => Message.fromJson(json)).toList(); // Transform from collection of Map data set to a list of Message Objects

    return _messages;
  }
}