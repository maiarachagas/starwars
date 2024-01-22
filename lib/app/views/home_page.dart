import 'package:app_teste_unitario/app/controllers/personages_controller.dart';
import 'package:app_teste_unitario/app/views/components/grid_view.dart';
import 'package:app_teste_unitario/app/views/components/menu.dart';
import 'package:app_teste_unitario/app/views/components/pagination.dart';
import 'package:app_teste_unitario/app/views/components/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ValueNotifier<String> categoryNotifier;

  @override
  void initState() {
    super.initState();
    categoryNotifier = ValueNotifier<String>('Filmes');
  }

  @override
  Widget build(BuildContext context) {
    var personagesController =
        Provider.of<PersonagesController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Image.asset('assets/images/logo_starwars.png', height: 50),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuWidget(onTap: (value) async {
              categoryNotifier.value = value;
              _fetchData(personagesController, '1');
            }),
            personagesController.personages == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
                    child: Row(children: [
                      const SearchWidget(),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                          child: PaginationWidget(
                              onTap: (value) {
                                _fetchData(
                                    personagesController, value.toString());
                              },
                              allPersonages: personagesController.personages))
                    ]),
                  ),
            Expanded(
              child: ValueListenableBuilder<String>(
                valueListenable: categoryNotifier,
                builder: (context, value, child) {
                  return GridViewWidget(category: value);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _fetchData(
      PersonagesController personagesController, String numPage) async {
    switch (categoryNotifier.value) {
      /* case 'Filmes':
        {}
        break;*/
      case 'Personagens':
        {
          await _fetchPersonages(personagesController, numPage);
          await personagesController
              .attributeImageToPerson(personagesController.personage!);
        }
        break;
      /* case 'Espécies':
        {}
        break;
      case 'Naves':
        {}
        break;
      case 'Veículos':
        {}
        break;
      case 'Planetas':
        {}
        break;*/
      default:
        {
          personagesController.clearList();
        }
    }
  }

  Future<void> _fetchPersonages(
      PersonagesController personagesController, String numPage) async {
    await personagesController.getPersonagesByPage(page: 'page=$numPage');

    await personagesController.fetchPersonages();
    setState(() {
      personagesController;
    });
  }
}
