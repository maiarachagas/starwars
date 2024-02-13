import 'package:app_teste_unitario/app/controllers/category_controller.dart';
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
    return Consumer<CategoryController>(
      builder: (context, value, child) {
        if (value.category == null || value.category!.detail == null) {
          return const Center(child: CircularProgressIndicator());
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
                          onTap: () {},
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
}
