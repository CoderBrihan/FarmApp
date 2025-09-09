import 'dart:convert';
import 'package:http/http.dart' as http;
Future<String> getOpenRouterResponse(String userInput) async{
  const endpoint = 'https://openrouter.ai/api/v1/chat/completions';
  final header={
    'Authorization':'Bearer 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',
    'Content-Type':'application/json',
  };
  final body=jsonEncode({
    'model':'gpt-3.5-turbo',
    'prompt':userInput,
    'max-tokens':100,
    'temperature':0.7
  });
  final response = await http.post(Uri.parse(endpoint),headers: header,body: body);
  if(response.statusCode==200){
    final data = jsonDecode(response.body);
    return data['choices'][0]['text'];
  }else{
    throw Exception('Failed to get response:${response.body}');
  }
}