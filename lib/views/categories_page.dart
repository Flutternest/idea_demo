import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_app/controllers/categories_provider.dart';
import 'package:idea_app/core/utilities/design_utility.dart';
import 'package:idea_app/core/utilities/theme/app_colors.dart';

class CategoriesPage extends ConsumerStatefulWidget {
  const CategoriesPage({super.key});

  @override
  ConsumerState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ConsumerState<CategoriesPage> {
  List<Circle> circles = [];
  final selectedBubbleIds = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    generateCircles(10);
    super.didChangeDependencies();
  }

  void generateCircles(int count) {
    if (circles.length == count) {
      return;
    }

    final random = Random();
    circles.clear();

    const double minRadius = 48.0;
    const double maxRadius = 60.0;

    const double minGap = 15.0;
    const double maxGap = 15.0;

    final screenWidth = MediaQuery.of(context).size.width;

    double left = 0.0;
    double top = 0.0;
    double maxCircleRadius = 0.0; // Track the largest radius on each line
    bool startFromLeft = true; // Flag to switch starting position

    for (int i = 0; i < count; i++) {
      final double radius =
          minRadius + random.nextDouble() * (maxRadius - minRadius);
      final double gap = minGap + random.nextDouble() * (maxGap - minGap);

      final circle = Circle(radius: radius, left: left, top: top);
      circles.add(circle);

      double circleWidth = radius * 2 + gap;

      if (startFromLeft) {
        left += circleWidth;
      } else {
        left -= circleWidth;
      }

      if (left + circleWidth > screenWidth || left < 0) {
        // Move to the next line if circle goes out of bounds
        startFromLeft = !startFromLeft; // Switch starting position
        if (i == (count - 2)) {
          startFromLeft = true;
        }
        if (startFromLeft) {
          left = 0.0;
        } else {
          left = screenWidth - circleWidth;
        }
        top += maxCircleRadius * 2 + maxGap;
        maxCircleRadius = 0.0;
      } else {
        if (radius > maxCircleRadius) {
          maxCircleRadius = radius;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.categoriesBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "What niche of products \ndo you sell?",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textBlack,
                ),
              ),
            ),
            verticalSpaceSemiLarge,
            Expanded(
              child: categoriesAsync.when(
                data: (categories) {
                  generateCircles(categories.length);

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      for (int i = 0; i < circles.length; i++)
                        Builder(
                          builder: (context) {
                            final circle = circles[i];
                            final cat = categories[i];

                            return Positioned(
                              left: circle.left,
                              top: circle.top,
                              child: Bubble(
                                icon: Icons.ac_unit,
                                label: cat.name!,
                                onTap: () {
                                  setState(() {
                                    if (selectedBubbleIds.contains(cat.id)) {
                                      selectedBubbleIds.remove(cat.id);
                                    } else {
                                      selectedBubbleIds.add(cat.id);
                                    }
                                  });
                                },
                                isSelected: selectedBubbleIds.contains(cat.id),
                                radius: circle.radius,
                              ),
                            );
                          },
                        ),
                    ],
                  );
                },
                error: (_, __) => const SizedBox.shrink(),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Circle {
  final double radius;
  final double left;
  final double top;

  Circle({
    required this.radius,
    required this.left,
    required this.top,
  });
}

class Bubble extends StatefulWidget {
  const Bubble({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isSelected,
    required this.radius,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final double radius;

  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  final gradients = [
    // Dull orange to dull orange accent
    const LinearGradient(
      colors: [
        Color(0xFFFFA577),
        Color(0xFFFF8C4B),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    // Dull pink to dull pink accent
    const LinearGradient(
      colors: [
        Color(0xFFFF88AA),
        Color(0xFFFF487A),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    // Dull purple to dull purple accent
    const LinearGradient(
      colors: [
        Color(0xFF8A549C),
        Color(0xFF943D87),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    // Dull green to dull green accent
    const LinearGradient(
      colors: [
        Color(0xFF6CD97E),
        Color(0xFF4ABD62),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    // Dull blue to dull blue accent
    const LinearGradient(
      colors: [
        Color(0xFF5C96B9),
        Color(0xFF4584A2),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ];

  late LinearGradient allotedGradient =
      gradients[Random().nextInt(gradients.length)];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.radius * 2,
        height: widget.radius * 2,
        decoration: BoxDecoration(
          color: widget.isSelected ? null : AppColors.bubbleBackground,
          gradient: widget.isSelected ? allotedGradient : null,
          shape: BoxShape.circle,
          boxShadow: widget.isSelected
              ? [
                  BoxShadow(
                    color: allotedGradient.colors[0].withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 30,
                color: widget.isSelected ? Colors.white : AppColors.textBlack,
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 12,
                  color: widget.isSelected ? Colors.white : AppColors.textBlack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
