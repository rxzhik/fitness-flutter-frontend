import 'package:fitness/models/category_modle.dart';
import 'package:fitness/models/diet_model.dart';
import 'package:fitness/models/popular_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    // Its not necessary to make it a statefulWidget, we can rather do it like
    // this.
    _getInitialInfo();
    return Scaffold(
      appBar: _renderAppBar(context),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _renderSearchBar(),
          const SizedBox(
            height: 40,
          ),
          _renderCategorySection(),
          const SizedBox(
            height: 40,
          ),
          _renderDietSection(context),
          const SizedBox(
            height: 40,
          ),
          _renderPopularSection(context),
        ],
      ),
    );
  }

  Column _renderPopularSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Popular',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ListView.separated(
          itemCount: popularDiets.length,
          separatorBuilder: (contet, index) => const SizedBox(
            height: 25,
          ),
          // If you don't set it to true the list will be as big as its parent,
          // but if you set it to true, the list will be as big as its children
          // will allow it to be.
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 20, right: 20),
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              decoration: BoxDecoration(
                  color: popularDiets[index].boxIsSelected
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: popularDiets[index].boxIsSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xff1D1617).withOpacity(0.07),
                            offset: const Offset(0, 10),
                            blurRadius: 40,
                            spreadRadius: 0,
                          ),
                        ]
                      : []),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    popularDiets[index].iconPath,
                    width: 65,
                    height: 65,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        popularDiets[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        popularDiets[index].level +
                            ' | ' +
                            popularDiets[index].duration +
                            ' | ' +
                            popularDiets[index].calorie,
                        style: const TextStyle(
                          color: Color(0xff7B6F72),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => {},
                    child: SvgPicture.asset(
                      'assets/icons/button.svg',
                      width: 30,
                      height: 30,
                    ),
                  )
                ],
              ),
            );
          },
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Column _renderDietSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Recommendation\nfor Diet',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 240,
          child: ListView.separated(
            itemCount: diets.length,
            separatorBuilder: (contet, index) => const SizedBox(
              width: 25,
            ),
            padding: const EdgeInsets.only(left: 20, right: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                _dietListItemBuilder(context, index),
          ),
        ),
      ],
    );
  }

  Widget _dietListItemBuilder(BuildContext context, int index) {
    return Container(
      width: 210,
      decoration: BoxDecoration(
        color: categories[index].boxColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(diets[index].iconPath),
          Column(
            children: [
              Text(
                diets[index].name,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              Text(
                diets[index].level +
                    ' | ' +
                    diets[index].duration +
                    ' | ' +
                    diets[index].calorie,
                style: const TextStyle(
                  color: Color(0xff7B6F72),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Container(
            height: 45,
            width: 130,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  diets[index].viewIsSelected
                      ? const Color(0xff9DCEFF)
                      : Colors.transparent,
                  diets[index].viewIsSelected
                      ? const Color(0xff92A3FD)
                      : Colors.transparent,
                ],
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                'View',
                style: TextStyle(
                  color: diets[index].viewIsSelected
                      ? Colors.white
                      : const Color(0xffC58BF2),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _renderCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Category',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 150,
          child: ListView.separated(
            itemCount: categories.length,
            separatorBuilder: (contet, index) => const SizedBox(
              width: 25,
            ),
            padding: const EdgeInsets.only(left: 20, right: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                _categoryListItemBuilder(context, index),
          ),
        ),
      ],
    );
  }

  Container _renderSearchBar() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xff1D1617).withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        ),
      ]),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset('assets/icons/Search.svg'),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(15),
            hintText: 'Search Pancake',
            hintStyle: const TextStyle(
              color: Color(0xffDDDADA),
              fontSize: 14,
            ),
            suffixIcon: SizedBox(
              width: 100,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const VerticalDivider(
                      color: Colors.black,
                      indent: 10,
                      endIndent: 10,
                      thickness: 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset('assets/icons/Filter.svg'),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            )),
      ),
    );
  }

  AppBar _renderAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        'Breakfast',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: _rederLeftButton(context),
      actions: [
        _renderActionButton(context),
      ],
    );
  }

  Widget _rederLeftButton(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        // Here height and width won't work because of constraints put by AppBar
        // rather use margin here or even a SizedBox to force a dimension on its
        // child
        // height: 10,
        // width: 10,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffF7F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          'assets/icons/Arrow - Left 2.svg',
          height: 20,
          width: 20,
        ),
      ),
    );
  }

  Widget _renderActionButton(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        // Here height and width won't work because of constraints put by AppBar
        // rather use margin here or even a SizedBox to force a dimension on its
        // child
        // height: 10,
        // width: 10,
        alignment: Alignment.center,
        width: 37,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffF7F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          'assets/icons/dots.svg',
          height: 5,
          width: 5,
        ),
      ),
    );
  }

  Widget _categoryListItemBuilder(context, index) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: categories[index].boxColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(categories[index].iconPath),
          ),
          Text(
            categories[index].name,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
