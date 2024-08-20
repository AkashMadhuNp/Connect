import 'package:first_project_app/model/memorymodel.dart';
import 'package:hive/hive.dart';

class MemoryFunction{
  Future<void> addMemory(MemoryModel memory)async{
    final Box<MemoryModel> box = await Hive.openBox<MemoryModel>('memory_db');
    await box.put(memory.id, memory);
    await box.close();


  }


  Future<List<MemoryModel>> getMemoriesForEvent(String eventId)async{
    final Box<MemoryModel> box = await Hive.openBox<MemoryModel>('memory_db');
    final memories = box.values.where((memory)=>memory.eventId == eventId).toList();
    await box.close();
    return memories;
  }


    Future<void> updateMemory(MemoryModel memory) async {
    final box = await Hive.openBox<MemoryModel>('memory_db');
    await box.put(memory.id, memory);
    await box.close();
  }

  Future<void> deleteMemory(String id) async {
    final box = await Hive.openBox<MemoryModel>('memory_db');
    await box.delete(id);
    await box.close();
  }

  Future<void> removePhotoFromMemory(String memoryId, String photoUrl)async{
    final Box<MemoryModel> box = await Hive.openBox<MemoryModel>('memory_db');
    final memory = box.get(memoryId);
    if(memory != null){
      memory.photoUrls.remove(photoUrl);
      await box.put(memoryId, memory);
    }
    await box.close();
  }

}