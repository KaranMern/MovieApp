// test/core/responsive/responsive_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/core/responsive/responsive.dart';

/// Widget tests for [Responsive]. Verifies breakpoints (isMobile, isTablet, isDesktop),
/// typography scaling, icon sizes, spacing/padding, and grid layout values for
/// mobile (400px), tablet (700–800px), and desktop (1200px) widths.
void main() {
  group('Responsive', () {
    testWidgets('isMobile, isTablet, isDesktop flags', (tester) async {
      // Mobile: width < 600
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(400, 800)),
          child: Builder(
            builder: (context) {
              final r = Responsive(context);
              expect(r.isMobile, true);
              expect(r.isTablet, false);
              expect(r.isDesktop, false);
              return const SizedBox();
            },
          ),
        ),
      );

      // Tablet: 600 <= width < 1024
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(700, 800)),
          child: Builder(
            builder: (context) {
              final r = Responsive(context);
              expect(r.isMobile, false);
              expect(r.isTablet, true);
              expect(r.isDesktop, false);
              return const SizedBox();
            },
          ),
        ),
      );

      // Desktop: width >= 1024
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(1200, 800)),
          child: Builder(
            builder: (context) {
              final r = Responsive(context);
              expect(r.isMobile, false);
              expect(r.isTablet, false);
              expect(r.isDesktop, true);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('text sizes scale with screen width', (tester) async {
      const width = 800.0; // Tablet
      const height = 1000.0;

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(width, height)),
          child: Builder(
            builder: (context) {
              final r = Responsive(context);
              expect(r.titleSize, width * 0.033);
              expect(r.headingSize, width * 0.025);
              expect(r.subHeadingSize, width * 0.022);
              expect(r.bodySize, width * 0.02);
              expect(r.captionSize, width * 0.016);
              expect(r.appBarTitleSize, width * 0.026);
              expect(r.tabLabelSize, width * 0.02);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('icon sizes scale correctly', (tester) async {
      const width = 400.0; // Mobile
      const height = 800.0;

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(width, height)),
          child: Builder(
            builder: (context) {
              final r = Responsive(context);
              expect(r.iconSizeLarge, width * 0.065);
              expect(r.iconSizeMedium, width * 0.055);
              expect(r.iconSizeSmall, width * 0.04);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('spacing and padding values scale correctly', (tester) async {
      const width = 1200.0; // Desktop
      const height = 900.0;

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(width, height)),
          child: Builder(
            builder: (context) {
              final r = Responsive(context);
              // Vertical spacing (height-based)
              expect(r.spacingXS, height * 0.005);
              expect(r.spacingS, height * 0.01);
              expect(r.spacingM, height * 0.02);
              expect(r.spacingL, height * 0.03);
              expect(r.spacingXL, height * 0.04);

              // Horizontal padding (width-based)
              expect(r.paddingS, width * 0.02);
              expect(r.paddingM, width * 0.04);
              expect(r.paddingL, width * 0.06);

              // Card padding
              expect(r.cardPadding, const EdgeInsets.all(width * 0.015));

              // AppBar padding
              expect(r.appBarPadding, const EdgeInsets.symmetric(vertical: height * 0.015));

              // Tab padding (symmetric horizontal)
              expect(r.tabPadding.horizontal, width * 0.06 * 2);
              return const SizedBox();
            },
          ),
        ),
      );
    });

    testWidgets('grid layout values based on device', (tester) async {
      // Mobile: 2 columns, aspect 0.75, spacing 8
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(400, 800)),
          child: Builder(
            builder: (context) {
              final r = Responsive(context);
              expect(r.gridCrossAxisCount, 2);
              expect(r.gridAspectRatio, 0.75);
              expect(r.gridSpacing, 8.0);
              expect(r.gridPadding, 400 * 0.02);
              return const SizedBox();
            },
          ),
        ),
      );

      // Tablet: 3 columns, aspect 0.70, spacing 12
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(700, 800)),
          child: Builder(
            builder: (context) {
              final r = Responsive(context);
              expect(r.gridCrossAxisCount, 3);
              expect(r.gridAspectRatio, 0.70);
              expect(r.gridSpacing, 12.0);
              expect(r.gridPadding, 700 * 0.02);
              return const SizedBox();
            },
          ),
        ),
      );

      // Desktop: 4 columns, aspect 0.65, spacing 16
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(1200, 800)),
          child: Builder(
            builder: (context) {
              final r = Responsive(context);
              expect(r.gridCrossAxisCount, 4);
              expect(r.gridAspectRatio, 0.65);
              expect(r.gridSpacing, 16.0);
              expect(r.gridPadding, 1200 * 0.02);
              return const SizedBox();
            },
          ),
        ),
      );
    });
  });
}
