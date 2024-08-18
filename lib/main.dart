import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UniversitySearchPage(),
    );
  }
}

class UniversitySearchPage extends StatefulWidget {
  @override
  _UniversitySearchPageState createState() => _UniversitySearchPageState();
}

class _UniversitySearchPageState extends State<UniversitySearchPage> {
  final ApiService apiService = ApiService();
  final TextEditingController _controller = TextEditingController();
  List<dynamic> universities = [];
  bool isLoading = false;

  void _search() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await apiService.fetchUniversities(_controller.text);
      setState(() {
        universities = result;
      });
    } catch (e) {
      // Handle the error
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('University Search'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Country Name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _search,
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : universities.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: universities.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(universities[index]['name']),
                              subtitle:
                                  Text(universities[index]['country']),
                            );
                          },
                        ),
                      )
                    : Text('No universities found'),
          ],
        ),
      ),
    );
  }
}