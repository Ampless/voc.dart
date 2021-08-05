library voc;

import 'dart:convert';

import 'package:schttp/schttp.dart';

class Conference {
  String? acronym,
      aspectRatio,
      updatedAt,
      title,
      scheduleUrl,
      slug,
      eventLastReleasedAt,
      link,
      description,
      webgenLocation,
      logoUrl,
      imagesUrl,
      recordingsUrl,
      url;

  Conference({
    this.acronym,
    this.aspectRatio,
    this.updatedAt,
    this.title,
    this.scheduleUrl,
    this.slug,
    this.eventLastReleasedAt,
    this.link,
    this.description,
    this.webgenLocation,
    this.logoUrl,
    this.imagesUrl,
    this.recordingsUrl,
    this.url,
  });

  @override
  String toString() => '{"$title" ("$acronym"): "$slug" at "$url"}';

  static Future<List<Conference>> getAllConferences(
          [ScHttpClient? http]) async =>
      jsonDecode(await (http ?? ScHttpClient()).get(
              'https://api.media.ccc.de/public/conferences'))['conferences']
          .map<Conference>((c) => Conference(
                acronym: c['acronym'],
                aspectRatio: c['aspect_ratio'],
                updatedAt: c['updated_at'],
                title: c['title'],
                scheduleUrl: c['schedule_url'],
                slug: c['slug'],
                eventLastReleasedAt: c['event_last_released_at'],
                link: c['link'],
                description: c['description'],
                webgenLocation: c['webgen_location'],
                logoUrl: c['logo_url'],
                imagesUrl: c['images_url'],
                recordingsUrl: c['recordings_url'],
                url: c['url'],
              ))
          .toList();
}
