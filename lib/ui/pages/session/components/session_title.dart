import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/entities.dart';

class SessionTitle extends StatelessWidget {
  final SessionEntity? session;

  const SessionTitle({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            session?.circuitShortName ?? 'Unknown Circuit',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${session?.location}, ${session?.countryName}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                DateFormat.yMEd().format(session?.dateStart ?? DateTime.now()),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const Text(' '),
              Text(
                DateFormat.jm().format(session?.dateStart ?? DateTime.now()),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const Text(' - '),
              Text(
                DateFormat.jm().format(session?.dateEnd ?? DateTime.now()),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.timelapse,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'GMT Offset: ${session?.gmtOffset}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.flag,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'Sessão: ${session?.sessionName}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              const Spacer(),
              const Icon(
                Icons.sports_motorsports,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'Tipo: ${session?.sessionType}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
