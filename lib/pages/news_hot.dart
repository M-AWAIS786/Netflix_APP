import 'package:flutter/material.dart';
import 'package:practicenetflix/widget_pages/comingSoonMoviesWidget.dart';

class newshot extends StatefulWidget {
  const newshot({super.key});

  @override
  State<newshot> createState() => _newshotState();
}

class _newshotState extends State<newshot> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('News & Hot'),
            actions: [
              const Icon(Icons.cast, color: Colors.white,),
              SizedBox(width: 20,),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 30,
                  width: 30,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 20,),
            ],
            bottom: TabBar(
              dividerColor: Colors.black,
              isScrollable: false,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              labelColor: Colors.black,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              unselectedLabelColor: Colors.white,
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Tab(
                    text: "🍿 Coming Soon",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Tab(
                    text: " 🔥 Everyone's Watching",
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    ComingSoonMovieWidget(
                      imageUrl:
                      'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                      overview:
                      'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                      logoUrl:
                      "https://s3.amazonaws.com/www-inside-design/uploads/2017/10/strangerthings_feature-983x740.jpg",
                      month: "Dec",
                      day: "19",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ComingSoonMovieWidget(
                      imageUrl:
                      'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                      overview:
                      'A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.',
                      logoUrl:
                      "https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg",
                      month: "Dec",
                      day: "07",
                    ),
                  ],
                ),
              ),
              ComingSoonMovieWidget(
                imageUrl:
                'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
                overview:
                'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                logoUrl:
                "https://logowik.com/content/uploads/images/stranger-things4286.jpg",
                month: "Oct",
                day: "20",
              ),
            ],
          ),
        ),
      ),
    );

  }
}
