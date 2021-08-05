import 'package:voc/voc.dart';
import 'package:test/test.dart';

void main() {
  test('Have more than 20 Congresses been held?', () async {
    assert((await Conference.getAllConferences())
            .where((c) => c.acronym!.contains('c3'))
            .length >
        20);
  });
  test('Have there been more than 40 Events?', () async {
    assert((await Event.getAllEvents()).length > 40);
  });
  test('Have there been more than 40 Events?', () async {
    assert((await Event.getAllEvents()).length > 40);
  });
  test('Get Event from RelatedEvent', () async {
    await RelatedEvent(guid: 'ChACwuF2-cEBp_u6HrharA', id: 1892, weight: 1)
        .download();
  });
}
