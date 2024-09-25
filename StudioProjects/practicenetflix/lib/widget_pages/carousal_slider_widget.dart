import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:practicenetflix/services/api_services.dart';
import 'package:practicenetflix/widget_pages/landingcard.dart';

import '../models/TopRatedMovieModel.dart';

class CustomCrousalSlider extends StatelessWidget {
  const CustomCrousalSlider({super.key, required this.topratedmovie});

  final Future<TopRatedMovieModel> topratedmovie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: topratedmovie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final dataa = snapshot.data!.results;

          return SizedBox(
            width: size.width,
            height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
            child: CarouselSlider.builder(
                itemCount: dataa.length,
                itemBuilder: (context, index, realIndex) {
                  final urldata = snapshot.data!.results[index].posterPath;
                  // print('data is here${urldata}');
                  return GestureDetector(
                      onTap: () {},
                      child: LandingCard(
                          name: dataa[index].title,
                          image:
                              CachedNetworkImageProvider('$imageUrl$urldata')));
                },
                options: CarouselOptions(
                  height: (size.height * 0.33 < 300) ? 250 : size.height * 0.33,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                )),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
