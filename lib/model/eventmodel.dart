import 'package:hive/hive.dart';
part 'eventmodel.g.dart';

@HiveType(typeId: 1)
class EventModel extends HiveObject{
  @HiveField(0)
  String? eventTitle;

  @HiveField(1)
  String? eventDescription;

  @HiveField(2)
  String? eventlocation;

  @HiveField(3)
  String? eventDate;

  @HiveField(4)
  String? eventTime;

  @HiveField(5)
  String? eventImage;

  @HiveField(6)
  String? userKey;

  @HiveField(7)
  bool? isImportant;


  EventModel({
    this.eventTitle,
    this.eventDescription,
    this.eventlocation,
    this.eventDate,
    this.eventTime,
    this.eventImage,
    required this.userKey,
    required this.isImportant
  });
}