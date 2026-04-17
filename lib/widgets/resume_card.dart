import 'package:flutter/material.dart';

class ResumeSessionCard extends StatelessWidget {
  final String streakText;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  const ResumeSessionCard({
    super.key,
    required this.streakText,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  double _cardHorizontalMargin(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return 20;
    if (width < 1024) return 32;
    return 48;
  }

  double _cardPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return 24;
    if (width < 1024) return 30;
    return 36;
  }

  double _borderRadius(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < 600 ? 32 : 40;
  }

  double _streakFont(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return 16;
    if (width < 1024) return 20;
    return 24;
  }

  double _titleFont(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return 28;
    if (width < 1024) return 34;
    return 40;
  }

  double _subtitleFont(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return 18;
    if (width < 1024) return 24;
    return 28;
  }

  double _buttonHeight(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < 600 ? 64 : 76;
  }

  double _buttonFont(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 600) return 18;
    if (width < 1024) return 22;
    return 24;
  }

  double _iconSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width < 600 ? 22 : 28;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isPhone = width < 600;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: _cardHorizontalMargin(context),
        vertical: isPhone ? 12 : 18,
      ),
      padding: EdgeInsets.all(_cardPadding(context)),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D2F0),
        borderRadius: BorderRadius.circular(_borderRadius(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: const Color(0xFF8B6B00),
                size: _iconSize(context),
              ),
              SizedBox(width: isPhone ? 10 : 14),
              Expanded(
                child: Text(
                  streakText,
                  style: TextStyle(
                    fontSize: _streakFont(context),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF655C8F),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isPhone ? 24 : 30),
          Text(
            title,
            style: TextStyle(
              fontSize: _titleFont(context),
              fontWeight: FontWeight.w800,
              height: 1.05,
              color: const Color(0xFF342C63),
            ),
          ),
          SizedBox(height: isPhone ? 10 : 14),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: _subtitleFont(context),
              fontWeight: FontWeight.w400,
              height: 1.25,
              color: const Color(0xFF6A6492),
            ),
          ),
          SizedBox(height: isPhone ? 24 : 30),
          SizedBox(
            width: double.infinity,
            height: _buttonHeight(context),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF342C63),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: _buttonFont(context),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
