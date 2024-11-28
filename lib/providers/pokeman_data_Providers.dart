import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:poksapp/models/pokeman.dart';
import 'package:poksapp/services/http_services.dart';

final pokemonDataProvider =
    FutureProvider.family<Pokemon?, String>((ref, url) async {
  HttpServices _httpServices = GetIt.instance.get<HttpServices>();
  Response? res = await _httpServices.get(url);

  if (res != null && res.data!) {
    return Pokemon.fromJson(res.data!);
  }
  return null;
});
