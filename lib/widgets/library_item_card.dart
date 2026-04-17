import 'package:flutter/material.dart';

class LibraryItemCard extends StatelessWidget {
  final String cardType; // 'summary', 'quiz', 'flashcards'
  final String title;
  final String summary;
  final String dateCreated;
  final VoidCallback? onTap;

  const LibraryItemCard({
    super.key,
    required this.cardType,
    required this.title,
    required this.summary,
    required this.dateCreated,
    this.onTap,
  });

  IconData _cardIcon() {
    switch (cardType.toLowerCase()) {
      case 'summary':
        return Icons.subject_outlined;
      case 'quiz':
        return Icons.quiz_outlined;
      case 'flashcards':
        return Icons.style_outlined;
      default:
        return Icons.description_outlined;
    }
  }

  Color _iconBgColor() {
    switch (cardType.toLowerCase()) {
      case 'summary':
        return const Color(0xFFEDE7F6);
      case 'quiz':
        return const Color(0xFFFFF3E0);
      case 'flashcards':
        return const Color(0xFFE8F5E9);
      default:
        return const Color(0xFFF3E5F5);
    }
  }

  Color _iconColor() {
    switch (cardType.toLowerCase()) {
      case 'summary':
        return const Color(0xFF842CD3);
      case 'quiz':
        return const Color(0xFFEF6C00);
      case 'flashcards':
        return const Color(0xFF2E7D32);
      default:
        return const Color(0xFF842CD3);
    }
  }

  double _titleSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 16;
    if (width < 600) return 18;
    return 20;
  }

  double _bodySize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 12;
    if (width < 600) return 13;
    return 15;
  }

  double _dateSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 11;
    if (width < 600) return 12;
    return 13;
  }

  double _iconBoxSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 44;
    if (width < 600) return 52;
    return 60;
  }

  double _iconSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 22;
    if (width < 600) return 24;
    return 28;
  }

  double _padding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 420) return 14;
    if (width < 600) return 16;
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    final iconBoxSize = _iconBoxSize(context);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(_padding(context)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color.fromARGB(255, 221, 217, 227),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: iconBoxSize,
              height: iconBoxSize,
              decoration: BoxDecoration(
                color: _iconBgColor(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  _cardIcon(),
                  color: _iconColor(),
                  size: _iconSize(context),
                ),
              ),
            ),
            SizedBox(height: _padding(context)),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: _titleSize(context),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2F2340),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              summary,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: _bodySize(context),
                fontWeight: FontWeight.w300,
                color: const Color(0xFF6B6277),
                height: 1.4,
              ),
            ),
            const Spacer(),
            const SizedBox(height: 12),
            Text(
              dateCreated,
              style: TextStyle(
                fontSize: _dateSize(context),
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9A95A8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
