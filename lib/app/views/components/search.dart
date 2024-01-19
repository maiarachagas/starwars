import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Digite o veículo a ser pesquisado',
                      hintStyle: TextStyle(fontSize: 14),
                      contentPadding: EdgeInsets.only(bottom: 10),
                      border: InputBorder.none),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5))),
                child: const Icon(
                  Icons.search,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
