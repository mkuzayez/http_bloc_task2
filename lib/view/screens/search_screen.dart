import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/bloc/unsplash_bloc.dart';
import 'package:http_bloc_task2/view/widgets/image_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener(onScroll);
  }

  void onScroll() {
    final offset = scrollController.offset;
    final maxScroll = scrollController.position.maxScrollExtent;

    if (offset >= maxScroll * 0.9) {
      context.read<UnsplashBloc>().add(GenerateRandomImagesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Photos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  context.read<UnsplashBloc>().add(
                        SearchPhotosEvent(
                          query,
                        ),
                      );
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<UnsplashBloc, UnsplashState>(
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.status == Status.searchResultsLoaded) {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: state.searchResults.length,
                    itemBuilder: (context, index) {
                      final image = state.searchResults[index];
                      final aspectRatio = image.width! / image.height!;
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: MediaQuery.of(context).size.width / aspectRatio,
                        child: ImageWidget(
                          image: image,
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No results found',
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
