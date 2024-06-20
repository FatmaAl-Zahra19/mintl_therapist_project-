import 'dart:convert';
import 'package:http/http.dart' as http;

//Auth token we will use to generate a meeting and connect to it
const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI2NTM2OGU1YS1jMjA5LTQ1NWYtYjFjNC1lMzMzZWUyYzNiYTYiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcxNDkxMTI4OSwiZXhwIjoxNzQ2NDQ3Mjg5fQ.CuVPCecvQ1Ky3Liilqp6oXyCvG9Gu0XgsA2a13iORz4';

// API call to create meeting
Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse('https://api.videosdk.live/v2/rooms'),
    headers: {'Authorization': token},
  );

//Destructuring the roomId from the response
  return json.decode(httpResponse.body)['roomId'];
}