import 'package:flutter/material.dart';
import 'package:flutter_application/models/category_model.dart';
import 'package:flutter_application/screens/category.dart';

class SingleCategory extends StatelessWidget {
  final Category category;
  const SingleCategory({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(CategoryScreen.routeName, arguments: category.id);
        },
        child: Card(
          color: Colors.orange,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(category.title!),
          ),
        ),
      ),
    );
  }
}
