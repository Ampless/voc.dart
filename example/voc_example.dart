import 'package:voc/voc.dart';

void main() async {
  print(await Conference.getAllConferences());
  print(await Event.getAllEvents());
}
