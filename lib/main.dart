import 'package:flutter/material.dart';
import 'package:walls/widget.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
          home: const FullscreenSlider()
        );

  }
}

final List<String> imgList = [];

addfunc() {
  int num = 1;
  String a = 'https://github.com/cygnus-rom/CygnusOS-Wallpapers/raw/main/Files/CygnusOS%20';
  for(num; num<=100; num++){
      String b = "(${num.toString()}).png" ;
      imgList.add(a+b);
  }

}

class FullscreenSlider extends StatelessWidget {
  const FullscreenSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addfunc();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Scaffold(
      appBar: AppBar(title: Center (child: brandName(),),
      elevation: 0.0,
      backgroundColor: Colors.white,),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: imgList
                .map((item) => Container(
              child: Center(
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    height: height,
                  )),
            ))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () => {

        },
        child: const Icon(Icons.beenhere),
      ),
    );
  }
}
