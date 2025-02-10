import 'package:hive/hive.dart';
import 'package:chatbot_test/core/enums/enums.dart';

import 'local_storage_service.dart';

class LocalStorageServiceImpl extends LocalStorageService {
  @override
  Future<void> storeByKey<T>({
    required LocalStorageBox box,
    required LocalStorageKey key,
    required T data,
  }) async {
    await Hive.box(box.name).put(key.name, data);
  }

  @override
  Future<void> updateByKey<T>({
    required LocalStorageBox box,
    required LocalStorageKey key,
    required T data,
  }) async {
    await Hive.box(box.name).put(key.name, data);
  }

  @override
  Future<void> clearAll({required LocalStorageBox box}) async {
    await Hive.box(box.name).clear();
  }

  @override
  Future<void> deleteByKey({
    required LocalStorageKey key,
    required LocalStorageBox box,
  }) async {
    // TODO: implement deleteByKey
    await Hive.box(box.name).delete(key.name);
  }

  @override
  Future<T> findByKey<T>({
    required LocalStorageBox box,
    required LocalStorageKey key,
  }) async {
    // TODO: implement findByKey
    return await Hive.box(box.name).get(key.name) as T;
  }

  @override
  Future<T> findByCustomKey<T>({
    required LocalStorageBox box,
    required key,
  }) async {
    // TODO: implement findByCustomKey
    return await Hive.box(box.name).get(key) as T;
  }

  @override
  Future<void> storeByCustomKey<T>({
    required LocalStorageBox box,
    required key,
    required T data,
  }) async {
    // TODO: implement storeByCustomKey
    await Hive.box(box.name).put(key, data);
  }
}
