// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

// class WallpaperOptions extends StatelessWidget {
//   final String imageUrl;

//   const WallpaperOptions({super.key, required this.imageUrl});

//   Future<void> setWallpaper(
//       BuildContext context, String imageUrl, int location) async {
//     Dio dio = Dio();

//     final documentDirectory = await getApplicationDocumentsDirectory();

//     await dio.download(imageUrl, documentDirectory.path);

//     await WallpaperManagerFlutter()
//         .setwallpaperfromFile(documentDirectory.path, location);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: [
//         ListTile(
//           leading: const Icon(Icons.home),
//           title: const Text('Set as Home Screen'),
//           onTap: () {
//             setWallpaper(
//                 context, imageUrl, WallpaperManagerFlutter.HOME_SCREEN);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.lock),
//           title: const Text('Set as Lock Screen'),
//           onTap: () {
//             setWallpaper(
//                 context, imageUrl, WallpaperManagerFlutter.LOCK_SCREEN);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.lock),
//           title: const Text('Set as Both'),
//           onTap: () {
//             setWallpaper(
//                 context, imageUrl, WallpaperManagerFlutter.BOTH_SCREENS);
//           },
//         ),
//       ],
//     );
//   }
// }
