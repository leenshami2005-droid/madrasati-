import 'package:flutter/material.dart';

class RegistrationProgressBar extends StatelessWidget {
  final int currentStep; // 1..5
  final double currentLineProgress; // 0.0 to 1.0
  final List<String> steps;

  const RegistrationProgressBar({
    super.key,
    required this.currentStep,
    this.currentLineProgress = 0.25,
    this.steps = const [
      'بيانات الطفل',
      'المستندات',
      'المدرسة',
      'المراجعة',
      'التأكيد',
    ],
  });

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF233B72);
    const lightGray = Color(0xFFD9D9D9);
    const borderGray = Color(0xFFD0D0D0);
    const inactiveText = Color(0xFFBDBDBD);

    const double circleSize = 40;
    const double lineHeight = 3;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(steps.length * 2 - 1, (index) {
                  // ===== Circles =====
                  if (index.isEven) {
                    final stepIndex = index ~/ 2;
                    final isCompleted = stepIndex < currentStep - 1;
                    final isCurrent = stepIndex == currentStep - 1;
                    final isActive = isCompleted || isCurrent;

                    return SizedBox(
                      width: circleSize,
                      height: circleSize,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive ? blue : Colors.white,
                          border: Border.all(
                            color: isActive ? blue : borderGray,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: isCompleted
                              ? const Icon(
                                  Icons.check_rounded,
                                  color: Colors.white,
                                  size: 22,
                                )
                              : Text(
                                  '${stepIndex + 1}',
                                  style: TextStyle(
                                    color: isCurrent ? Colors.white : inactiveText,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'GraphikArabic',
                                  ),
                                ),
                        ),
                      ),
                    );
                  }

                  // ===== Connector lines =====
                  final lineIndex = index ~/ 2;

                  // fully completed lines before current step
                  final isFullLine = lineIndex < currentStep - 1;

                  // partial line AFTER current step
                  final isPartialLine = lineIndex == currentStep - 1;

                  return Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: lineHeight,
                        width: double.infinity,
                        child: isPartialLine
                            ? LayoutBuilder(
                                builder: (context, constraints) {
                                  final totalWidth = constraints.maxWidth;
                                  final blueWidth = totalWidth *
                                      currentLineProgress.clamp(0.0, 1.0);

                                  return Stack(
                                    children: [
                                      Container(
                                        width: totalWidth,
                                        height: lineHeight,
                                        color: lightGray,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight, // RTL
                                        child: Container(
                                          width: blueWidth,
                                          height: lineHeight,
                                          color: blue,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : Container(
                                color: isFullLine ? blue : lightGray,
                              ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(steps.length, (i) {
                final isCompleted = i < currentStep - 1;
                final isCurrent = i == currentStep - 1;
                final isActive = isCompleted || isCurrent;

                return Expanded(
                  child: Text(
                    steps[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: isActive ? blue : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'GraphikArabic',
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}