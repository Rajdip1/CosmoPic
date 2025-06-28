import 'dart:convert';
import 'package:cosmopic/description.dart';
import 'package:cosmopic/model/api_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool _isLoading = true;
  late APIModel apiModel;

  @override
  void initState() {
    super.initState();
    fetchData();
    // Future.delayed(Duration(seconds: 3),() {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
  }

  //function to fetch data from api
  Future<void> fetchData() async {
    final url = Uri.parse('https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY');
    final response = await http.get(url);

    if(response.statusCode == 200) {
      final json = jsonDecode(response.body);
      setState(() {
        apiModel = APIModel.fromJson(json);
        _isLoading = false;
      });
    }
    else {
      throw Exception('failed to loading');
    }
  }

  //widget function for Shimmer effect
  Widget shimmerBox({double height = 20, double width = double.infinity, BorderRadius? raduis}) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: raduis ?? BorderRadius.circular(8)
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // blue background
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text(
          'Image of the Day',
          style: TextStyle(color: Colors.white,fontFamily: 'Raleway',fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container or Shimmer effect
            _isLoading ? shimmerBox(height: 250, raduis: BorderRadius.circular(20))
            : Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                 image: DecorationImage(
                   image: NetworkImage(apiModel!.imgUrl),
                   fit: BoxFit.cover
                 ),
                border: Border.all(color: Colors.lightGreen, width: 2),
              ),
            ),

            SizedBox(height: 20),

            // Title and Date or shimmer
            _isLoading
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerBox(height: 20, width: 180),
                SizedBox(height: 8),
                shimmerBox(height: 16, width: 100),
              ],
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  apiModel!.title,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white,fontFamily: 'Raleway',),
                ),
                SizedBox(height: 8),
                Text(
                  'Date: ${apiModel!.date}',
                  style: TextStyle(fontSize: 16, color: Colors.white38, fontFamily: 'Raleway',fontWeight: FontWeight.w600),
                ),
              ],
            ),

            Spacer(),

            // Description Button
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightGreen),
                borderRadius: BorderRadius.circular(12)
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white12,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  onPressed: () {
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View Description',
                        style: TextStyle(color: Colors.white,fontSize: 22,fontFamily: 'Raleway',fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 26,color: Colors.white),
                    ],
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
