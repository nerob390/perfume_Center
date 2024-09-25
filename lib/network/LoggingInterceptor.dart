
import 'dart:convert';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor  implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // Log the request details
    print('Request: ${data.method} ${data.url}');
    print('Headers: ${data.headers}');
    print('Body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // Log the response details
    print('Response: ${data.statusCode} ${data.url}');
    print('Headers: ${data.headers}');

    try {
      // Attempt to parse the response body as JSON
      final jsonResponse = json.decode(data.body!);
      final prettyJson = JsonEncoder.withIndent('  ').convert(jsonResponse);
      final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      pattern.allMatches(prettyJson).forEach((RegExpMatch match) =>   print(match.group(0)));
      // var dataResponse=printLongString(prettyJson);
      print('Body (JSON):\n$pattern');
    } catch (e) {
      // If parsing as JSON fails, log the raw body
      print('Body (Raw):\n${data.body}');
    }

    return data;
  }
}
/// Print Long String
void printLongString(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((RegExpMatch match) =>   print(match.group(0)));
}