import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:madrasati_plus/pages/navigationbar.dart';
import 'package:madrasati_plus/colors.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  bool absenceNotification = false;
  bool registrationNotification = true;
  bool teacherNotesNotification = false;
  bool generalNotification = true;

  String userName = "جار التحميل...";
  String userId = "جار التحميل...";
  String phoneNumber = "جار التحميل...";

  @override
  void initState() {
    super.initState();
    _fetchUserData(FirebaseAuth.instance.currentUser);
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (mounted) {
        _fetchUserData(user);
      }
    });
  }

  Future<void> _fetchUserData(User? user) async {
    if (user == null) {
      if (mounted) {
        setState(() {
          userName = "غير مسجل دخول";
          userId = "لا يوجد";
        });
      }
      return;
    }

    if (mounted) {
      setState(() {
        userId = "جارِ التحميل...";
        userName = (user.displayName != null && user.displayName!.isNotEmpty) 
            ? user.displayName! 
            : "جاري جلب الاسم..."; 
      });
    }

    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final data = userDoc.data();
        if (data != null && mounted) {
          final id = data['idNumber'];
          if (id != null && id.toString().trim().isNotEmpty) {
            setState(() {
              userId = id.toString().trim();
            });
          }
          final phone = data['phoneNumber'];
          if (phone != null && phone.toString().trim().isNotEmpty) {
            setState(() {
              phoneNumber = phone.toString().trim();
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            userId = user.email ?? "لا يوجد بريد/رقم وطني";
          });
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          userId = user.email ?? "لا يوجد بريد/رقم وطني";
        });
      }
    }
    
    // Attempt to fetch name from students collection if displayName is empty/null/default
    if (user.displayName == null || user.displayName!.isEmpty) {
      try {
          final email = user.email;
          if (email != null && email.isNotEmpty) {
            final snapshot = await FirebaseFirestore.instance
                .collection('students')
                .where('parentid', isEqualTo: email)
                .limit(1)
                .get();

            if (snapshot.docs.isNotEmpty) {
              final data = snapshot.docs.first.data();
              final pn =
                  data['parentName'] ??
                  data['guardianName'] ??
                  data['parent_name'];
              if (pn != null && pn.toString().trim().isNotEmpty && mounted) {
                setState(() => userName = pn.toString().trim());
                return;
              }
            }

            final snapshot2 = await FirebaseFirestore.instance
                .collection('students')
                .where('parentId', isEqualTo: email)
                .limit(1)
                .get();
            if (snapshot2.docs.isNotEmpty) {
              final data = snapshot2.docs.first.data();
              final pn =
                  data['parentName'] ??
                  data['guardianName'] ??
                  data['parent_name'];
              if (pn != null && pn.toString().trim().isNotEmpty && mounted) {
                setState(() => userName = pn.toString().trim());
              }
            }
            
            // If we are here, it means no document matched the string email.
            // Some databases store parentId as an integer instead of string.
            final idAsInt = int.tryParse(email);
            if (idAsInt != null) {
              final snapshot3 = await FirebaseFirestore.instance
                  .collection('students')
                  .where('parentid', isEqualTo: idAsInt)
                  .limit(1)
                  .get();
                  
              if (snapshot3.docs.isNotEmpty) {
                final data = snapshot3.docs.first.data();
                final pn = data['parentName'] ?? data['guardianName'] ?? data['parent_name'];
                if (pn != null && pn.toString().trim().isNotEmpty && mounted) {
                  setState(() => userName = pn.toString().trim());
                  return;
                }
              }

              final snapshot4 = await FirebaseFirestore.instance
                  .collection('students')
                  .where('parentId', isEqualTo: idAsInt)
                  .limit(1)
                  .get();
                  
              if (snapshot4.docs.isNotEmpty) {
                final data = snapshot4.docs.first.data();
                final pn = data['parentName'] ?? data['guardianName'] ?? data['parent_name'];
                if (pn != null && pn.toString().trim().isNotEmpty && mounted) {
                  setState(() => userName = pn.toString().trim());
                  return;
                }
              }
            }
            
            // If all queries failed to find a parentName
            if (mounted) {
              setState(() {
                if (userName == "جاري جلب الاسم...") {
                  userName = "مستخدم"; // Fallback if still not found
                }
              });
            }
          }
        } catch (e) {
          if (mounted) {
            setState(() {
              if (userName == "جاري جلب الاسم...") {
                userName = "مستخدم"; // fallback on error
              }
            });
          }
          print("Error fetching user data: $e");
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    "حسابي",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Account Info Section
                  const Text(
                    "معلومات الحساب",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow("الاسم", userName),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade400,
                          thickness: 0.5,
                        ),
                        _buildInfoRow("الرقم الوطني", userId),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade400,
                          thickness: 0.5,
                        ),
                        _buildInfoRow("رقم الجوال", phoneNumber),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade400,
                          thickness: 0.5,
                        ),
                        _buildInfoRow("البريد الالكتروني", "ahmed@gmail.com"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Notifications Section
                  const Text(
                    "الاشعارات",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildSwitchRow(
                          "غيابات الطالب",
                          absenceNotification,
                          (val) => setState(() => absenceNotification = val),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade400,
                          thickness: 0.5,
                        ),
                        _buildSwitchRow(
                          "تحديث طلب التسجيل",
                          registrationNotification,
                          (val) =>
                              setState(() => registrationNotification = val),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade400,
                          thickness: 0.5,
                        ),
                        _buildSwitchRow(
                          "ملاحظات المعلم",
                          teacherNotesNotification,
                          (val) =>
                              setState(() => teacherNotesNotification = val),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey.shade400,
                          thickness: 0.5,
                        ),
                        _buildSwitchRow(
                          "اشعارات عامة",
                          generalNotification,
                          (val) => setState(() => generalNotification = val),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // General Section
                  const Text(
                    "عام",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _buildGeneralRow("اللغة", "العربية"),
                  ),
                  const SizedBox(height: 40),

                  // Logout Button
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance.signOut().catchError((_) {});
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'login',
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "تسجيل الخروج",
                          style: TextStyle(
                            color: Color(0xFFE05B2A),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
            textDirection: TextDirection.ltr,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Transform.scale(
            scale: 0.9,
            child: CupertinoSwitch(
              value: value,
              activeColor: blue,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.arrow_back_ios,
                size: 14,
                color: Color(0xff2A3F6F), // blue
              ),
              const SizedBox(width: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff2A3F6F), // blue
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
