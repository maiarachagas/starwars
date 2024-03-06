import 'package:project_starwars/app/controllers/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginationWidget extends StatefulWidget {
  final Function(String value) onTap;
  final Object? allPersonages;

  const PaginationWidget({Key? key, required this.onTap, this.allPersonages})
      : super(key: key);

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryController>(builder: (context, value, child) {
      if (value.category == null ||
          value.category!.next == null ||
          value.category!.next == '0') {
        return Container();
      } else {
        var lastPage = (value.category!.count! + 10 - 1) ~/ 10;
        return Row(
          children: [
            if (value.category!.current != '1')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
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
                    onTap: () => widget.onTap(value.category!.previous!),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.white10,
                  child: Center(
                      child: Text(
                    value.category!.current!,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
                ),
              ),
            ),
            buildPageButton(value.category!.next!),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.white10,
                  child: const Center(child: Text('...'))),
            ),
            buildPageButton(lastPage.toString()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
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
                  onTap: () => widget.onTap(value.category!.next!),
                ),
              ),
            ),
          ],
        );
      }
    });
  }

  Widget buildPageButton(String pageNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => widget.onTap(pageNumber),
          child: Container(
            width: 20,
            height: 20,
            color: Colors.white10,
            child: Center(child: Text(pageNumber.toString())),
          ),
        ),
      ),
    );
  }
}
