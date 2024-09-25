import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practicenetflix/models/MovieRecommendationsModel.dart';
import 'package:practicenetflix/pages/movie_details.dart';
import 'package:practicenetflix/services/api_services.dart';

import '../models/SearchMovieModel.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  TextEditingController searchController = TextEditingController();
  ApiService apiService = ApiService();
  SearchMovieModel? searchMovieModel;
  late Future<MovieRecomendationsModel> movieRecommendationmodel;

  @override
  void initState() {
    super.initState();
    movieRecommendationmodel = apiService.getMovieRecommendationsModel();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void moviesearchcalling(String query) {
    apiService.getSearchMovieModel(query).then((value) {
      setState(() {
        searchMovieModel = value;
      });
      // print(searchMovieModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        const CircularProgressIndicator();
                      } else {
                        moviesearchcalling(searchController.text);
                      }
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.black54,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      focusColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                                setState(() {
                                  searchMovieModel == null;
                                });
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.grey,
                              ))
                          : null,
                      hintText: 'search movies',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                    ),
                  ),
                ),
              ),
              searchController.text.isEmpty
                  ? FutureBuilder(
                      future: movieRecommendationmodel,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final datacapture = snapshot.data;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Top Searches',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: datacapture!.results.length,
                                itemBuilder: (context, index) {
                                  final imageurldata =
                                      datacapture.results[index].posterPath;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          children: [
                                            Image.network(
                                                fit: BoxFit.cover,
                                                "$imageUrl$imageurldata"),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                                child: Text(
                                                    datacapture
                                                        .results[index].title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1)),
                                            // const Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: IconButton(
                                                alignment:
                                                    Alignment.centerRight,
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      MovieDetailsScreen(
                                                    id: datacapture
                                                        .results[index].id,
                                                  ),
                                                )),
                                                icon: const Icon(
                                                  Icons.play_circle,
                                                  size: 30,
                                                ),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : searchMovieModel == null
                      ? const SizedBox.shrink()
                      : GridView.builder(
                          itemCount: searchMovieModel?.results.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 15.0,
                            childAspectRatio: 1.2 / 2,
                          ),
                          // itemCount: searchMovieModel,
                          itemBuilder: (BuildContext context, int index) {
                            return searchMovieModel!
                                        .results[index].backdropPath ==
                                    null
                                ? Column(
                                    children: [
                                      Image.asset(
                                        "assets/images/netflix.png",
                                        height: 170,
                                      ),
                                      Text(
                                        searchMovieModel!.results[index].title,
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetailsScreen(
                                                      id: searchMovieModel!
                                                          .results[index].id,
                                                    ))),
                                        child: CachedNetworkImage(
                                            height: 170,
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                '$imageUrl${searchMovieModel!.results[index].backdropPath}'),
                                      ),
                                      Text(
                                        searchMovieModel!.results[index].title,
                                        overflow: TextOverflow.clip,
                                        maxLines: 1,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
