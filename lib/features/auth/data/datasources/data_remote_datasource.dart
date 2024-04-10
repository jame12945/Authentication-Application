import 'package:http/http.dart' as http;
import 'package:test_app/core/api/app_api.dart';

class DataRemoteDataSource {
  final String dataUrl = AppApi.baseUrl;
  Future<String> fetchData(String token) async {
    final response = await http.get(
      Uri.parse('$dataUrl/data'),
      headers: <String, String>{
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
