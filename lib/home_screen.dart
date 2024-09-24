import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:http_bloc_task2/business_logic/cubit/unsplash_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    BlocProvider.of<UnsplashCubit>(context).getRandomImages();
    super.initState();
  }

  Widget downloadButton(String link) {
    return GestureDetector(
      child: Icon(Icons.download_for_offline_outlined),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocBuilder<UnsplashCubit, UnsplashState>(
              builder: (context, state) {
                if (state is RandomImages) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.randomImages.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final image = state.randomImages[index];
                      final imageWidth = image.width;
                      final imageHeight = image.height;
                      final aspectRatio = imageWidth / imageHeight;

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: MediaQuery.of(context).size.width / aspectRatio,
                        child: Stack(
                          children: [
                            BlurHash(
                              hash: image.blurHash!,
                              imageFit: BoxFit.cover,
                              curve: Curves.easeInOut,
                              onDecoded: () {},
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.error,
                                  ),
                                );
                              },
                            ),
                            Image.network(
                              image.urls!.regular!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.width /
                                  aspectRatio,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                            Positioned(
                              bottom: 0,
                              right: 50,
                              left: 50,
                              child: Container(
                                color: Colors.black54,
                                child: Text(
                                  image.photoDescription!,
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
