import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poksapp/models/pokeman.dart';
import 'package:poksapp/providers/pokeman_data_providers.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemanListTile extends ConsumerWidget {
  final String pokemanUrl;

  const PokemanListTile({super.key, required this.pokemanUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonDataProvider(pokemanUrl));
    return pokemon.when(
      data: (data) {
        return _tile(context, false, data);
      },
      error: (error, stackTrace) {
        return Text('Error: $error');
      },
      loading: () {
        return _tile(context, true, null);
      },
    );
  }

  Widget _tile(BuildContext context, bool isLoading, Pokemon? pokemon) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListTile(
        leading: pokemon != null
            ? CircleAvatar(
                backgroundImage: NetworkImage(pokemon.sprites!.frontDefault!),
              )
            : CircleAvatar(),
        title: pokemon != null
            ? Text(pokemon.name!.toUpperCase())
            : const Text("Currently loading pokemon"),
        subtitle: Text("Has ${pokemon?.moves?.length.toString() ?? 0}movies"),
        trailing:
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
      ),
    );
  }
}
