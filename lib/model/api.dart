import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ott/model/anime.dart';
import 'package:ott/model/bollywoodmusic.dart';
import 'package:ott/model/hindiTvshowModel.dart';
import 'package:ott/model/hollywoodmusic.dart';
import 'package:ott/model/homeMoviesModel.dart';
import 'package:ott/model/kidsAnimeModel.dart';
import 'package:ott/model/kidsModel.dart';
import 'package:ott/model/music.dart';
import 'package:ott/model/discoverMovies.dart';
import 'package:ott/model/hindiMovie.dart';
import 'package:ott/model/movie.dart';
import 'package:http/http.dart' as http;
import 'package:ott/model/tvShows.dart';
import 'package:ott/model/tvShows.dart';
import 'package:ott/model/tvShows.dart';
import 'package:ott/model/tvshow.dart';
import 'package:ott/screens/widgets/constants.dart';

class Api {
  static const _hindiMovieUrlPage1 =
      "https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&include_adult=false&include_video=false&language=hi-IN&page=1&region=IN&sort_by=popularity.desc&with_origin_country=IN&with_original_language=hi";
  static const _hindiMovieUrlPage2 =
      "https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&include_adult=false&include_video=false&language=hi-IN&page=2&region=IN&sort_by=popularity.desc&with_origin_country=IN&with_original_language=hi";
  static const _trendingMoviesUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';
  static const _tvChannelUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';

  static const _discoverMovieUrl =
      "https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}";

  static const _tvShowUrl =
      "https://api.themoviedb.org/3/discover/tv?api_key=${Constants.apiKey}";

//-----------------------Functions--------------

/////// Hollywood Movie  /////////
  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(_trendingMoviesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      print(decodedData);
      return decodedData
          .map((movie) => Movie.fromJson(movie))
          // .where((movie) => movie.posterPath != null)
          .toList();
    } else {
      throw Exception("Something went wrong");
    }
  }
/////// Discover Movie  /////////

  Future<List<DiscoverMovies>> getDiscoverMovies() async {
    final response = await http.get(Uri.parse(_discoverMovieUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      print(decodedData);
      return decodedData
          .map((discoverMovies) => DiscoverMovies.fromJson(discoverMovies))
          // .where((movie) => movie.posterPath != null)
          .toList();
    } else {
      throw Exception("Something went wrong");
    }
  }
/////// LiveTv  /////////

  Future<List<LiveTvShow>> getLiveTvShow() async {
    final response = await http.get(Uri.parse(_tvShowUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      print(decodedData);
      return decodedData.map((tvShow) => LiveTvShow.fromJson(tvShow)).toList();
    } else {
      throw Exception("Something went wrong");
    }
  }

/////// Bollywood Movie   /////////

  Future<List<HindiMovie>> getHindiMovie() async {
    final response = await http.get(Uri.parse(_hindiMovieUrlPage1));
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body)['results'] as List;
      print(decodedData);
      return decodedData
          .map((hindimovie) => HindiMovie.fromJson(hindimovie))
          .toList();
    } else {
      throw Exception("Something Wrong Happening");
    }
  }

  Future<List<HindiMovie>> getHindiMovies2() async {
    try {
      final List<HindiMovie> allMovies = [];

      for (int page = 1; page <= 5; page++) {
        final response = await http.get(Uri.parse(
            'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&include_adult=false&include_video=false&language=hi-IN&page=$page&region=IN&sort_by=popularity.desc&with_origin_country=IN&with_original_language=hi'));

        if (response.statusCode == 200) {
          final decodedData = jsonDecode(response.body)['results'] as List;
          final movies = decodedData
              .map((hindimovie) => HindiMovie.fromJson(hindimovie))
              .toList();
          for (final movie in movies) {
            print(
                'ID: ${movie.id}, Title: ${movie.title}, ...'); // Include other fields as needed
          }
          allMovies.addAll(movies);

          print(movies);
          print("rachit");
        } else {
          throw Exception(
              "Failed to fetch data. Status code: ${response.statusCode}");
        }
      }

      return allMovies;
    } catch (e) {
      print('Error in getHindiMovies2: $e');
      return [];
    }
  }

/////// Music  /////////
  Future<Music?> getMusicDetails(String albumId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://www.theaudiodb.com/api/v1/json/2/searchalbum.php?s=daft_punk'),
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> data = json.decode(response.body);

        // Check if the API response contains the expected data
        if (data.containsKey('album')) {
          // Extract the album data from the response
          Map<String, dynamic> albumData = data['album'][0];

          // Create a Music object using the extracted data
          Music music = Music.fromJson(albumData);

          return music;
        } else {
          print('Error: Invalid response format from the API');
          return null;
        }
      } else {
        print(
            'Error: Failed to fetch data from the API. Status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error in getMusicDetails: $error');
      return null;
    }
  }
