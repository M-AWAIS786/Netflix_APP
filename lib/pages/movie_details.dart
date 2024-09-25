import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practicenetflix/models/MovieDetailsModel.dart';
import 'package:practicenetflix/models/MovieDetailsRecommendationsModel.dart';
import 'package:practicenetflix/services/api_services.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.id});

  final int id;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieDetailsModel> movieDetailmodel;
  late Future<MovieDetailsRecommendationsModel> movieDetailsRecommendationmodel;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchMovieInitialDetail();
  }

  void fetchMovieInitialDetail() {
    movieDetailmodel = apiService.getMovieDetailsModel(widget.id);
    movieDetailsRecommendationmodel =
        apiService.getMovieDetailsRecommendationsModel(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: movieDetailmodel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final descriptiondatacapture = snapshot.data;
                final genres =
                    descriptiondatacapture?.genres.map((e) => e.name).join(", ");
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: size.height * 0.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "$imageUrl${descriptiondatacapture?.posterPath}"),
                                fit: BoxFit.cover),
                          ),
                          child: SafeArea(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16),
                          child: Text(
                            "${descriptiondatacapture?.title}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${descriptiondatacapture?.releaseDate.year}",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white70),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "$genres",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white70),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "${descriptiondatacapture?.overview}",
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 17, color: Colors.white70),
                          ),
                        ),
                      ],
                    ),

                    movieDetailsRecommendationmodel==null? const SizedBox.shrink()
                    :FutureBuilder(
                      future: movieDetailsRecommendationmodel,
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          final moviedata= snapshot.data;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('More like this',style: TextStyle(color: Colors.white,fontSize: 20),),
                              ),
                              GridView.builder(
                                itemCount: moviedata!.results.length,
                                  shrinkWrap: true,
                                  physics:const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: 0.7
                                  ),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MovieDetailsScreen(id: moviedata.results[index].id,),));
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl:"$imageUrl${moviedata.results[index].posterPath}" ,
                                      ),
                                    );
                                  },),
                            ],
                          );
                        }else{
                          return const SizedBox.shrink();
                        }
          
                      },
                    )
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
