import 'package:chatbot_test/core/enums/enums.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:chatbot_test/core/enums/enums.dart';

abstract class LocalStorageService {
  static init() async {
    await Hive.initFlutter();

    for (var element in LocalStorageBox.values) {
      await Hive.openBox(element.name);
    }
  }

  ///[T] This isthe data type to be returned
  ///[key] This is the key used to access the data
  Future<T> findByCustomKey<T>({
    required LocalStorageBox box,
    required dynamic key,
  });

  ///[T] This isthe data type to be returned
  ///[key] This is the key that will be used to store the data
  ///[box] This is the parent shield holding multiple
  ///[data] This is the data to store inside the box using the key
  Future<void> storeByCustomKey<T>({
    required LocalStorageBox box,
    required dynamic key,
    required T data,
  });

  ///[T] This isthe data type to be returned
  ///[key] This is the key used to access the data
  Future<T> findByKey<T>({
    required LocalStorageBox box,
    required LocalStorageKey key,
  });

  ///[T] This isthe data type to be returned
  ///[key] This is the key that will be used to store the data
  ///[box] This is the parent shield holding multiple
  ///[data] This is the data to store inside the box using the key
  Future<void> storeByKey<T>({
    required LocalStorageBox box,
    required LocalStorageKey key,
    required T data,
  });

  ///[T] This is the data type for the incoming
  ///[key] This is the key used in updating the data
  Future<void> updateByKey<T>({
    required LocalStorageBox box,
    required LocalStorageKey key,
    required T data,
  });

  /// This deletes data from the box by the specified
  /// [key] and [box]
  Future<void> deleteByKey({
    required LocalStorageKey key,
    required LocalStorageBox box,
  });

  ///[box] this clears the entire data on the device
  ///local storage
  Future<void> clearAll({required LocalStorageBox box});
}
