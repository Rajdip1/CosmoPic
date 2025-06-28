import 'package:cosmopic/service/image_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'description.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    // final List<APIModel> favorites = ImageManager().favorites;
    // print('favorites screen rebuilt');
    final favorites = context.watch<ImageManager>().favorites;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Favorites', style: TextStyle(color: Colors.white,fontFamily: 'Raleway',fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (favorites.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'No favorites yet.',
                    style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'Raleway',fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemCount: favorites.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = favorites[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightGreen),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Material(
                        color: Colors.white10,
                        elevation: 4,
                        borderRadius: BorderRadius.circular(16),
                        child: GestureDetector(
                          onDoubleTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 300),
                                pageBuilder: (context, animation, secondaryAnimation) => Description(apiModel: item),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(opacity: animation, child: child);
                                },
                              ),
                            );
                          },
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(item.imgUrl, width: 70, height: 70, fit: BoxFit.cover),
                            ),
                            title: Text(item.title,
                                style: TextStyle(
                                    fontFamily: 'Raleway',fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white)),
                            subtitle: Text('Saved on: ${item.date}',
                                style: TextStyle(fontSize: 12, color: Colors.white38,fontFamily: 'Raleway',fontWeight: FontWeight.bold)),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.amber),
                              onPressed: () {
                                setState(() {
                                  context.read<ImageManager>().remove(item);
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 16),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.lightGreen),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    context.read<ImageManager>().clear();
                  });
                },
                icon: Icon(Icons.delete_forever, color: Colors.white),
                label: Text(
                  'Remove All',
                  style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: 'Raleway',fontWeight: FontWeight.bold),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
