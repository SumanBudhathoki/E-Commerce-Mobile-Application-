import 'package:http/http.dart' as http;

class SearchService {
  static Future<String> searchDjangoApi(String query) async {
    String url = 'http://10.0.2.2:8000/api/product_search/?search=$query';
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }
}
