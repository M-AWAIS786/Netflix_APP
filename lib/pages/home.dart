import 'package:flutter/material.dart';
import 'package:practicenetflix/pages/search.dart';

import '../models/NowPlayingMovieModel.dart';
import '../models/TopRatedMovieModel.dart';
import '../models/UpcomingMovieModel.dart';
import '../services/api_services.dart';
import '../widget_pages/card_nowplaying_widget.dart';
import '../widget_pages/card_upcoming_widget.dart';
import '../widget_pages/carousal_slider_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<UpcomingMovieModel> upcomingmoviewmodel;
  late Future<NowPlayingMovieModel> nowplayingmoviemodel;
  late Future<TopRatedMovieModel> topratedmoviemodel;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    upcomingmoviewmodel = apiService.getupcomingMovieMode();
    nowplayingmoviemodel = apiService.getnowPlayingMovieModel();
    topratedmoviemodel = apiService.getTopRatedMovieModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            // Makes the AppBar appear as you start to scroll up
            // pinned: true,   // Keeps the AppBar pinned at the top
            // snap: true,     // Ensures the AppBar snaps into view when you scroll up
            backgroundColor: Colors.black,
            // Fixed background color for the AppBar
            title: SizedBox(
              width: 35,
              height: 35,
              child: Image.asset('assets/images/netflix.png'),
            ),

            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const search()));
                },
                icon: const Icon(Icons.search, size: 30),
              ),
              const SizedBox(width: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 30,
                  width: 30,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                CustomCrousalSlider(topratedmovie: topratedmoviemodel),
                SizedBox(
                  height: 220,
                  child: Card_upcoming_widget(
                    headlineText: 'UpComing Movies',
                    upcomingmoviewmodel: upcomingmoviewmodel,
                  ),
                ),
                SizedBox(
                  height: 220,
                  child: Card_nowplaying_widget(
                    nowplayingmoviewmodel: nowplayingmoviemodel,
                    headlineText: 'Now Playing Movies',
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}