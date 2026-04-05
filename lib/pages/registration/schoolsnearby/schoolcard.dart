import 'package:flutter/material.dart';
import 'package:madrasati_plus/colors.dart';
import 'package:madrasati_plus/helper/gap.dart';
import 'package:madrasati_plus/models/schools.dart';

/// RTL school row card: header (logo, title, subtitle, badges), divider, footer (distance + اختر).
class Schoolslistcard extends StatelessWidget {
  const Schoolslistcard({
    super.key,
    required this.school,
    required this.distanceKm,
    this.onSelect,
  });

  final Schoolmodel school;
  final double distanceKm;
  final VoidCallback? onSelect;

  static const Color _mutedGray = Color(0xFF8E8E8E);
  static const Color _buttonBg = Color(0xFFEFEFEF);
  static const Color _cardBorder = Color(0xFFE0E0E0);

  static String _categoryArabic(String catg) {
    final c = catg.trim().toLowerCase();
    if (c == 'boys' || c == 'boy') return 'بنين';
    if (c == 'girls' || c == 'girl') return 'بنات';
    if (catg.trim().isEmpty) return '';
    return catg.trim();
  }

  static String _formatKm(double km) {
    final s = km.clamp(0, 9999).toStringAsFixed(1);
    return '${s.replaceAll('.', '،')} كم';
  }

  @override
  Widget build(BuildContext context) {
    final categoryLabel = _categoryArabic(school.catg);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Material(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: _cardBorder, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SchoolLogo(),
                    gap(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            school.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              height: 1.25,
                            ),
                          ),
                          if (school.subtitle.trim().isNotEmpty) ...[
                            gap(height: 6),
                            Text(
                              school.subtitle.trim(),
                              style: const TextStyle(
                                fontSize: 13,
                                color: _mutedGray,
                                height: 1.3,
                              ),
                            ),
                          ],
                          if (categoryLabel.isNotEmpty || school.specailneeds) ...[
                            gap(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                if (categoryLabel.isNotEmpty)
                                  _Badge(text: categoryLabel),
                                if (school.specailneeds)
                                  const _Badge(text: 'ذوي الاحتياجات الخاصة'),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8E8)),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        '${_formatKm(distanceKm)} — ${school.address}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: _mutedGray,
                          height: 1.35,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    gap(width: 12),
                    TextButton(
                      onPressed: onSelect,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: _buttonBg,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'اختر',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SchoolLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/imgs/image1.png',
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Center(
          child: Icon(Icons.school_rounded, color: blue.withValues(alpha: 0.85), size: 28),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
    );
  }
}
