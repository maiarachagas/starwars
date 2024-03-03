import 'package:app_teste_unitario/app/controllers/index.dart';
import 'package:app_teste_unitario/app/views/components/grid_view.dart';
import 'package:app_teste_unitario/app/views/components/menu.dart';
import 'package:app_teste_unitario/app/views/components/pagination.dart';
import 'package:app_teste_unitario/app/views/components/search.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ValueNotifier<String> categoryNotifier;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    var controller = Provider.of<CategoryController>(context, listen: false);
    categoryNotifier = ValueNotifier<String>('films');

    Future.delayed(const Duration(seconds: 1), () async {
      await controller.getDataByPage(category: 'films', page: '1');
      setState(() {
        loading = false;
        controller;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var category = Provider.of<CategoryController>(context, listen: false);
    return Stack(
      children: [
        Scaffold(
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
                  setState(() {
                    loading = true;
                  });
                  categoryNotifier.value = value;
                  Future.delayed(const Duration(seconds: 1), () {
                    category
                        .getDataByPage(category: value, page: '1')
                        .then((_) {
                      setState(() {
                        loading = false;
                        category;
                      });
                    });
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
                            setState(() {
                              loading = true;
                            });
                            await category
                                .getDataByPage(
                                    category: categoryNotifier.value,
                                    page: value.toString())
                                .then((_) {
                              setState(() {
                                loading = false;
                                category;
                              });
                            });
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
        ),
        if (loading)
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.8),
            child: Center(
              child: SizedBox(
                height: 80,
                width: 80,
                child: LoadingIndicator(
                  indicatorType: Indicator.orbit,
                  colors: [
                    Colors.blue,
                    Colors.blue,
                    Colors.blue,
                    Colors.grey.shade600,
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
