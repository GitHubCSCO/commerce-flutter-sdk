import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchDestination extends StatelessWidget {
  const SearchDestination({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        height: 45,
        decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: SearchBar(
            leading:
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            hintText: 'Search',
            elevation: MaterialStateProperty.all(3),
          ),
        ),
      )),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 250,
                  width: 250,
                  child: SvgPicture.asset(
                      'assets/images/undraw_mobile_search_jxq5.svg')),
              const SizedBox(
                height: 20,
              ),
              const Text('No search history'),
            ]),
      ),
    );
  }
}
