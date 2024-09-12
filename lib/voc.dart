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

  Conference.fromJson(Map c)
      : acronym = c['acronym'],
        aspectRatio = c['aspect_ratio'],
        updatedAt = c['updated_at'],
        title = c['title'],
        scheduleUrl = c['schedule_url'],
        slug = c['slug'],
        eventLastReleasedAt = c['event_last_released_at'],
        link = c['link'],
        description = c['description'],
        webgenLocation = c['webgen_location'],
        logoUrl = c['logo_url'],
        imagesUrl = c['images_url'],
        recordingsUrl = c['recordings_url'],
        url = c['url'];

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
          .map<Conference>(Conference.fromJson)
          .toList();
}

class RelatedEvent {
  int id;
  String guid;
  int weight;

  RelatedEvent.fromJson(Map e)
      : id = e['id'],
        guid = e['guid'],
        weight = e['weight'];

  RelatedEvent({required this.id, required this.guid, required this.weight});

  Future<Event> download() => Event.download(id);
}

class Event {
  String? guid,
      title,
      subtitle,
      slug,
      link,
      description,
      originalLanguage,
      date,
      releaseDate,
      updatedAt,
      thumbUrl,
      posterUrl,
      timelineUrl,
      thumbnailsUrl,
      frontendLink,
      url,
      conferenceTitle,
      conferenceUrl;
  List<String> persons, tags;
  int viewCount, length, duration;
  bool promoted;
  List<RelatedEvent> related;
  //TODO: recordings

  Event.fromJson(Map e)
      : guid = e['guid'],
        title = e['title'],
        subtitle = e['subtitle'],
        slug = e['slug'],
        link = e['link'],
        description = e['description'],
        originalLanguage = e['original_language'],
        date = e['date'],
        releaseDate = e['release_date'],
        updatedAt = e['updated_at'],
        thumbUrl = e['thumb_url'],
        posterUrl = e['poster_url'],
        timelineUrl = e['timeline_url'],
        thumbnailsUrl = e['thumbnails_url'],
        frontendLink = e['frontend_link'],
        url = e['url'],
        conferenceTitle = e['conference_title'],
        conferenceUrl = e['conference_url'],
        persons = List<String>.from(e['persons']),
        tags = List<String>.from(e['tags']),
        viewCount = e['view_count'],
        length = e['length'],
        duration = e['duration'],
        promoted = e['promoted'],
        related = e['related']
            .map<RelatedEvent>((e) => RelatedEvent.fromJson(e))
            .toList();

  Event({
    this.guid,
    this.title,
    this.subtitle,
    this.slug,
    this.link,
    this.description,
    this.originalLanguage,
    this.date,
    this.releaseDate,
    this.updatedAt,
    this.thumbUrl,
    this.posterUrl,
    this.timelineUrl,
    this.thumbnailsUrl,
    this.frontendLink,
    this.url,
    this.conferenceTitle,
    this.conferenceUrl,
    required this.persons,
    required this.tags,
    required this.viewCount,
    required this.length,
    required this.duration,
    required this.promoted,
    required this.related,
  });

  static Future<Iterable<Event>> getAllEvents([ScHttpClient? http]) async =>
      jsonDecode(await (http ?? ScHttpClient())
              .get('https://api.media.ccc.de/public/events'))['events']
          .map<Event>(Event.fromJson);

  /// id can be either an id or a guid
  static Future<Event> download(Object id, [ScHttpClient? http]) async =>
      Event.fromJson(jsonDecode(await (http ?? ScHttpClient())
          .get('https://api.media.ccc.de/public/events/$id')));
}
