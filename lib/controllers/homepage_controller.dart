import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:poksapp/models/page.dart';
import 'package:poksapp/models/pokeman.dart';
import 'package:poksapp/services/http_services.dart';

class HomepageController extends StateNotifier<HomePageData> {
  final GetIt _getIt = GetIt.instance;
  late HttpServices _httpServices;

  HomepageController(super._state) {
    _httpServices = _getIt.get<HttpServices>();
    _setup();
  }
  Future<void> _setup() async {
    loadData();
  }

  Future<void> loadData() async {
    if (state.data == null) {
      Response? res = await _httpServices
          .get("https://pokeapi.co/api/v2/pokemon?limit=20&offset=0");
      if (res != null && res.data != null) {
        PokemonListData data = PokemonListData.fromJson(res.data);
        state = state.copyWith(data: data);
      }
      print(res?.data);
    }
  }
}
