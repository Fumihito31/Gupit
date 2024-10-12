import 'package:flutter/material.dart';

class CategoryModel {
  // Updated list of image asset paths
  static final List<String> assetPaths = [
    'lib/assets/1.jpg',
    'lib/assets/2.jpg',
    'lib/assets/3.jpg',
    'lib/assets/4.jpg',
    'lib/assets/5.jpg',
    'lib/assets/6.jpg',
    'lib/assets/7.jpg',
    'lib/assets/8.jpg',
    'lib/assets/9.jpg',
    'lib/assets/10.jpg',
    'lib/assets/11.jpg',
    'lib/assets/12.jpg',
    'lib/assets/13.jpg',
    'lib/assets/14.jpg',
  ];

  static Widget model(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        assetPaths[index],
        height: 85,
        width: 85,
        fit: BoxFit.cover,
      ),
    );
  }
}

class GalleryBody extends StatefulWidget {
  @override
  _GalleryBodyState createState() => _GalleryBodyState();
}

class _GalleryBodyState extends State<GalleryBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        itemCount: CategoryModel.assetPaths.length,
        itemBuilder: (context, index) {
          return Center(child: CategoryModel.model(index));
        },
      ),
    );
  }
}
