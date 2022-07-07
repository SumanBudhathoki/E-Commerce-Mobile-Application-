import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key}) : super(key: key);

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final sliderImages = [
    const AssetImage('assets/jacketsale.png'),
    const AssetImage('assets/denimsale.png'),
    const AssetImage('assets/nikead.png'),
    const AssetImage('assets/womendressad.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: sliderImages.length,
      options: CarouselOptions(
          height: 170,
          viewportFraction: 0.9,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 6)),
      itemBuilder: (context, index, realIndex) {
        final sliderImage = sliderImages[index];
        return buildImage(sliderImage, index);
      },
    );
  }

  Widget buildImage(AssetImage sliderImage, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image(
          width: double.infinity,
          image: sliderImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
