import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practicenetflix/pages/movie_details.dart';

import '../models/NowPlayingMovieModel.dart';
import '../services/api_services.dart';

class Card_nowplaying_widget extends StatelessWidget {
  const Card_nowplaying_widget({
    super.key,
    required this.nowplayingmoviewmodel,
    required this.headlineText,
  });

   final Future<NowPlayingMovieModel?> nowplayingmoviewmodel;
  final String headlineText;



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: nowplayingmoviewmodel,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return const SizedBox.shrink();
        }
        if (snapshot.hasData) {
          final cardNowPlayingData = snapshot.data;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  headlineText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Removed Expanded from here, let ListView take the necessary space.
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: cardNowPlayingData!.results.length,
                  itemBuilder: (context, index) {
                    final posterPath = cardNowPlayingData.results[index].posterPath;
                    final imageUrlSafe = posterPath.isNotEmpty? '$imageUrl$posterPath'
                        :'https://via.placeholder.com/150';

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                              MovieDetailsScreen(id: cardNowPlayingData.results[index].id,),));
                        },
                        child: CachedNetworkImage(imageUrl:'$imageUrl$imageUrlSafe'),
                    ),
                    );
                  },
                ),
              ),
              // Remove Expanded from Spacer, and Spacer is unnecessary here.
              const SizedBox(height: 10), // Add some spacing if needed
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
