import 'package:flutter/material.dart';

import '../models/NowPlayingMovieModel.dart';
import '../services/api_services.dart';

class Card_nowplaying_widget extends StatelessWidget {
  Card_nowplaying_widget({
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

        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        // if(snapshot.hasError) {
        //   return Text('Error${snapshot.error}');
        // }

        if (snapshot.hasData) {
          final data = snapshot.data!.results;

          if(data.isEmpty) {
            return const Text('no data available');
          }
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
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final posterPath = data[index].posterPath;
                    final imageUrlSafe = posterPath !=null? '$imageUrl$posterPath'
                        :'https://via.placeholder.com/150';
                
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Image.network(
                            imageUrlSafe),
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
