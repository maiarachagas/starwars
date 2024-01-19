import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  final Function(String value) onTap;
  const MenuWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final List category = [
    {"icon": "assets/icons/popcorn.png", "name": "Filmes"},
    {"icon": "assets/icons/finn.png", "name": "Personagens"},
    {"icon": "assets/icons/c3po.png", "name": "Espécies"},
    {"icon": "assets/icons/tie_fighter.png", "name": "Naves"},
    {"icon": "assets/icons/speeder.png", "name": "Veículos"},
    {"icon": "assets/icons/geonosis.png", "name": "Planetas"},
  ];

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
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onTap(category[index]['name']);
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(category[index]['icon'], height: 32),
                    const SizedBox(width: 5),
                    Text(category[index]['name'].toString().toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                        )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
