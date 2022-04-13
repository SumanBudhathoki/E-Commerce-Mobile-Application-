import 'package:flutter/material.dart';
import 'package:flutter_application/state/cart_state.dart';
import 'package:flutter_application/widgets/app_drawer.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

class PaymentOption extends StatefulWidget {
  static const routeName = '/payment-option';
  const PaymentOption({Key? key}) : super(key: key);

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  getAmt() {
    final cart = Provider.of<CartState>(context, listen: false).cartModel;
    int? total = cart?.total;
    return (total! * 100); // Converting to paisa
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: const Text("Select the payment option"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    KhaltiScope.of(context).pay(
                      config: PaymentConfig(
                        amount: getAmt(),
                        productIdentity: 'dells-sssssg5-g5510-2021',
                        productName: 'Product Name',
                      ),
                      preferences: [
                        PaymentPreference.khalti,
                      ],
                      onSuccess: (su) {
                        const successsnackBar = SnackBar(
                          content: Text('Payment Successful'),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(successsnackBar);
                      },
                      onFailure: (fa) {
                        const failedsnackBar = SnackBar(
                          content: Text('Payment Failed'),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(failedsnackBar);
                      },
                      onCancel: () {
                        const cancelsnackBar = SnackBar(
                          content: Text('Payment Cancelled'),
                        );
                        ScaffoldMessenger.of(context)
                            .showSnackBar(cancelsnackBar);
                      },
                    );
                  },
                  child: const Image(
                    height: 100,
                    width: 200,
                    image: AssetImage('assets/icon/khaltilogo.png'),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Image(
                    height: 100,
                    width: 200,
                    image: AssetImage('assets/icon/esewalogo.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
