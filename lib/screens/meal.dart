import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cookley/core/main.dart';
import 'package:cookley/resources/app_colors.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController();
    double appBarHeight = 360;
    double _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Button(
                  onPress: () {},
                  child: SvgPicture.asset('assets/icons/favorite.svg',
                      color: Colors.white),
                ),
              )
            ],
            backgroundColor: const Color.fromRGBO(231, 242, 201, 1),
            expandedHeight: appBarHeight,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              title: const Row(
                children: <Widget>[
                  Expanded(child: Text('Grilled meat Skewers')),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),
              background: Stack(children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/meal-bg.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Button(
                            onPress: () {},
                            child: SvgPicture.asset(
                              'assets/icons/arrow-left.svg',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: double.infinity,
                      height: appBarHeight,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromRGBO(0, 0, 0, 0),
                              Color.fromRGBO(0, 0, 0, 0.92),
                            ]),
                      ),
                    )),
                Positioned(
                    right: 16,
                    bottom: 16,
                    child: Button(
                      onPress: () {},
                      child: SvgPicture.asset('assets/icons/play.svg'),
                    ))
              ]),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: Colors.white,
                  child: TabBar(
                    labelColor: AppColor.green,
                    indicatorColor: AppColor.green,
                    tabs: const <Tab>[
                      Tab(
                        text: "Ingredients",
                      ),
                      Tab(text: "Process"),
                    ],
                    controller: _tabController,
                    onTap: (e) {
                      setState(() {
                        _selectedTab = e;
                      });
                    },
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.white,
                  height: _height / 2,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _renderIngredients(),
                      _renderProcess(),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

Widget _renderIngredients() {
  List<String> items = List<String>.generate(100, (i) => 'Item $i');

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Ingredients for',
                    style: TextStyle(
                      color: Color.fromRGBO(161, 163, 170, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    ' 4 Servings',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Button(
                      child: Icon(
                        Icons.remove_circle_outline,
                        color: AppColor.green,
                        size: 20,
                      ),
                      onPress: () {}),
                  const SizedBox(width: 6),
                  const Text(
                    '4',
                    style: TextStyle(
                      color: Color.fromRGBO(161, 163, 170, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Button(
                      child: Icon(
                        Icons.add_circle_outline,
                        color: AppColor.green,
                        size: 20,
                      ),
                      onPress: () {}),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            prototypeItem: ListTile(
              title: Text(items.first),
            ),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 1,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '2 tbsp',
                      style: TextStyle(
                        color: Color.fromRGBO(161, 163, 170, 1),
                      ),
                    ),
                  ],
                ),
                shape: const Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(0, 0, 0, 0.15)),
                ),
              );
            },
          ),
        )
      ],
    ),
  );
}

Widget _renderProcess() {
  return Text('Process');
}
