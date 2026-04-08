import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:madrasati_plus/colors.dart';
import 'package:madrasati_plus/helper/gap.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  static const List<({String asset, String label})> _documentServices = [
    (asset: 'assets/imgs/services/pic1.svg', label: 'بطاقة طالب بديلة'),
    (asset: 'assets/imgs/services/pic2.svg', label: 'السجل الدراسي'),
    (asset: 'assets/imgs/services/pic3.svg', label: 'كشف العلامات'),
    (asset: 'assets/imgs/services/pic4.svg', label: 'طلب شهادة'),
    (asset: 'assets/imgs/services/pic5.svg', label: 'شهادة سلوك وأخلاق'),
    (asset: 'assets/imgs/services/pic6.svg', label: 'شهادة قيد'),
  ];

  static const List<({String asset, String label})> _procedureServices = [
    (asset: 'assets/imgs/services/Group 21.svg', label: 'تبرير غياب'),
    (asset: 'assets/imgs/services/Group 22.svg', label: 'طلب نقل'),
    (asset: 'assets/imgs/services/Group 23.svg', label: 'طلب اجتماع مع المعلم'),
    (asset: 'assets/imgs/services/Group 24.svg', label: 'رفع مستند'),
    (asset: 'assets/imgs/services/Group.svg', label: 'الإبلاغ عن مشكلة'),
    (asset: 'assets/imgs/services/Vector (7).svg', label: 'تحديث بيانات التواصل'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'الخدمات',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                gap(height: 12),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: grayBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: grayBorder),
                    ),
                    hintText: 'ابحث في الخدمات...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  ),
                ),
                gap(height: 20),
                const Text(
                  'طلب وثائق',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'GraphikArabic',
                  ),
                ),
                gap(height: 12),
                _ServiceGrid(items: _documentServices),
                gap(height: 24),
                const Text(
                  'إجراءات',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'GraphikArabic',
                  ),
                ),
                gap(height: 12),
                _ServiceGrid(items: _procedureServices),
                gap(height: 100), // space above floating bottom nav
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 3, 
      ),
    );
  }
}

class _ServiceGrid extends StatelessWidget {
  const _ServiceGrid({required this.items});

  final List<({String asset, String label})> items;

  @override
  Widget build(BuildContext context) {
    assert(items.length == 6);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < 3; i++)
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: i == 0 ? 0 : 6,
                  ),
                  child: mycontainer(
                    pic: items[i].asset,
                    text: items[i].label,
                  ),
                ),
              ),
          ],
        ),
        gap(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 3; i < 6; i++)
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: i == 3 ? 0 : 6,
                  ),
                  child: mycontainer(
                    pic: items[i].asset,
                    text: items[i].label,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class mycontainer extends StatelessWidget {
  const mycontainer({
    super.key,
    required this.pic,
    required this.text,
  });

  final String pic;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 88),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            pic,
            height: 31,
            width: 24,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
          gap(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  
  }
}
