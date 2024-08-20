import 'package:hive/hive.dart';


part 'memorymodel.g.dart';
@HiveType(typeId: 4) 
class MemoryModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String eventId; 

  @HiveField(2)
  String text;

  @HiveField(3)
  List<String> photoUrls;

  @HiveField(4)
  DateTime createdAt;

  MemoryModel({
    required this.id,
    required this.eventId,
    required this.text,
    required this.photoUrls,
    required this.createdAt,
  });
}