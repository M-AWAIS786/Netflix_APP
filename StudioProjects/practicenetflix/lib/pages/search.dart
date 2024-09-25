import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:practicenetflix/services/api_services.dart';

import '../models/SearchMovieModel.dart';

class search extends StatefulWidget {
  const search({super.key});
  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {

  TextEditingController mycontroller = TextEditingController();


  @override
  void dispose(){
    mycontroller.dispose();
    super.dispose();
  }
ApiService  apiService=ApiService();
  SearchMovieModel? searchMovieModel;  
  
  void moviesearchcalling(String query){
   apiService.getSearchMovieModel(query).then((value) {
     searchMovieModel=value;
     // print(searchMovieModel);
   } );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[800]),
                child: TextField(
                  controller: mycontroller,
                  onChanged: (value) {
                    if(value.isEmpty){}else{moviesearchcalling(value);}
                    },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    focusColor: Colors.orange,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.clear),
                    label: Text('search movies'),
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                ) ,
                itemCount: searchMovieModel!.results.length,
                itemBuilder: (context, index) {
                  final data=searchMovieModel!.results;
                  return Column(
                    children: [
                      SizedBox(height:100, child: Image.network("$imageUrl${data[index].posterPath}")),
                    ],
                  );
                },),
          )
        ],
      ),
    );

  }
}
