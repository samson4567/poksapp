import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poksapp/controllers/homepage_controller.dart';
import 'package:poksapp/models/page.dart';
import 'package:poksapp/models/pokeman.dart';
import 'package:poksapp/widgets/pokeman_list_tile.dart';

final homePageControllerProvider =
    StateNotifierProvider<HomepageController, HomePageData>((ref) {
  return HomepageController(HomePageData.initial());
});

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final ScrollController _allPokemanlistController = ScrollController();

  late HomepageController _homepageController;
  late HomePageData _homePageData;

  @override
  Widget build(BuildContext context) {
    // Access the controller
    _homepageController = ref.watch(homePageControllerProvider.notifier);

    // Access the current HomePageData state directly
    _homePageData = ref.watch(homePageControllerProvider);

    return Scaffold(
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width *
                0.02), // Adjusted the width factor
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_allPokemonList(context)],
        ),
      ),
    ));
  }

  Widget _allPokemonList(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          const Text(
            'All Poken',
            style: TextStyle(fontSize: 25, fontFamily: 'Geist'),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height *
                0.6, // Adjusted the height factor
            child: ListView.builder(
                controller: _allPokemanlistController,
                itemCount: _homePageData.data?.results?.length ??
                    0, // Replace 0 with actual item count if available
                itemBuilder: (context, index) {
                  PokemonListResult pokemon =
                      _homePageData.data!.results![index];
                  return PokemanListTile(pokemanUrl: pokemon.url!);
                }),
          )
        ],
      ),
    );
  }
}
