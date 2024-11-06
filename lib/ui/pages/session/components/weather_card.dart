import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/entities.dart';

class WeatherCard extends StatelessWidget {
  final WeatherEntity? weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Condições Meteorológicas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[700]),
                const SizedBox(width: 4),
                Text(
                  DateFormat.yMd().add_jm().format(weather!.date.toLocal()),
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.thermostat, size: 16, color: Colors.redAccent),
                const SizedBox(width: 4),
                Text(
                  'Temperatura do Ar: ${weather?.airTemperature}°C',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.thermostat_auto,
                    size: 16, color: Colors.orangeAccent),
                const SizedBox(width: 4),
                Text(
                  'Temperatura da Pista: ${weather?.trackTemperature}°C',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.water_drop,
                    size: 16, color: Colors.blueAccent),
                const SizedBox(width: 4),
                Text(
                  'Umidade: ${weather?.humidity}%',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.speed, size: 16, color: Colors.green),
                const SizedBox(width: 4),
                Text(
                  'Pressão: ${weather?.pressure} hPa',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.cloud, size: 16, color: Colors.blueGrey),
                const SizedBox(width: 4),
                Text(
                  'Precipitação: ${weather?.rainfall} mm',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.wind_power, size: 16, color: Colors.lightBlue),
                const SizedBox(width: 4),
                Text(
                  'Vento: ${weather?.windSpeed} m/s',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
