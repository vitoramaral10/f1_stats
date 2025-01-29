import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const int _startYear = 2023;

  static const Map<int, String> _seasonImages = {
    2023:
        'https://media.contentapi.ea.com/content/dam/ea/f1/f1-23/common/featured-image/f123-featured-image-16x9.jpg.adapt.crop191x100.1200w.jpg',
    2024:
        'https://media.contentapi.ea.com/content/dam/ea/f1/f1-24/common/f124-dlx-ed-16x9.jpg.adapt.crop16x9.575p.jpg',
    2025:
        'http://autoracing.com.br/wp-content/uploads/2025/01/f1-ham-leclerc-apres-ferrari-2025.jpg',
  };

  String _getSeasonImage(int year) {
    return _seasonImages[year] ??
        'https://cdn-1.motorsport.com/images/amp/Y99JQRbY/s1000/formula-1-red-bull-launch-2023-2.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Scaffold(
      appBar: AppBar(
        title: const Text('F1 Stats',
            style: TextStyle(fontWeight: FontWeight.bold)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.transparent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://sm.ign.com/t/ign_pt/screenshot/default/f1-2019-announcement-teaser-uk00-00-10-27still004_p5gn.2060.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(16),
              child: Text(
                'Escolha uma Temporada',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5, // Proporção mais larga que alta
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: currentYear - _startYear + 1,
              itemBuilder: (context, index) {
                final year = _startYear + index;
                return Hero(
                  tag: 'season_$year',
                  child: Material(
                    child: InkWell(
                      onTap: () => Get.toNamed('${Routes.meetings}/$year'),
                      child: Card(
                        elevation: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(_getSeasonImage(year)),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.7),
                                  Colors.black.withOpacity(0.3),
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  year.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(1, 1),
                                        blurRadius: 3,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Temporada F1',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(1, 1),
                                        blurRadius: 3,
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
