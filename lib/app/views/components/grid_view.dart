// ignore_for_file: use_build_context_synchronously

import 'package:app_teste_unitario/app/controllers/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'show_dialog.dart';

class GridViewWidget extends StatefulWidget {
  final String? category;
  const GridViewWidget({Key? key, required this.category}) : super(key: key);

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(
      builder: (context, value, child) {
        if (value.category == null || value.category!.detail == null) {
          return const Center(child: Text('Carregando ...'));
        } else {
          if (value.category!.detail!.isEmpty) {
            return Center(
              child: Text('Nenhum ${widget.category} encontrado'),
            );
          } else {
            return GridView.extent(
              maxCrossAxisExtent: 250.0,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 200 / 300,
              children: value.category!.detail!
                  .map((detail) => MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            getDetails(detail.url!, detail.image!);
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Expanded(
                                  child: detail.image == null ||
                                          detail.image!.isEmpty
                                      ? Image.asset(
                                          'assets/images/logo_starwars.png',
                                          color: Colors.grey.shade300,
                                        )
                                      : Image.network(
                                          detail.image!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        detail.name!,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            overflow: TextOverflow.clip),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            );
          }
        }
      },
    );
  }

  Future getDetails(String url, String image) async {
    switch (widget.category) {
      case 'films':
        {
          var model = Provider.of<FilmsController>(context, listen: false);
          await model.getFilmsById(endpoint: url, image: image);
          await detailsFilm(context, model.filmDetail!);
        }
        break;
      case 'people':
        {
          var model = Provider.of<PersonagesController>(context, listen: false);
          await model.getPersonageById(endpoint: url, image: image);
          await detailsPersonage(context, model.personageDetail!);
        }
        break;
      case 'species':
        {
          var model = Provider.of<SpeciesController>(context, listen: false);
          await model.getSpecieById(endpoint: url, image: image);
          await detailsSpecie(context, model.specieDetail!);
        }
        break;

      case 'starships':
        {
          var model = Provider.of<StarshipsController>(context, listen: false);
          await model.getStarshipById(endpoint: url, image: image);
          await detailsStarship(context, model.starshipDetail!);
        }
        break;

      case 'vehicles':
        {
          var model = Provider.of<VehiclesController>(context, listen: false);
          await model.getVehicleById(endpoint: url, image: image);
          await detailsVehicle(context, model.vehicleDetail!);
        }
        break;

      case 'planets':
        {
          var model = Provider.of<PlanetsController>(context, listen: false);
          await model.getPlanetById(endpoint: url, image: image);
          await detailsPlanet(context, model.planetDetail!);
        }
        break;
      default:
        return Container();
    }
  }
}
