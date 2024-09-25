import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/UpcomingMovieModel.dart';
import '../services/api_services.dart';

class Card_upcoming_widget extends StatelessWidget {
   Card_upcoming_widget({super.key, required this.upcomingmoviewmodel, required this.headlineText});
final Future<UpcomingMovieModel> upcomingmoviewmodel;
final String headlineText;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: upcomingmoviewmodel,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            final data = snapshot.data!.results;
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
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){},
                          child: Image.network('$imageUrl${data[index].posterPath}'),
                        ),
                      );
                    },),
                ),
              ],
            );
          }else {
            return SizedBox.shrink();
          }
        }


    ) ;
  }
}
