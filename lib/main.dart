import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:walls/widget.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer';
import 'dart:math';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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


setWallpaper(wallpaperURL, int screen) async {
  var dir = await getTemporaryDirectory();
  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  }
  var rname = generateRandomString(5);
  String savePath = "${dir.path}/${rname}";
  // log(savePath);

  try {
    await Dio().download(
      wallpaperURL,
      savePath,
      onReceiveProgress: (count, total) async {
        String progressString = "${((count / total) * 100).toStringAsFixed(
            0)}%";
        if (progressString == "100%") {
          await AsyncWallpaper.setWallpaperFromFile(
              filePath: savePath, wallpaperLocation: screen, goToHome: false);
              //final file = await File(savePath);
              //await file.delete();
          Fluttertoast.showToast(
              msg: "Wallpaper has been set!",
              toastLength: Toast.LENGTH_SHORT,
          );
          dir.deleteSync(recursive: true);
          dir.create();

        }
      },
    );
  } on DioError catch (e) {
    //log(e.message);
  }

  return
    savePath;
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
                    height: MediaQuery
                        .of(context)
                        .size
                        .height)),
            Positioned(
                bottom: 0,
                right: 1,
                child: Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    onPressed: () =>
                    {
                      setWallpaper(imgList[imgIndex], AsyncWallpaper.BOTH_SCREENS)
                    },
                    child: const Icon(Icons.download),
                  ),
                ))
          ],
        ));
  }
}
