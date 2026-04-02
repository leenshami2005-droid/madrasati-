import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> icons = [
      'assets/imgs/navigation/home.svg',
      'assets/imgs/navigation/services.svg',
      'assets/imgs/navigation/tasjeel.svg',
      'assets/imgs/navigation/ebni.svg',
      'assets/imgs/navigation/profile.svg',
    ];

    final List<String> labels = [
      'الرئيسية',
      'الخدمات',
      'التسجيل',
      'إبني',
      'الملف الشخصي',
    ];

    return SafeArea(
      child: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) => _NavItem(
            iconPath: icons[index],
            label: labels[index],
            isActive: currentIndex == index,
            onTap: () => onTap(index),
          )),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 28,
              height: 28,
              colorFilter: isActive
                  ? const ColorFilter.mode(Color(0xff007ACC), BlendMode.srcIn)
                  : const ColorFilter.mode(Color(0xffC1C1C1), BlendMode.srcIn),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? const Color(0xff007ACC) : const Color(0xffC1C1C1),
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}

