import 'package:app_teste_unitario/app/controllers/index.dart';
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
    var controller = Provider.of<CategoryController>(context, listen: false);
    categoryNotifier = ValueNotifier<String>('films');

    Future.delayed(Duration.zero, () async {
      await controller.getDataByPage(category: 'films', page: '1');
      setState(() {
        controller;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var category = Provider.of<CategoryController>(context, listen: false);
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

              await category.getDataByPage(category: value, page: '1');
              setState(() {
                category;
              });
            }),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 15),
              child: Row(children: [
                const SearchWidget(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: PaginationWidget(
                      onTap: (value) async {
                        await category.getDataByPage(
                            category: categoryNotifier.value,
                            page: value.toString());
                      },
                    ))
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
}
