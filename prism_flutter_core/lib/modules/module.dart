abstract class Module<T> {
  /// Initializes a module
  Future<void> init(T container);

  /// Resets a module and prepare it for another initialization call
  /// Can be used to reset state after a user log out for instance.
  Future<void> reset(T container) async {}
}
