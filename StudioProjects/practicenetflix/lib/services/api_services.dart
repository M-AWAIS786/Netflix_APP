import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practicenetflix/models/TopRatedMovieModel.dart';
import 'package:practicenetflix/models/UpcomingMovieModel.dart';

import '../models/NowPlayingMovieModel.dart';
import '../models/SearchMovieModel.dart';
import '../utils/helping.dart';

final baseUrl = 'https://api.themoviedb.org/3/';

final imageUrl = 'https://image.tmdb.org/t/p/w500/';
final key = "?api_key=$apikey";

class ApiService {
  Future<UpcomingMovieModel> getupcomingMovieMode() async {
    final endpoint;
    endpoint = "movie/upcoming";
    final url = '$baseUrl$endpoint$key';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // print('Success is coming ${response.body}');
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    } else {
      print('failed to load');
      return throw Exception('failed to load Upcoming Movies');
    }
  }

  Future<NowPlayingMovieModel> getnowPlayingMovieModel() async {
    final endpoint;
    endpoint = "movie/now_playing";
    final Url = '$baseUrl$endpoint$key';
    final response = await http.get(Uri.parse(Url));
    if (response.statusCode == 200) {
      // print('Success is coming ${response.body}');
      return NowPlayingMovieModel.fromJson(jsonDecode(response.body));
    } else {
      print('Failed');
      return throw Exception('Failed to get Now Playing Movie');
    }
  }

  Future<TopRatedMovieModel> getTopRatedMovieModel() async {
    final endpoint;
    endpoint = "movie/top_rated";
    final url = "$baseUrl$endpoint$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // print('top rated success${response.body}');
      return TopRatedMovieModel.fromJson(jsonDecode(response.body));
    } else {
      return throw Text('aaa${response.body}');
    }
  }

  Future<SearchMovieModel> getSearchMovieModel(String name) async {
    final endpoint;
    endpoint = "search/movie?query=$name";
    final Url = "$baseUrl$endpoint";

    final response = await http.get(Uri.parse(Url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3YTcxZjFkZDM2Y2Q2NmFkMmZhNTY5Yzg2ZTA5ZjRkNSIsIm5iZiI6MTcyNjEyMDkxOS45NzY5NjEsInN1YiI6IjY2ZTI4MTUxMDAwMDAwMDAwMGI5MDhmYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7tqYfjX_mQBvXoX7cTHgVFLPN0HNWrNvQ7XonvdV2pg"
    });
    if (response.statusCode == 200) {
      log(response.body);
      return SearchMovieModel.fromJson(jsonDecode(response.body));
    } else {
      return throw Exception('Failed to Search Movie Api request');
    }
  }
}
