import 'package:flutter/material.dart';
import 'package:study_pro/widgets/library_item_card.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});
  double spacing(BuildContext context, double value) {
    final width = MediaQuery.sizeOf(context).width;
    return value * (width / 375); // 375 = base design width
  }

  double space(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 420) {
      return 20;
    } else if (width < 600) {
      return 40;
    } else {
      return 40;
    }
  }

  double normalText(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 420) {
      return 14;
    } else if (width < 600) {
      return 17;
    } else {
      return 22;
    }
  }

  double largeText(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 420) {
      return 36;
    } else if (width < 600) {
      return 44;
    } else {
      return 50;
    }
  }

  double bigText(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 420) {
      return 26;
    } else if (width < 600) {
      return 30;
    } else {
      return 36;
    }
  }

  double smallBigText(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width < 420) {
      return 18;
    } else if (width < 600) {
      return 24;
    } else {
      return 28;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 229, 219, 239),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.maxWidth < 60 ? 35.0 : 60.0;

              return SizedBox(
                width: size,
                height: size,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/im1.jpg'),
                      fit: BoxFit.cover, // 👈 important
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        title: Builder(
          builder: (context) {
            final width = MediaQuery.sizeOf(context).width;

            double fontSize;
            if (width < 400) {
              fontSize = 18;
            } else if (width < 600) {
              fontSize = 20;
            } else {
              fontSize = 24;
            }

            return Text(
              'Scholar Sanctuary',
              style: TextStyle(
                color: const Color(0xFF842CD3),
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(space(context)),
                child: Text(
                  'My Library',
                  style: TextStyle(
                    fontSize: largeText(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(left: space(context)),
                child: Text(
                  'Your intellectual archive. Everything you ve curated, summarized, and mastered, all in one place.',
                  style: TextStyle(
                    fontSize: normalText(context),
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: space(context),
                  right: space(context),
                  top: 20,
                ),
                child: Container(
                  height: MediaQuery.sizeOf(context).width < 420 ? 52 : 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color.fromARGB(255, 220, 214, 228),
                      width: 1.2,
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search your library',
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 140, 132, 156),
                        fontSize: normalText(context),
                        fontWeight: FontWeight.w300,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: const Color(0xFF842CD3),
                        size: MediaQuery.sizeOf(context).width < 420 ? 22 : 26,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: MediaQuery.sizeOf(context).width < 420
                            ? 14
                            : 18,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: normalText(context),
                      color: const Color.fromARGB(255, 57, 29, 67),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(space(context)),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.sizeOf(context).width < 600
                        ? 2
                        : 3,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: MediaQuery.sizeOf(context).width < 420
                        ? 0.78
                        : 0.9,
                  ),
                  itemBuilder: (context, index) {
                    return LibraryItemCard(
                      cardType: index % 3 == 0
                          ? 'summary'
                          : index % 3 == 1
                          ? 'quiz'
                          : 'flashcards',
                      title: 'Advanced Macroeconomics',
                      summary:
                          'Chapter 4 concepts simplified into quick revision material for faster recall.',
                      dateCreated: 'Created Apr 12, 2026',
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
