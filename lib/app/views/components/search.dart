import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/index.dart';

class SearchWidget extends StatefulWidget {
  final String? categoryId;
  final Function(bool)? callback;

  const SearchWidget({Key? key, this.categoryId, this.callback})
      : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _valueController = TextEditingController();

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
                  controller: _valueController,
                  decoration: const InputDecoration(
                      hintText: 'Digite um nome a ser pesquisado',
                      hintStyle: TextStyle(fontSize: 14),
                      contentPadding: EdgeInsets.only(bottom: 10),
                      border: InputBorder.none),
                  onFieldSubmitted: (value) async {
                    widget.callback!(true);
                    var model =
                        Provider.of<CategoryController>(context, listen: false);
                    await model.searchData(
                        category: widget.categoryId,
                        value: _valueController.text);
                    widget.callback!(false);
                  },
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  widget.callback!(true);
                  var model =
                      Provider.of<CategoryController>(context, listen: false);
                  await model.searchData(
                      category: widget.categoryId,
                      value: _valueController.text);
                  widget.callback!(false);
                },
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
            ),
          ],
        ),
      ),
    );
  }
}
