import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practicenetflix/pages/movie_details.dart';

import '../models/UpcomingMovieModel.dart';
import '../services/api_services.dart';

class Card_upcoming_widget extends StatelessWidget {
   const Card_upcoming_widget({super.key, required this.upcomingmoviewmodel, required this.headlineText});
final Future<UpcomingMovieModel> upcomingmoviewmodel;
final String headlineText;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: upcomingmoviewmodel,
        builder: (context, snapshot) {

          if(snapshot.hasError){
            return const SizedBox.shrink();
          }

          if(snapshot.hasData) {
            final upcomingData = snapshot.data!.results;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(headlineText,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: upcomingData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                MovieDetailsScreen(id: upcomingData[index].id,),));

                          },
                          child: CachedNetworkImage(imageUrl:'$imageUrl${upcomingData[index].posterPath}'),
                        ),
                      );
                    },),
                ),
              ],
            );
          }else {
            return const SizedBox.shrink();
          }
        }


    ) ;
  }
}
