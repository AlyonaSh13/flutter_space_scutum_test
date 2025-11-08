import 'package:hive_ce/hive.dart';

/// A reusable mixin that provides common Hive box initialization logic.
///
/// This mixin handles:
/// - registering the Hive adapter (if not yet registered)
/// - opening the box (or returning an already opened one)
///
/// By using this mixin, all services gain consistent data initialization
/// without duplicating boilerplate code.
mixin BaseServiceMixin<T> {
  /// Name of the Hive box.
  late String boxName;

  /// Adapter responsible for serializing/deserializing Hive model [T].
  late TypeAdapter<T> adapter;

  /// Returns an opened Hive box of type [T].
  ///
  /// Ensures:
  /// 1. Adapter is registered only once.
  /// 2. Box is opened only once.
  ///
  /// Usage:
  /// ```dart
  /// final box = await getBox();
  /// box.put('id', model);
  /// ```
  Future<Box<T>> getBox() async {
    // Register the adapter if it's not already registered.
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }

    // Open the box if not already open.
    if (!Hive.isBoxOpen(boxName)) {
      return Hive.openBox<T>(boxName);
    }

    // Reuse the already opened box.
    return Hive.box<T>(boxName);
  }
}
