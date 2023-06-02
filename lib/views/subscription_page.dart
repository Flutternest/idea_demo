import 'package:flutter/material.dart';
import 'package:idea_app/core/utilities/design_utility.dart';
import 'package:idea_app/core/utilities/theme/app_colors.dart';
import 'package:idea_app/widgets/gradient_text.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GradientText(
                "Subscribe",
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.primaryGreen,
                      AppColors.primaryGreenAccent,
                    ]),
                style: textTheme(context).headlineSmall?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              verticalSpaceSemiLarge,
              Text.rich(
                TextSpan(
                  text: "Skyrocket ",
                  style: textTheme(context).titleLarge?.copyWith(
                      decoration: TextDecoration.underline,
                      color: Colors.white),
                  children: [
                    TextSpan(
                      text:
                          "your business with HUNDREDS of high-converting ads!",
                      style: textTheme(context).titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                style: textTheme(context)
                    .titleLarge
                    ?.copyWith(color: Colors.white, height: 1.6),
              ),
              verticalSpaceMedium,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF1D1D1F),
                ),
                width: double.infinity,
                child: Column(
                  children: const [
                    PromotionItem(
                      text: "Library of HUNDREDS of incredible, effective ads!",
                      iconData: Icons.check,
                    ),
                    verticalSpaceRegular,
                    PromotionItem(
                      text: "100+ NEW ads added weekly",
                      iconData: Icons.check,
                    ),
                    verticalSpaceRegular,
                    PromotionItem(
                      text: "10+ Business Types",
                      iconData: Icons.check,
                    ),
                    verticalSpaceRegular,
                    PromotionItem(
                      text: "Fixed montly price for unlimited profits!",
                      iconData: Icons.check,
                    ),
                  ],
                ),
              ),
              verticalSpaceMedium,
              AppButton(
                isPrimary: true,
                child: Text.rich(
                  TextSpan(
                      text: "1 Year ",
                      children: [
                        TextSpan(
                            text: "(Only \$199.99!)",
                            style: textTheme(context)
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.normal)),
                      ],
                      style: textTheme(context)
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ),
              verticalSpaceRegular,
              AppButton(
                isPrimary: false,
                child: Text("(Only \$199.99!)",
                    style: textTheme(context)
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.normal)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.child,
    required this.isPrimary,
  });

  final Widget child;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isPrimary
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                    AppColors.primaryGreen,
                    AppColors.primaryGreenAccent,
                  ])
            : null,
        color: isPrimary ? null : Colors.grey[200],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),
          child: child),
    );
  }
}

class PromotionItem extends StatelessWidget {
  const PromotionItem({
    required this.iconData,
    required this.text,
    super.key,
  });

  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check,
          color: AppColors.primaryGreen,
        ),
        horizontalSpaceSmall,
        Expanded(
          child: Text(
            text,
            style: textTheme(context)
                .titleMedium
                ?.copyWith(color: Colors.grey[400]),
          ),
        ),
      ],
    );
  }
}
