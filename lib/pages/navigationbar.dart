import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> icons = [
      'assets/imgs/navigation/home.svg',
      'assets/imgs/navigation/tasjeel.svg',
      'assets/imgs/navigation/ebni.svg',
      'assets/imgs/navigation/services.svg',
      'assets/imgs/navigation/profile.svg',
    ];

    // Rounded floating bottom bar like the provided screenshot.
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
        child: Container(
          height: 74,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFE8E8E8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) => _NavItem(
              iconPath: icons[index],
              isActive: currentIndex == index,
              onTap: (){

switch (index) {
  case 0:
    Navigator.pushReplacementNamed(context, 'homepage');
    break;
  case 1:
    Navigator.pushReplacementNamed(context, 'registration');
    break;
  case 2:
    Navigator.pushReplacementNamed(context, 'mychild');
    break;
  case 3:
    Navigator.pushReplacementNamed(context, 'services');
    break;
  case 4:
    Navigator.pushReplacementNamed(context, 'myaccount');
    break;
}


              }
            )),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.iconPath,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 34,
              height: 34,
              colorFilter: isActive
                  ? const ColorFilter.mode(Color(0xFF2A3F6F), BlendMode.srcIn)
                : const ColorFilter.mode(Color(0xffC1C1C1), BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}

