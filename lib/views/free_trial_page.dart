import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../controllers/free_trial_provider.dart';
import '../core/utilities/design_utility.dart';
import '../widgets/gradient_text.dart';

class FreeTrialPage extends ConsumerWidget {
  const FreeTrialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final InAppPurchase iap = InAppPurchase.instance;
    final freeTrialAsync = ref.watch(freeTrialProductProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: freeTrialAsync.when(
            data: (product) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const GradientText(
                    "Try it out for FREE!",
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF00E676),
                        Color(0xFF69F0AE),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  verticalSpaceSemiLarge,
                  const Text(
                    'Supercharge Your Business!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Take your business to new heights with a vast collection of high-converting ads that will skyrocket your sales and conversions!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  verticalSpaceMedium,
                  const BulletedList([
                    'Bullet 1',
                    'Bullet 2',
                    'Bullet 3',
                  ]),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      //start free trial
                      iap.buyNonConsumable(
                          purchaseParam:
                              PurchaseParam(productDetails: product!));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00E676),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: const Text(
                      'Start 3-day FREE Trial',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  verticalSpaceRegular,
                  const Text(
                    'No payment now! Cancel anytime.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Terms of Service',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('|', style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Privacy Policy',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            error: (err, st) => Center(
              child: Text(
                'Error: $err',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

class BulletedList extends StatelessWidget {
  final List<String> items;

  const BulletedList(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF1D1D1F),
      ),
      child: Column(
        children: [
          for (var item in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.check,
                    color: Color(0xFF00E676),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
