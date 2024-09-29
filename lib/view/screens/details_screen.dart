import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';

class DetailsScreen extends StatelessWidget {
  final ImageObject image;

  const DetailsScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    final aspectRatio = image.width! / image.height!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(image.photoDescription!),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / aspectRatio,
                  child: BlurHash(
                    hash: image.blurHash!,
                    imageFit: BoxFit.cover,
                    curve: Curves.easeInOut,
                  ),
                ),
                Image.network(
                  image.urls!.regular!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width / aspectRatio,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Flexible(child: Text(image.photoDescription ?? "Unavailable")),
              ],
            ),
            Row(
              children: [
                const Text("Raw Height x Weight: "),
                const Spacer(),
                Text(
                    "${image.height ?? "Unavailable"} x ${image.width ?? "Unavailable"}"),
              ],
            ),
            Row(
              children: [
                const Text("Uploader name: "),
                const Spacer(),
                Flexible(
                    child: Text(
                  image.user!.name ?? "Unavailable",
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
            Row(
              children: [
                const Text("Uploader Instagram: "),
                const Spacer(),
                Flexible(
                    child: Text(
                  "@${image.user!.instagramUsername ?? "Unavailable"}",
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
            const Row(
              children: [
                Text("Download (Choose Resolution): "),
                Spacer(),
                Text("RAW, FULL, REGULAR"),
              ],
            ),
            // ElevatedButton(
            //   onPressed: () => _showWallpaperOptions(context, image),
            //   child: const Text("Set as Wallpaper"),
            // ),
          ],
        ),
      ),
    );
  }
}

// void _showWallpaperOptions(BuildContext context, ImageObject image) {
//   showModalBottomSheet(
//     context: context,
//     builder: (BuildContext bc) {
//       return WallpaperOptions(imageUrl: image.urls!.regular!);
//     },
//   );
// }
