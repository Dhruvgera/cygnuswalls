import 'package:flutter/material.dart';
import 'package:walls/widget.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:developer';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const CygnusWalls());
}

// App
class CygnusWalls extends StatelessWidget {
  const CygnusWalls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        darkTheme: ThemeData.dark(),
        //themeMode: ThemeMode.values.toList()[value as int],
        debugShowCheckedModeBanner: false,
        home: const FullscreenSlider());
  }
}

final List<String> imgList = [];
int imgIndex = 0;

addfunc() {
  int num = 1;
  String a =
      'https://github.com/cygnus-rom/CygnusOS-Wallpapers/raw/main/Files/CygnusOS%20';
  for (num; num <= 100; num++) {
    String b = "(${num.toString()}).png";
    imgList.add(a + b);
  }
}

class FullscreenSlider extends StatelessWidget {
  const FullscreenSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addfunc();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: brandName(),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            CarouselSlider.builder(
                itemCount: imgList.length,
                itemBuilder: (context, index, ri) {
                  imgIndex = index;
                  return imageLoader(imgList[index], index);
                },
                options: CarouselOptions(
                    reverse: false,
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                    height: MediaQuery.of(context).size.height)),
            Positioned(
                bottom: 0,
                right: 1,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    onPressed: () => {
                      log("URL: ${imgList[imgIndex]}")
                    },
                    child: const Icon(Icons.download),
                  ),
                ))
          ],
        ));
  }
}
