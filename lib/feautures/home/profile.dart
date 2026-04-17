import 'package:flutter/material.dart';
import 'package:study_pro/feautures/auth/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  double pageSpace(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 20;
    if (width < 600) return 28;
    return 40;
  }

  double titleSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 18;
    if (width < 600) return 22;
    return 28;
  }

  double bodySize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 13;
    if (width < 600) return 15;
    return 18;
  }

  double statNumberSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 24;
    if (width < 600) return 30;
    return 36;
  }

  double headerHeight(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 160;
    if (width < 600) return 190;
    return 230;
  }

  double avatarSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 110;
    if (width < 600) return 130;
    return 150;
  }

  double cameraSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 32;
    if (width < 600) return 36;
    return 42;
  }

  @override
  Widget build(BuildContext context) {
    final space = pageSpace(context);
    final avatar = avatarSize(context);
    final header = headerHeight(context);
    final camera = cameraSize(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5DBEF),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            color: const Color(0xFF842CD3),
            fontSize: titleSize(context),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(space),
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: header,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF5B63F6), Color(0xFF8A3FF0)],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -(avatar / 2.4),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: avatar,
                                height: avatar,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/im1.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x14000000),
                                      blurRadius: 14,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 2,
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(999),
                                  child: Container(
                                    width: camera,
                                    height: camera,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF5B63F6),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                      size: camera * 0.45,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: avatar * 0.55),
                    Text(
                      'Eleanor Vance',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleSize(context) + 6,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF342C63),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'eleanor.vance@example.com',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: bodySize(context),
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF7E739B),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFF5B63F6),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        icon: const Icon(Icons.edit_outlined, size: 18),
                        label: Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: bodySize(context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(space),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0EAF7),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LEARNING MOMENTUM',
                            style: TextStyle(
                              fontSize: bodySize(context) - 1,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF8A80A8),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _StatItem(
                                  number: '1',
                                  label: 'DAY\nSTREAK',
                                  numberColor: const Color(0xFF4E56F0),
                                  numberSize: statNumberSize(context),
                                  labelSize: bodySize(context) - 1,
                                ),
                              ),
                              Expanded(
                                child: _StatItem(
                                  number: '3',
                                  label: 'SAVED\nSESSIONS',
                                  numberColor: const Color(0xFF8A3FF0),
                                  numberSize: statNumberSize(context),
                                  labelSize: bodySize(context) - 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn.instance.signOut();

                  if (!context.mounted) return;

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthPage()),
                    (route) => false,
                  );
                },
                child: Text(
                  ' LOGOUT ',
                  style: TextStyle(
                    fontSize: titleSize(context) + 6,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF342C63),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;
  final Color numberColor;
  final double numberSize;
  final double labelSize;

  const _StatItem({
    required this.number,
    required this.label,
    required this.numberColor,
    required this.numberSize,
    required this.labelSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: numberSize,
            fontWeight: FontWeight.w700,
            color: numberColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: labelSize,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF8A80A8),
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
