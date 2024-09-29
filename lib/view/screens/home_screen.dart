import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/bloc/unsplash_bloc.dart';
import 'package:http_bloc_task2/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:http_bloc_task2/view/widgets/main_drawer.dart';
import 'package:http_bloc_task2/view/widgets/image_slider.dart';
import 'package:http_bloc_task2/view/widgets/image_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final unsplashBloc = BlocProvider.of<UnsplashBloc>(context);

    if (unsplashBloc.randomImagesCache.isEmpty) {
      unsplashBloc.add(GenerateRandomImagesEvent());
    }

    if (unsplashBloc.topicsCache.isEmpty) {
      unsplashBloc.add(GenerateSliderEvent());
    }

    scrollController.addListener(onScroll);
  }

  void onScroll() {
    final offset = scrollController.offset;
    final maxScroll = scrollController.position.maxScrollExtent;

    if (offset >= maxScroll * 0.9) {
      context.read<UnsplashBloc>().add(GenerateRandomImagesEvent());
    }
  }

  Widget toggleFavorite(ImageObject image) {
    return GestureDetector(
      child: const Icon(Icons.star),
      onTap: () async {
        context.read<FavoritesCubit>().addFavorite(image);
      },
    );
  }

  Widget buildDescription(ImageObject image) {
    return Container(
      width: double.infinity,
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: image.photoDescription != null
            ? Text(
                "${image.photoDescription}",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              )
            : const Text(
                "Description is unavailable",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }

  Future<void> selectScreen(String screen) async {
    Navigator.of(context).pop();
    if (screen == "favorite") {
      Navigator.of(context).pushNamed('/favorite');
    }
    if (screen == "search") {
      Navigator.of(context).pushNamed('/search');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(
        onSelectScreens: selectScreen,
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text(
          "Infinit Images",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: ImageSlider(),
                ),
              ),
            ),
            BlocBuilder<UnsplashBloc, UnsplashState>(
              builder: (context, state) {
                List<ImageObject> randomImagesCache =
                    context.read<UnsplashBloc>().randomImagesCache;
                if (randomImagesCache.isNotEmpty) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final image = randomImagesCache[index];
                        final aspectRatio = image.width! / image.height!;
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height:
                              MediaQuery.of(context).size.width / aspectRatio,
                          child: ImageWidget(
                            image: image,
                          ),
                        );
                      },
                      childCount: randomImagesCache.length,
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
