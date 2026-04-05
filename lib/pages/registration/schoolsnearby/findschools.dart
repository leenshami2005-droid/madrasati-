import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:madrasati_plus/helper/gap.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';
import 'package:madrasati_plus/pages/registration/progressbar.dart';
import 'package:madrasati_plus/pages/registration/registration_header.dart';
import 'package:madrasati_plus/pages/registration/registration_nav_buttons.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/getlonglat.dart';
import 'package:madrasati_plus/pages/registration/schoolsnearby/schoolcard.dart';
import 'package:madrasati_plus/schools/find_schools_cubit.dart';
import 'package:madrasati_plus/schools/find_schools_state.dart';
import 'package:madrasati_plus/schools/school_repository.dart';
import 'package:madrasati_plus/state/registration_draft.dart';

class findschools extends StatefulWidget {
  const findschools({super.key});

  @override
  State<findschools> createState() => _findschoolsState();
}

class _findschoolsState extends State<findschools> {
  Position? userPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    final position = await mylocation.getCurrentPosition();
    if (mounted) {
      setState(() => userPosition = position);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userPosition == null) {
      return Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                RegistrationStepHeader(
                  onBack: () =>
                      Navigator.pushReplacementNamed(context, 'step2'),
                ),
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return BlocProvider(
      create: (_) => FindSchoolsCubit(
        SchoolRepository(),
        userPosition!.latitude,
        userPosition!.longitude,
      )..start(),
      child: const _FindSchoolsScaffold(),
    );
  }
}

class _FindSchoolsScaffold extends StatelessWidget {
  const _FindSchoolsScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 12, 10, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              RegistrationStepHeader(
                onBack: () =>
                    Navigator.pushReplacementNamed(context, 'step2'),
              ),
              gap(height: 10),
              const RegistrationProgressBar(currentStep: 3),
              gap(height: 20),
              TextField(
                onChanged: (value) =>
                    context.read<FindSchoolsCubit>().updateSearchQuery(value),
                decoration: InputDecoration(
                  hintText: 'ابحث عن مدرستك ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
              gap(height: 12),
              BlocBuilder<FindSchoolsCubit, FindSchoolsState>(
                buildWhen: (a, b) =>
                    a.isLoading != b.isLoading ||
                    a.schools != b.schools ||
                    a.errorMessage != b.errorMessage ||
                    a.searchQuery != b.searchQuery,
                builder: (context, state) {
                  if (state.errorMessage != null) {
                    return Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            state.errorMessage!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }
                  if (state.isLoading && state.schools.isEmpty) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state.schools.isEmpty) {
                    final searching = state.searchQuery.trim().isNotEmpty;
                    return Expanded(
                      child: Center(
                        child: Text(
                          searching
                              ? 'لا توجد مدارس تطابق البحث.'
                              : 'لا توجد مدارس قريبة ضمن ١٠ كم من موقعك.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    
                    child: Column(
                      children: [
                        if (state.isLoading)
                          const LinearProgressIndicator(minHeight: 2),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.schools.length,
                            itemBuilder: (context, index) {
                              final school = state.schools[index];
                              final cubit = context.read<FindSchoolsCubit>();
                              final distanceKm = Geolocator.distanceBetween(
                                    cubit.userLat,
                                    cubit.userLong,
                                    school.latitude,
                                    school.longitude,
                                  ) /
                                  1000.0;
                              return Schoolslistcard(
                                school: school,
                                distanceKm: distanceKm,
                                onSelect: () {
                                  final d = RegistrationDraft.instance;
                                  d.selectedSchoolName = school.title;
                                  d.selectedSchoolAddress = school.address;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('تم اختيار: ${school.title}'),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              gap(height: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: RegistrationNavButtons(
                onBack: () =>
                    Navigator.pushReplacementNamed(context, 'step2'),
                onNext: () {
                  final d = RegistrationDraft.instance;
                  if (d.selectedSchoolName == null ||
                      d.selectedSchoolName!.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'يرجى اختيار مدرسة من القائمة',
                        ),
                      ),
                    );
                    return;
                  }
                  Navigator.pushReplacementNamed(context, 'confirm');
                },
                nextLabel: 'التالي',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 2,
        
      ),
    );
  }
}
