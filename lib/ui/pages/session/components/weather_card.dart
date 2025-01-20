import 'package:f1_stats/domain/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherCard extends StatelessWidget {
  final List<WeatherEntity> weather;

  const WeatherCard({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            'Race Control',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Divider(),
          SizedBox(
            height: 200,
            child: Obx(
              () => ListView.builder(
                itemCount: weather.length,
                itemBuilder: (context, index) {
                  final item = weather[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text(item.date.toString())),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
