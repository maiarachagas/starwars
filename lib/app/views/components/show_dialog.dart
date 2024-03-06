import 'package:app_teste_unitario/app/models/personages_model.dart';
import 'package:app_teste_unitario/app/models/planets_model.dart';
import 'package:app_teste_unitario/app/models/species_model.dart';
import 'package:app_teste_unitario/app/models/starships_model.dart';
import 'package:app_teste_unitario/app/models/vehicles_model.dart';
import 'package:flutter/material.dart';

import '../../models/films_model.dart';

Future<Widget> detailsFilm(BuildContext context, Film detail) async {
  return await showDialog(
    context: context,
    builder: (_) {
      return StatefulBuilder(builder: (_, StateSetter setState) {
        var size = MediaQuery.of(context).size;

        setState(() => size);
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                constraints: BoxConstraints(
                  maxWidth: 1000,
                  maxHeight: constraints.maxHeight,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.95),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.clear,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: detail.thumbnailUrl == null ||
                                        detail.thumbnailUrl!.isEmpty
                                    ? Image.asset(
                                        'assets/images/logo_starwars.png',
                                        color: Colors.grey.shade300,
                                        width: size.width / 3.4,
                                        height: size.height / 1.4,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          detail.thumbnailUrl!,
                                          fit: BoxFit.cover,
                                          width: size.width / 3.4,
                                          height: size.height / 1.4,
                                        ),
                                      ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail.title!.toUpperCase(),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Episódio:',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.episodeId}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Lançamento:',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.releaseDate}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Diretor(a):',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.director}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Produtor(a):',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.producer}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Descrição:',
                                        style: TextStyle(
                                          color: Colors.grey.shade200,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                      Text(
                                        '${detail.openingCrawl}',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Colors.grey.shade200,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });
    },
  );
}

