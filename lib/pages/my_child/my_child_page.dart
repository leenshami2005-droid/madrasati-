import 'package:flutter/material.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';

/// "ابني" — teacher notes & student snapshot (layout aligned with design reference).
class MyChildPage extends StatefulWidget {
  const MyChildPage({super.key});

  @override
  State<MyChildPage> createState() => _MyChildPageState();
}

class _MyChildPageState extends State<MyChildPage> {
  int _tabIndex = 0; // 0 = ملاحظات المعلم, 1 = الجدول الدراسي
  String _guardianName = 'خليل العلي';

  static const _navy = Color(0xFF233B72);
  static const _navyDeep = Color(0xFF1A2D52);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F9),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopBar(
                guardianName: _guardianName,
                onGuardianChanged: (v) => setState(() => _guardianName = v ?? _guardianName),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _StudentHeroCard(navy: _navy, navyDeep: _navyDeep),
                      const SizedBox(height: 16),
                      _SegmentedTabs(
                        selectedIndex: _tabIndex,
                        onChanged: (i) => setState(() => _tabIndex = i),
                      ),
                      const SizedBox(height: 18),
                      if (_tabIndex == 0) ...[
                        _SectionTitle(title: 'هذا الأسبوع'),
                        const SizedBox(height: 10),
                        _TeacherNoteCard(
                          teacherName: 'أ. رنا العمري',
                          teacherRole: 'معلمة اللغة الإنجليزية',
                          timeLabel: 'اليوم، 10:30',
                          body:
                              'أهلاً ولي الأمر، أود إعلامكم بأن الطالب شارك بفعالية في حصة المحادثة اليوم، ويُنصح بمراجعة مفردات الوحدة الثانية في المنزل.',
                          chip: _NoteChipStyle.alert,
                        ),
                        const SizedBox(height: 14),
                        _SectionTitle(title: 'الأسبوع الماضي'),
                        const SizedBox(height: 10),
                        _TeacherNoteCard(
                          teacherName: 'أ. محمد الدوسري',
                          teacherRole: 'معلم الرياضيات',
                          timeLabel: 'الأحد، 08:15',
                          body:
                              'أداء ممتاز في اختبار الوحدة، والطالب يظهر تطوراً ملحوظاً في حل المسائل الرياضية.',
                          chip: _NoteChipStyle.positive,
                        ),
                        const SizedBox(height: 12),
                        _TeacherNoteCard(
                          teacherName: 'أ. لينا الصالح',
                          teacherRole: 'معلمة التربية الفنية',
                          timeLabel: 'الخميس، 11:00',
                          body:
                              'تم تسليم مشروع الرسم في الموعد المحدد، شكراً للمتابعة.',
                          chip: _NoteChipStyle.neutral,
                        ),
                      ] else
                        _SchedulePlaceholder(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 3,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, 'homepage');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, 'findschool');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, 'registration');
                break;
              case 3:
                break;
              case 4:
                Navigator.pushReplacementNamed(context, 'welcome');
                break;
            }
          },
        ),
      ),
    );
  }
}

// ——— Top bar ———

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.guardianName,
    required this.onGuardianChanged,
  });

  final String guardianName;
  final ValueChanged<String?> onGuardianChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 12),
      child: Row(
        children: [
          const Text(
            'أبني',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111111),
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: guardianName,
                isDense: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF222222),
                ),
                items: const [
                  DropdownMenuItem(value: 'خليل العلي', child: Text('خليل العلي')),
                  DropdownMenuItem(value: 'ولي أمر آخر', child: Text('ولي أمر آخر')),
                ],
                onChanged: onGuardianChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ——— Student card ———

class _StudentHeroCard extends StatelessWidget {
  const _StudentHeroCard({
    required this.navy,
    required this.navyDeep,
  });

  final Color navy;
  final Color navyDeep;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [navy, navyDeep],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_rounded,
                  size: 30,
                  color: Color(0xFF233B72),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'خليل محمد العلي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'مدرسة الأمير الحسن الأساسية',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.88),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.white.withValues(alpha: 0.28),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _InfoColumn(
                  items: const [
                    _KV('الصف والشعبة', '١ الأول — شعبة أ'),
                    _KV('المعلم الأساسي', 'أ. سامي الخوالدة'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InfoColumn(
                  items: const [
                    _KV('رقم الطالب', 'STU-20248731'),
                    _KV('العام الدراسي', '2024-2025'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _KV {
  const _KV(this.label, this.value);
  final String label;
  final String value;
}

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({required this.items});

  final List<_KV> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          Text(
            items[i].label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.72),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            items[i].value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              height: 1.25,
            ),
          ),
        ],
      ],
    );
  }
}

// ——— Tabs ———

class _SegmentedTabs extends StatelessWidget {
  const _SegmentedTabs({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8EC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              label: 'الجدول الدراسي',
              selected: selectedIndex == 1,
              onTap: () => onChanged(1),
            ),
          ),
          Expanded(
            child: _TabButton(
              label: 'ملاحظات المعلم',
              selected: selectedIndex == 0,
              onTap: () => onChanged(0),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(11),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.07),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
              color: selected ? const Color(0xFF1A1A1A) : const Color(0xFF6B6B6B),
            ),
          ),
        ),
      ),
    );
  }
}

// ——— Notes list ———

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color(0xFF333333),
        ),
      ),
    );
  }
}

enum _NoteChipStyle { alert, positive, neutral }

class _TeacherNoteCard extends StatelessWidget {
  const _TeacherNoteCard({
    required this.teacherName,
    required this.teacherRole,
    required this.timeLabel,
    required this.body,
    required this.chip,
  });

  final String teacherName;
  final String teacherRole;
  final String timeLabel;
  final String body;
  final _NoteChipStyle chip;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE4E4E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacherName,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1C1C1C),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      teacherRole,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                timeLabel,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            body,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              height: 1.55,
              color: Color(0xFF2C2C2C),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: _StatusChip(style: chip),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.style});

  final _NoteChipStyle style;

  @override
  Widget build(BuildContext context) {
    late String label;
    late Color bg;
    late Color fg;
    switch (style) {
      case _NoteChipStyle.alert:
        label = 'تنبيه';
        bg = const Color(0xFFFFE8D6);
        fg = const Color(0xFFC65D00);
      case _NoteChipStyle.positive:
        label = 'إيجابية';
        bg = const Color(0xFFE3F4E8);
        fg = const Color(0xFF1B6B3A);
      case _NoteChipStyle.neutral:
        label = 'ملاحظة';
        bg = const Color(0xFFF0F0F3);
        fg = const Color(0xFF5C5C66);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}

class _SchedulePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      alignment: Alignment.center,
      child: Text(
        'سيتم عرض الجدول الدراسي هنا',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
