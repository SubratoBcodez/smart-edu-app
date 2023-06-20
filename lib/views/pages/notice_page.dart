import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  var data;
  NoticePage({required this.data});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notice Details',
          style: TextStyle(),
        ),
        backgroundColor: Color(0xFF2ECC71),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Text(
          //   widget.data['title'],
          //   style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.w600,
          //       color: Colors.black),
          // ),
          Stack(
            children: [
              Builder(builder: (context) {
                final double height = MediaQuery.of(context).size.height;
                return InkWell(
                  child: CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                      //scrollPhysics: const BouncingScrollPhysics(),
                      autoPlay: false,
                      height: 450,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    items: widget.data['img_url']
                        .map<Widget>(
                          (item) => CachedNetworkImage(
                            imageUrl: item,
                            key: UniqueKey(),
                            width: double.maxFinite,
                            height: height,
                            fit: BoxFit.fitWidth,
                            placeholder: (context, url) => Container(
                              color: Colors.grey,
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              }),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.data['img_url']
                      .asMap()
                      .entries
                      .map<Widget>((item) {
                    return GestureDetector(
                      onTap: () => carouselController.animateToPage(item.key),
                      child: Container(
                        width: currentIndex == item.key ? 17 : 7,
                        height: 7.0,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 3.0,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentIndex == item.key
                                ? Colors.red
                                : Colors.teal),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
