import 'dart:convert'; 
import 'package:http/http.dart' as http;
class ApiService { 
  Future<List<dynamic>> fetchUniversities(String country) async { 
    final response = await http.get( 
      Uri.parse('http://universities.hipolabs.com/search?country=$country'), 
      ); 
      if (response.statusCode == 200) { 
        return jsonDecode(response.body); 
        } 
        else 
        { throw Exception('Failed to load universities'); 
        } 
        } 
        }