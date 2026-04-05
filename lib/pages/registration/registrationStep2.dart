import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:madrasati_plus/helper/gap.dart';
import 'package:madrasati_plus/pages/registration/progressbar.dart';
import 'package:madrasati_plus/pages/registration/registration_header.dart';
import 'package:madrasati_plus/pages/registration/registration_nav_buttons.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';
import 'package:madrasati_plus/state/registration_draft.dart';

class Registrationstep2 extends StatefulWidget {
  const Registrationstep2({Key? key}) : super(key: key);

  @override
  State<Registrationstep2> createState() => _Registrationstep2State();
}

enum _DocPickSlot { birth, vaccine, transfer }

/// `FileType.custom` + extensions often throws on Windows/desktop; validate after pick instead.
const _kAllowedDocExtensions = {'pdf', 'jpg', 'jpeg', 'png'};

class _Registrationstep2State extends State<Registrationstep2> {
  _DocPickSlot? _pickingSlot;

  static String _fileExtension(PlatformFile f) {
    var e = (f.extension ?? '').toLowerCase();
    if (e.startsWith('.')) e = e.substring(1);
    if (e.isNotEmpty) return e;
    final name = f.name;
    final i = name.lastIndexOf('.');
    if (i == -1 || i >= name.length - 1) return '';
    return name.substring(i + 1).toLowerCase();
  }

  Future<void> _pickDocument(
    void Function(String line) applyLine,
    _DocPickSlot slot,
  ) async {
    if (_pickingSlot != null) return;
    setState(() => _pickingSlot = slot);
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
        // Avoid loading full bytes (fixes many web/desktop failures & large files).
        withData: false,
      );
      if (!mounted) return;
      if (result == null || result.files.isEmpty) return;

      final file = result.files.single;
      final ext = _fileExtension(file);
      if (!_kAllowedDocExtensions.contains(ext)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('يُسمح فقط بملفات PDF أو JPG أو PNG'),
            ),
          );
        }
        return;
      }

      applyLine(_formatFileSummary(file));
      setState(() {});
    } catch (e, st) {
      debugPrint('FilePicker: $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'تعذر اختيار الملف. حاول مرة أخرى أو جرّب ملف PDF أو صورة.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _pickingSlot = null);
    }
  }

  String _formatFileSummary(PlatformFile f) {
    final ext = _fileExtension(f);
    final typeLabel = ext == 'pdf'
        ? 'PDF'
        : ext == 'png'
            ? 'PNG'
            : (ext == 'jpg' || ext == 'jpeg')
                ? 'JPG'
                : 'ملف';
    var bytes = f.size;
    if (bytes <= 0 && f.bytes != null) {
      bytes = f.bytes!.length;
    }
    String sizePart;
    if (bytes > 0) {
      final mb = bytes / (1024 * 1024);
      sizePart =
          mb >= 1 ? '${mb.toStringAsFixed(1)} MB' : '${(bytes / 1024).toStringAsFixed(0)} KB';
    } else {
      sizePart = '';
    }
    final name = f.name;
    if (sizePart.isEmpty) return '$typeLabel — $name';
    return '$typeLabel — $sizePart — $name';
  }

  @override
  Widget build(BuildContext context) {
    final grayBorder = Color(0xffB3B3B3);
    final draft = RegistrationDraft.instance;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              RegistrationStepHeader(
                onBack: () =>
                    Navigator.pushReplacementNamed(context, 'registration'),
              ),
              const SizedBox(height: 16),
              RegistrationProgressBar(currentStep: 2, currentLineProgress: 0.25),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'مستندات الزامية',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(color: grayBorder, width: 1),
                        ),
                        child: Column(
                          children: [
                            _buildDocumentRow(
                              title: 'شهادة ميلاد الطفل',
                              savedLine: draft.birthCertificateFileLine,
                              rowPicking: _pickingSlot == _DocPickSlot.birth,
                              onPick: () => _pickDocument(
                                (line) => draft.birthCertificateFileLine = line,
                                _DocPickSlot.birth,
                              ),
                            ),
                            Divider(color: grayBorder, height: 1),
                            _buildDocumentRow(
                              title: 'سجل التطعيم',
                              savedLine: draft.vaccinationRecordFileLine,
                              rowPicking: _pickingSlot == _DocPickSlot.vaccine,
                              onPick: () => _pickDocument(
                                (line) => draft.vaccinationRecordFileLine = line,
                                _DocPickSlot.vaccine,
                              ),
                            ),
                          ],
                        ),
                      ),
                      gap(height: 24),
                      const Text(
                        'مستندات غير إلزامية',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(color: grayBorder, width: 1),
                        ),
                        child: Column(
                          children: [
                            _buildDocumentRow(
                              title: 'شهادة نقل',
                              savedLine: draft.transferCertificateFileLine,
                              rowPicking: _pickingSlot == _DocPickSlot.transfer,
                              onPick: () => _pickDocument(
                                (line) => draft.transferCertificateFileLine = line,
                                _DocPickSlot.transfer,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        "إذا كان الطفل منقولاً من مدرسة أخرى، ستحتاج إلى إرفاق شهادة نقل معتمدة من المدرسة السابقة.",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xff2A3F6F),
                          fontWeight: FontWeight.w100,
                          fontFamily: "font2",
                        ),
                      ),
                      const Divider(),
                      Text(
                        "يجب أن تكون جميع المستندات واضحة وغير منتهية الصلاحية. الصيغ المقبولة: PDF أو JPG أو PNG.",
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color(0xff888888),
                          fontWeight: FontWeight.w100,
                          fontFamily: "font2",
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 4),
                child: RegistrationNavButtons(
                  onBack: () => Navigator.pushReplacementNamed(
                    context,
                    'registration',
                  ),
                  onNext: () => Navigator.pushReplacementNamed(
                    context,
                    'findschool',
                  ),
                  nextLabel: 'التالي',
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 2, // step2 tab
        ),
      ),
    );
  }

  Widget _buildDocumentRow({
    required String title,
    required String? savedLine,
    required bool rowPicking,
    required VoidCallback onPick,
  }) {
    final line = savedLine?.trim();
    final uploaded = line != null && line.isNotEmpty;
    final busy = _pickingSlot != null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15)),
                if (uploaded) ...[
                  const SizedBox(height: 4),
                  Text(
                    line,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF5AA469),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: busy && !rowPicking ? null : onPick,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: rowPicking
                      ? const Color(0xFF233B72).withValues(alpha: 0.5)
                      : const Color(0xFF233B72),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: rowPicking
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        uploaded ? 'تغيير' : 'تحميل',
                        style: const TextStyle(fontSize: 14, color: Colors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

