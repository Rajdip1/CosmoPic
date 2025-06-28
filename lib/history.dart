import 'dart:convert';
import 'package:cosmopic/service/image_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'description.dart';
import 'model/api_model.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DateTime? _selectedDate;

  bool _isLoading = true;
  bool _isLiked = false;
  late APIModel apiModel;

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  //function to fetch data from api
  Future<void> fetchData({required DateTime date}) async {
    final formatedDate = DateFormat('yyyy-MM-dd').format(date);
    final url = Uri.parse('https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=$formatedDate');
    final response = await http.get(url);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        apiModel = APIModel.fromJson(json);
        _isLoading = false;
        _isLiked = ImageManager().favorites.any((item) => item.date == apiModel.date);;
      });
    }
    else {
      throw Exception('failed to loading');
    }
  }

  // Function to show the date picker
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1995), // NASA APOD started in 1995
      lastDate: DateTime.now(),
      helpText: 'Select a date',
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // You can now use _selectedDate to fetch images for this date
      });

      await fetchData(date: picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    String dateText = _selectedDate == null
        ? 'Select a Date'
        : DateFormat('yyyy-MM-dd').format(_selectedDate!);

    return Scaffold(
      backgroundColor:  Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text(
          'History',
          style: TextStyle(color: Colors.white,fontFamily: 'Raleway',fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          children: [
            // Date Picker
            GestureDetector(
              onTap: () => _pickDate(context),
              child: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  border: Border.all(color: Colors.lightGreen),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  dateText,
                  style:  TextStyle(color: Colors.white,fontSize: 16, fontFamily: 'Raleway',fontWeight: FontWeight.bold),
                ),
              ),
            ),

             SizedBox(height: 20),

            // Conditional content
            _selectedDate == null
                ?  Text(
              'Please select a date to view the image.',
              style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Raleway',fontWeight: FontWeight.bold),
            )
                : _isLoading
                ?  CircularProgressIndicator(color: Colors.lightGreen,)
                : Expanded(
              child: Material(
                color: Colors.white10,
                elevation: 4,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightGreen),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      // You can navigate to a detail screen if needed
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 300),
                          pageBuilder: (context, animation, secondaryAnimation) => Description(apiModel: apiModel),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(opacity: animation, child: child);
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding:  EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.lightGreen),
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(apiModel.imgUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                           SizedBox(height: 10),
                          Column(
                            children: [
                              Text(
                                apiModel.title,
                                style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLiked = !_isLiked;

                                if (_isLiked) {
                                  ImageManager().add(apiModel);
                                } else {
                                  ImageManager().remove(apiModel);
                                }
                              });
                            },
                            child: Icon(
                              _isLiked ? Icons.favorite : Icons.favorite_border,
                              color: _isLiked ? Colors.red : Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
