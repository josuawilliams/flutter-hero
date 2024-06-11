import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hero/models/favorite_res_model.dart';
import 'package:flutter_hero/models/heroes_res_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  Future<Response?> RegisteredUser(Map req) async {
    try {
      await dotenv.load();
      final BaseURL = dotenv.get('FLUTTER_HTTP');
      final response = await Dio().post("$BaseURL/user/register", data: req);
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> LoginUser(Map req) async {
    try {
      await dotenv.load();
      final BaseURL = dotenv.get('FLUTTER_HTTP');
      final response = await Dio().post("$BaseURL/user/login", data: req);
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Either<String, List<HeroesResModel>>> getAllHeroes() async {
    try {
      await dotenv.load();
      SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString('token');
      final BaseURL = dotenv.get('FLUTTER_HTTP');
      final response = await Dio().get("$BaseURL/heroes/list",
          options: Options(headers: {"token-header": token}));
      final hero = response.toString();
      final jsonData = jsonDecode(hero);
      if (jsonData != null) {
        final List<HeroesResModel> heroes = [];
        for (var item in jsonData["data"]) {
          heroes.add(HeroesResModel.fromJson(item));
        }
        return Right(heroes);
      } else {
        return Left("Error Di Get List");
      }
    } on DioException catch (e) {
      Map<String, dynamic> responseJson = jsonDecode(e.response.toString());
      String message = responseJson['message'];
      if (message != null) {
        return Left(message);
      } else {
        return Left(e.toString());
      }
    }
  }

  Future<Either<String, List<FavoriteResModel>>> getAllFavoriteHeroes() async {
    try {
      await dotenv.load();
      SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString('token');
      final BaseURL = dotenv.get('FLUTTER_HTTP');
      final response = await Dio().get("$BaseURL/heroes/favourites",
          options: Options(headers: {"token-header": token}));
      final hero = response.toString();
      final jsonData = jsonDecode(hero);

      if (jsonData != null) {
        if (jsonData["data"]["hero"] != null) {
          final List<FavoriteResModel> heroes = [];
          for (var item in jsonData["data"]["hero"]) {
            heroes.add(FavoriteResModel.fromJson(item));
          }
          return Right(heroes);
        } else {
          final List<FavoriteResModel> heroes = [];
          return Right(heroes);
        }
      } else {
        return Left("Error Di Get List");
      }
    } on DioException catch (e) {
      Map<String, dynamic> responseJson = jsonDecode(e.response.toString());
      String message = responseJson['message'];
      if (message != null) {
        return Left(message);
      } else {
        return Left(e.toString());
      }
    }
  }

  Future<Response?> AddFavoriteHero(String id) async {
    try {
      await dotenv.load();
      SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString('token');
      final BaseURL = dotenv.get('FLUTTER_HTTP');
      final response = await Dio().post("$BaseURL/heroes/favourites/$id",
          options: Options(headers: {"token-header": token}));
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> DeleteFavoriteHero(String id) async {
    try {
      await dotenv.load();
      SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString('token');
      final BaseURL = dotenv.get('FLUTTER_HTTP');
      final response = await Dio().delete(
          "$BaseURL/heroes/delete-favourite/$id",
          options: Options(headers: {"token-header": token}));
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> EditUser(Map req) async {
    try {
      await dotenv.load();
      SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString('token');
      final BaseURL = dotenv.get('FLUTTER_HTTP');
      final response = await Dio().patch("$BaseURL/heroes/user-name",
          data: req, options: Options(headers: {"token-header": token}));
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }
}
