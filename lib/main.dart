import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'dart:developer' as devtools;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static final _pageController = PageController();
  static final _pageIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Safe Area
          const SafeArea(
            child: SizedBox.shrink(),
          ),
          SizedBox(height: size.height * .1),
          const Text(
            'Welcome!',
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  _pageIndex.value = index;
                },
                children: const [
                  Center(
                    child: Text(
                      'Text for slide 1',
                    ),
                  ),
                  Center(
                    child: Text(
                      'Text for slide 2',
                    ),
                  ),
                  Center(
                    child: Text(
                      'Text for slide 3',
                    ),
                  ),
                  Center(
                    child: Text(
                      'Text for slide 4',
                    ),
                  ),
                  Center(
                    child: Text(
                      'Text for slide 5',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
          TextButton(
            onPressed: () {
              devtools.log('page: ${_pageController.page}');

              // Don't jump past the last page
              if (_pageController.page != 4) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
                _pageIndex.value += 1;
              }
            },
            child: const Text('Next'),
          ),
          ValueListenableBuilder(
            valueListenable: _pageIndex,
            builder: (_, int index, __) {
              return DotsIndicator(
                dotsCount: 5,
                position: index.toDouble(),
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              );
            },
          ),
          const SafeArea(
            child: SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
