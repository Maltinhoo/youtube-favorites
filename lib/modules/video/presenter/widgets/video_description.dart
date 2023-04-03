import 'package:flutter/material.dart';

import '../../domain/entities/video_entity.dart';

class VideoDescription extends StatelessWidget {
  const VideoDescription({
    super.key,
    required this.video,
  });

  final VideoEntity video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 5),
          Text(
            video.title,
            style: const TextStyle(
              fontSize: 16,
            ),
            maxLines: 2,
          ),
          const Divider(color: Colors.black87, height: 20),
          Row(
            children: [
              const Icon(
                Icons.person,
                size: 26,
                color: Colors.black87,
              ),
              const SizedBox(width: 10),
              Text(
                video.channel,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
