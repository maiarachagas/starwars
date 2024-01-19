import 'package:app_teste_unitario/app/controllers/personages_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<PersonagesController>(
      builder: (context, value, child) {
        // _fetchData(value);
        if (value.personages == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (value.personages!.isEmpty) {
            return Center(
              child: Text('Nenhum ${widget.category} encontrado'),
            );
          } else {
            return GridView.extent(
              maxCrossAxisExtent: 250.0,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 200 / 300,
              children: value.personages!
                  .map((person) => Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                              width: 190,
                              child: person.thumbnailUrl == null ||
                                      person.thumbnailUrl!.isEmpty
                                  ? Image.asset(
                                      'assets/images/logo_starwars.png',
                                      color: Colors.grey.shade300,
                                    )
                                  : Image.network(
                                      person.thumbnailUrl!,
                                      fit: BoxFit.contain,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                person.name!,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            );
          }
        }
      },
    );
  }
}
