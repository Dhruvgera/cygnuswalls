import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Title bar
Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: const <Widget>[
      Text(
        "CygnusOS",
        style: TextStyle(
          color: Colors.black87,
          fontFamily: 'Overpass',
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        " Walls",
        style: TextStyle(color: Colors.blue, fontFamily: 'Overpass'),
      )
    ],
  );
}

// Loading screen while image is fetched from network
Widget imageLoader(String imgURL, int index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Image.network(
      imgURL,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    ));