Future<Widget> detailsPersonage(BuildContext context, Personage detail) async {
  return await showDialog(
    context: context,
    builder: (_) {
      return StatefulBuilder(builder: (_, StateSetter setState) {
        var size = MediaQuery.of(context).size;

        setState(() => size);
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                constraints: BoxConstraints(
                  maxWidth: 1000,
                  maxHeight: constraints.maxHeight,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.95),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.clear,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: detail.thumbnailUrl == null ||
                                        detail.thumbnailUrl!.isEmpty
                                    ? Image.asset(
                                        'assets/images/logo_starwars.png',
                                        color: Colors.grey.shade300,
                                        width: size.width / 3.4,
                                        height: size.height / 1.4,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          detail.thumbnailUrl!,
                                          fit: BoxFit.cover,
                                          width: size.width / 3.2,
                                          height: size.height / 1.4,
                                        ),
                                      ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail.name!.toUpperCase(),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nascimento: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.birthYear}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Gênero: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.gender}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Altura: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.height}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Planeta: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.planet.name}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Espécie: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: detail.speciesList
                                                  .map((specie) {
                                                return Text(
                                                  specie.name!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Filmes: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  detail.filmsList.map((film) {
                                                return Text(
                                                  film.title!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Veículos: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: detail.vehiclesList
                                                  .map((vehicle) {
                                                return Text(
                                                  vehicle.name!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Naves: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: detail.starshipsList
                                                  .map((starship) {
                                                return Text(
                                                  starship.name!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });
    },
  );
}

Future<Widget> detailsVehicle(BuildContext context, Vehicle detail) async {
  return await showDialog(
    context: context,
    builder: (_) {
      return StatefulBuilder(builder: (_, StateSetter setState) {
        var size = MediaQuery.of(context).size;

        setState(() => size);
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                constraints: BoxConstraints(
                  maxWidth: 1000,
                  maxHeight: constraints.maxHeight,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.95),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.clear,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: detail.thumbnailUrl == null ||
                                        detail.thumbnailUrl!.isEmpty
                                    ? Image.asset(
                                        'assets/images/logo_starwars.png',
                                        color: Colors.grey.shade300,
                                        width: size.width / 3.4,
                                        height: size.height / 1.4,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          detail.thumbnailUrl!,
                                          fit: BoxFit.cover,
                                          width: size.width / 3.4,
                                          height: size.height / 1.4,
                                        ),
                                      ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail.name!.toUpperCase(),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Modelo: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.model}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Fabricante: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.manufacturer}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Velocidade máxima: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.maxAtmospheringSpeed}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Capacidade de passageiro: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.passengers}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Classe de Veículo: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.vehicleClass}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pilotos: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  detail.personageList.map((x) {
                                                return Text(
                                                  x.name!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Filmes: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  detail.filmsList.map((film) {
                                                return Text(
                                                  film.title!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });
    },
  );
}

Future<Widget> detailsPlanet(BuildContext context, Planet detail) async {
  return await showDialog(
    context: context,
    builder: (_) {
      return StatefulBuilder(builder: (_, StateSetter setState) {
        var size = MediaQuery.of(context).size;

        setState(() => size);
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                constraints: BoxConstraints(
                  maxWidth: 1000,
                  maxHeight: constraints.maxHeight,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.95),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.clear,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: detail.thumbnailUrl == null ||
                                        detail.thumbnailUrl!.isEmpty
                                    ? Image.asset(
                                        'assets/images/logo_starwars.png',
                                        color: Colors.grey.shade300,
                                        width: size.width / 3.4,
                                        height: size.height / 1.4,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          detail.thumbnailUrl!,
                                          fit: BoxFit.cover,
                                          width: size.width / 3.4,
                                          height: size.height / 1.4,
                                        ),
                                      ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail.name!.toUpperCase(),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Em órbita há: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.orbitalPeriod}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Diameto: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.diameter}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Clima: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.climate}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Gravidade: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.gravity}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Terreno: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.terrain}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'População: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.population}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Moradores: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: detail.personageList
                                                  .map((people) {
                                                return Text(
                                                  people.name!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Filmes: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  detail.filmsList.map((film) {
                                                return Text(
                                                  film.title!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });
    },
  );
}

Future<Widget> detailsSpecie(BuildContext context, Specie detail) async {
  return await showDialog(
    context: context,
    builder: (_) {
      return StatefulBuilder(builder: (_, StateSetter setState) {
        var size = MediaQuery.of(context).size;

        setState(() => size);
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                constraints: BoxConstraints(
                  maxWidth: 1000,
                  maxHeight: constraints.maxHeight,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.95),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.clear,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: detail.thumbnailUrl == null ||
                                        detail.thumbnailUrl!.isEmpty
                                    ? Image.asset(
                                        'assets/images/logo_starwars.png',
                                        color: Colors.grey.shade300,
                                        width: size.width / 3.4,
                                        height: size.height / 1.4,
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          detail.thumbnailUrl!,
                                          fit: BoxFit.cover,
                                          width: size.width / 3.4,
                                          height: size.height / 1.4,
                                        ),
                                      ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail.name!.toUpperCase(),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Classificação: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.classification}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Designação: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.designation}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Altura média: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.averageHeight}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Vida média: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.averageLifespan}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Língua/Idioma: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.language}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Planeta: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.planet.name}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Moradores: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: detail.personageList
                                                  .map((people) {
                                                return Text(
                                                  people.name!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Filmes: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  detail.filmsList.map((film) {
                                                return Text(
                                                  film.title!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });
    },
  );
}

Future<Widget> detailsStarship(BuildContext context, Starship detail) async {
  return await showDialog(
    context: context,
    builder: (_) {
      return StatefulBuilder(builder: (_, StateSetter setState) {
        var size = MediaQuery.of(context).size;

        setState(() => size);
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                constraints: BoxConstraints(
                  maxWidth: 1000,
                  maxHeight: constraints.maxHeight,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(0.95),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.clear,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: detail.thumbnailUrl == null ||
                                          detail.thumbnailUrl!.isEmpty
                                      ? Image.asset(
                                          'assets/images/logo_starwars.png',
                                          color: Colors.grey.shade300,
                                          width: size.width / 3.4,
                                          height: size.height / 1.4,
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            detail.thumbnailUrl!,
                                            fit: BoxFit.cover,
                                            width: size.width / 3.4,
                                            height: size.height / 1.4,
                                          ),
                                        ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail.name!.toUpperCase(),
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Modelo: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.model}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Fabricante: ',
                                            style: TextStyle(
                                              color: Colors.grey.shade200,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.manufacturer}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Velocidade máxima: ',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.maxAtmospheringSpeed}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Classificação da nave: ',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${detail.starshipClass}',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Piloto: ',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: detail.personageList
                                                  .map((people) {
                                                return Text(
                                                  people.name!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              'Filmes: ',
                                              style: TextStyle(
                                                color: Colors.grey.shade200,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children:
                                                  detail.filmsList.map((film) {
                                                return Text(
                                                  film.title!,
                                                  style: TextStyle(
                                                    color: Colors.grey.shade200,
                                                    fontSize: 22,
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });
    },
  );
}
