import 'package:cosmopic/model/api_model.dart';
import 'package:flutter/material.dart';

class Description extends StatefulWidget {
  final APIModel apiModel;
  const Description({super.key, required this.apiModel});

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          title:  Text(
            'Description',
            style: TextStyle(color: Colors.white,fontFamily: 'Raleway',fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(widget.apiModel!.imgUrl),
                ),
              ),
              SizedBox(height: 10,),
              Text(
                widget.apiModel.title,
                style: TextStyle(color: Colors.white,fontFamily: 'Raleway',fontWeight: FontWeight.w700,fontSize: 18),
              ),
      
              SizedBox(height: 10,),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.apiModel.description,
                        style: TextStyle(color: Colors.white,fontFamily: 'Raleway',fontWeight: FontWeight.bold,fontSize: 16),
                      ),
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
