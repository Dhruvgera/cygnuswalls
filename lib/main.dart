import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:walls/widget.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:developer';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  WidgetsFlutterBinding.ensureInitialized();
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



downloadfunc (downloadurl) async {
  /* WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  final taskId = await FlutterDownloader.enqueue(
    url: downloadurl,
    savedDir: '/sdcard/download/',
    showNotification: true, // show download progress in status bar (for Android)
    openFileFromNotification: true, // click on notification to open downloaded file (for Android)
  ); */
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
    //add more permission to request here.
  ].request();

    var dir = await getTemporaryDirectory();
    if(dir != null){
      String savename = "walltobeapplied.png";
      String savePath = dir.path + "/$savename";
      print(savePath);
      //output:  /storage/emulated/0/Download/banner.png

      try {
        await Dio().download(
            downloadurl,
            savePath,
            onReceiveProgress: (received, total) {
              if (total != -1) {
                print((received / total * 100).toStringAsFixed(0) + "%");
                //you can build progressbar feature too
              }
            });
        print("File is saved to download folder.");
        //AsyncWallpaper.setWallpaperFromFile(
        //    savePath, AsyncWallpaper.HOME_SCREEN);
      } on DioError catch (e) {
        print(e.message);
      }
      return savePath;
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
                      //log("URL: ${imgList[imgIndex]}")
                      downloadfunc(imgList[imgIndex])
                    },
                    child: const Icon(Icons.download),
                  ),
                ))
          ],
        ));
  }
}
