import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/personages_controller.dart';
import '../../models/personages_model.dart';

class PaginationWidget extends StatefulWidget {
  final Function(int value) onTap;
  final Personages? allPersonages;

  const PaginationWidget({Key? key, required this.onTap, this.allPersonages})
      : super(key: key);

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonagesController>(builder: (context, value, child) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: GestureDetector(
              child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.white10,
                  child: const Center(
                      child: Icon(
                    Icons.arrow_back_ios,
                    size: 12,
                    color: Colors.white,
                  ))),
              onTap: () => widget.onTap(value.previousPage),
            ),
          ),
          buildPageButton(value.current),
          buildPageButton(value.nextPage),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Container(
                width: 20,
                height: 20,
                color: Colors.white10,
                child: const Center(child: Text('...'))),
          ),
          buildPageButton(value.totalPage),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: GestureDetector(
              child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.white10,
                  child: const Center(
                      child: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.white,
                  ))),
              onTap: () => widget.onTap(value.nextPage),
            ),
          ),
        ],
      );
    });
  }

  Widget buildPageButton(int pageNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: GestureDetector(
        onTap: () => widget.onTap(pageNumber),
        child: Container(
          width: 20,
          height: 20,
          color: Colors.white10,
          child: Center(child: Text(pageNumber.toString())),
        ),
      ),
    );
  }
}
