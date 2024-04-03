import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuWidget extends StatefulWidget {
  final Function(String value) onTap;
  const MenuWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final List category = [
    {"icon": "assets/icons/popcorn.svg", "name": "Filmes", "endpoint": "films"},
    {
      "icon": "assets/icons/finn.svg",
      "name": "Personagens",
      "endpoint": "people"
    },
    {
      "icon": "assets/icons/c3po.svg",
      "name": "Espécies",
      "endpoint": "species"
    },
    {
      "icon": "assets/icons/tie_fighter.svg",
      "name": "Naves",
      "endpoint": "starships"
    },
    {
      "icon": "assets/icons/speeder.svg",
      "name": "Veículos",
      "endpoint": "vehicles"
    },
    {
      "icon": "assets/icons/geonosis.svg",
      "name": "Planetas",
      "endpoint": "planets"
    },
  ];

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: category.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 22.0, 10.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                      widget.onTap(category[index]['endpoint']);
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(category[index]['icon'],
                          width: 32, height: 32),
                      const SizedBox(width: 5),
                      Text(category[index]['name'].toString().toUpperCase(),
                          style: TextStyle(
                            fontSize: 24,
                            color: selectedCategoryIndex == index
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          )),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
