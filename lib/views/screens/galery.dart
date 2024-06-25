import 'package:flutter/material.dart';

class MyImageSlider extends StatefulWidget {
  const MyImageSlider({super.key});

  @override
  State<MyImageSlider> createState() => _MyImageSliderState();
}

class _MyImageSliderState extends State<MyImageSlider> {
  final myitems = [
    Image.asset('assets/images/image1.png', fit: BoxFit.cover),
    Image.asset('assets/images/image2.png', fit: BoxFit.cover),
    Image.asset('assets/images/image3.png', fit: BoxFit.cover),
    Image.asset('assets/images/image4.png', fit: BoxFit.cover),
    Image.asset('assets/images/image5.png', fit: BoxFit.cover),
    Image.asset('assets/images/image6.png', fit: BoxFit.cover),
  ];

  int myCurrentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.75);

  @override
  void initState() {
    super.initState();
    _autoPlay();
  }

  void _autoPlay() {
    Future.delayed(const Duration(seconds: 2), () {
      if (_pageController.hasClients) {
        int nextPage = myCurrentIndex + 1;
        if (nextPage >= myitems.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
      _autoPlay();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      appBar: AppBar(
        title: const Text('Auto Image Slider'),
        centerTitle: true,
        elevation: 3,
        backgroundColor: Colors.grey.shade800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    myCurrentIndex = index;
                  });
                },
                itemCount: myitems.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * .3)).clamp(0.0, 1.0);
                      }
                      return Center(
                        child: SizedBox(
                          height: Curves.easeOut.transform(value) * 200,
                          child: child,
                        ),
                      );
                    },
                    child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        width: 400,
                        height: 300,
                        margin: const EdgeInsets.all(10),
                        child: myitems[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(myitems.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  height: 8.0,
                  width: myCurrentIndex == index ? 24.0 : 8.0,
                  decoration: BoxDecoration(
                    color: myCurrentIndex == index ? Colors.white : Colors.grey,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
