import 'package:flutter/material.dart';
import 'package:flutter_application/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../state/cart_state.dart';

class OrderHistoryScreen extends StatelessWidget {
  static const routeName = '/order-history-screen';
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CartState>(context).oldOrder;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History "),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: data!.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(children: [
                  Text(data[index].email!),
                  Text(data[index].phone!),
                  Text(data[index].address!),
                  Text("Total : Rs${data[index].cart!.total}"),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