/////// Anime /////////

  Future<List<Anime>> fetchAnimeData() async {
    const String apiUrl = 'https://anime-db.p.rapidapi.com/anime';

    final Map<String, String> queryParams = {
      'page': '1',
      'size': '30',
      // 'search': 'Fullmetal',
      // 'genres': 'Fantasy,Drama',
      'sortBy': 'ranking',
      'sortOrder': 'asc',
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: queryParams);

    final Map<String, String> headers = {
      'X-RapidAPI-Key': '',
      'X-RapidAPI-Host': 'anime-db.p.rapidapi.com',
    };

    try {
      final http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        final List<dynamic> animeData = jsonResponse['data'];

        List<Anime> animeList =
            animeData.map((json) => Anime.fromJson(json)).toList();
        print(animeData);

        return animeList;
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error during API request: $error');
      return [];
    }
  }
  ////// Bollywood Music

  Future<List<ChartEntry>> getBollywoodMusicData() async {
    final url = Uri.parse('https://spotify81.p.rapidapi.com/top_200_tracks');
    final headers = {
      'X-RapidAPI-Key': '',
      'X-RapidAPI-Host': 'spotify81.p.rapidapi.com',
    };
    final params = {'country': 'IN', 'period': 'daily'};
    final uri = url.replace(queryParameters: params);

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        // Assuming jsonData is a list of entries, adjust accordingly
        List<ChartEntry> entries = jsonData.map<ChartEntry>((entry) {
          return ChartEntry.fromJson(entry);
        }).toList();

        // Now you can access TrackMetadata for each entry
        for (ChartEntry entry in entries) {
          TrackMetadata trackMetadata = entry.trackMetadata;
          print('Track Name: ${trackMetadata.trackName}');
          print('Track URI: ${trackMetadata.trackUri}');
          print('Display Image URI: ${trackMetadata.displayImageUri}');
          print('Release Date: ${trackMetadata.releaseDate}');
        }

        return entries; // Return the list of ChartEntry objects
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        return []; // Return an empty list in case of failure
      }
    } catch (error) {
      print('Error: $error');
      return []; // Return an empty list in case of an error
    }
  }

  void main() async {
    List<ChartEntry> bollywoodMusicData = await getBollywoodMusicData();
    // You can now use bollywoodData as needed
  }

  /// Tv Show ////
  Future<List<TVShow>> fetchTvShowData() async {
    const String apiUrl = 'https://frecar-epguides-api-v1.p.rapidapi.com/';

    final Uri uri = Uri.parse(apiUrl);

    final Map<String, String> headers = {
      'X-RapidAPI-Key': '',
      'X-RapidAPI-Host': 'frecar-epguides-api-v1.p.rapidapi.com',
    };

    try {
      final http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          // Assuming the data is a list of TV shows, modify as needed
          List<TVShow> tvshowsList =
              jsonResponse.map((json) => TVShow.fromJson(json)).toList();
          print(tvshowsList);
          print("Rachit");

          return tvshowsList;
        } else {
          print('Error: Response is not a non-empty List');
          return [];
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error during API request: $error');
      return [];
    }
  }

  Future<KidsModel> fetchKidsData() async {
    const apiUrl = "https://unofficial-otakudesu-api-me.vercel.app/api/home";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonData = json.decode(response.body);

        // Logging
        print("API Response:");
        print(jsonData);

        return KidsModel.fromJson(jsonData);
      } else {
        // Handle errors, you can throw an exception or return an error message
        print("Failed to load data. Status code: ${response.statusCode}");
        throw Exception(
            "Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      // Handle exceptions
      print("Error: $error");
      throw error;
    }
  }

  //// Hollywood Music
  Future<List<HollywoodMusic>> fetchHollywoodMusicData() async {
    const url = "https://storage.googleapis.com/uamp/catalog.json";
    Uri uri = Uri.parse(url);
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final body = response.body;
        final json = jsonDecode(body);
        final result = json['music'] as List<dynamic>;
        final musicList = result.map((e) {
          return HollywoodMusic.fromJson(e);
        }).toList();

        debugPrint(response.body.toString());
        return musicList;
      } else {
        return throw ("Data fetch failed");
      }
    } catch (e) {
      print(e);
      return throw ("Data fetch failed");
    }
  }

  /// Kids Anime
  Future<List<KidsAnimeModel>> fetchKidsAnimeData() async {
    final Uri apiUrl = Uri.parse('https://api.jikan.moe/v4/anime?q=naruto&sfw');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      List<KidsAnimeModel> extractedData = [];

      for (var animeData in data) {
        extractedData.add(KidsAnimeModel.fromJson(animeData));
      }

      return extractedData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<HomeMovies> fetchHomeMovies() async {
    const String apiUrl = 'https://movies-api14.p.rapidapi.com/home/';

    final Uri uri = Uri.parse(apiUrl);

    final Map<String, String> headers = {
      'X-RapidAPI-Key': '',
      'X-RapidAPI-Host': 'movies-api14.p.rapidapi.com'
    };

    try {
      final http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse is Map<String, dynamic>) {
          HomeMovies homemovies = HomeMovies.fromJson(jsonResponse);

          print(homemovies);

          print("Rachit");

          return homemovies;
        } else if (jsonResponse is List) {
          if (jsonResponse.isNotEmpty) {
            HomeMovies homemovies = HomeMovies.fromJson(jsonResponse[0]);
            print(homemovies);
            print("Rachit");
            return homemovies;
          } else {
            print('Error: Response list is empty');
            return HomeMovies();
          }
        } else {
          print('Error: Response is not a Map or List');
          return HomeMovies();
        }
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        return HomeMovies();
      }
    } catch (error) {
      print('Error during API request: $error');
      return HomeMovies();
    }
  }

  ///// Hindi TvShow
  Future<List<HindiTvShow>> fetchHindiTvShows() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/trending/tv/week'),
      headers: {
        'Authorization':
            'Bearer ',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> results = json.decode(response.body)['results'];
      print(results);

      return results.map((json) => HindiTvShow.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Hindi TV shows');
    }
  }
}
