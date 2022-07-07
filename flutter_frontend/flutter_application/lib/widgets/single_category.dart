import 'package:flutter/material.dart';
import 'package:flutter_application/models/category_model.dart';
import 'package:flutter_application/screens/category.dart';
import 'package:flutter_application/theme.dart';

class SingleCategory extends StatelessWidget {
  final Category category;
  final String image;
  const SingleCategory({Key? key, required this.category, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(CategoryScreen.routeName, arguments: category.id);
        },
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    // color: kBlackColor,
                    child: Image.network(
                      "http://10.0.2.2:8000$image",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  category.title!,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
