import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:patroli/home.dart'; // Assuming Homepage and _HomepageState are in home.dart

// A helper function to create a new instance of _HomepageState
// This is a bit unconventional as state objects are usually tied to widgets,
// but for focused unit testing of state logic, this can be a workaround.
// For more robust testing, interacting via WidgetTester is preferred.
_HomepageState createHomepageState() {
  // Create a dummy GlobalKey to act as a context substitute if needed for basic tests
  // However, methods like _updatePetrolPrice show dialogs and need a real BuildContext.
  // For this test, we will focus on _loadPetrolPrice and direct SharedPreferences interaction.
  return Homepage().createElement().state as _HomepageState;
}

void main() {
  // Initialize Flutter binding for tests
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Homepage Petrol Price Persistence Tests', () {
    test('Test 1: Default Price on Fresh Install', () async {
      SharedPreferences.setMockInitialValues({});
      final state = createHomepageState();

      // Directly call _loadPetrolPrice (it's async)
      await state.initState(); // initState calls _loadPetrolPrice

      // Verify that the price variable in the state is equal to the default price
      expect(state.price, 96.45);
    });

    test('Test 2: Saving and Loading Price', () async {
      SharedPreferences.setMockInitialValues({});
      _HomepageState state = createHomepageState();

      // Simulate loading initial state
      await state.initState();
      expect(state.price, 96.45); // Should be default initially

      // Simulate updating the price via SharedPreferences directly for this test
      // This bypasses the UI interaction part of _updatePetrolPrice
      const double newTestPrice = 100.0;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('petrol_price', newTestPrice);

      // Create a new state instance to simulate app restart or view reload
      state = createHomepageState();
      await state.initState(); // This will call _loadPetrolPrice

      // Verify that the price variable in the state is equal to the new price
      expect(state.price, newTestPrice);
    });

    test('Test 3: Loading Previously Saved Price', () async {
      const double savedPrice = 105.50;
      SharedPreferences.setMockInitialValues({'petrol_price': savedPrice});
      final state = createHomepageState();

      // Directly call _loadPetrolPrice (it's async)
      await state.initState(); // initState calls _loadPetrolPrice

      // Verify that the price variable in the state is equal to the pre-saved price
      expect(state.price, savedPrice);
    });
  });

  // It's good practice to clear mock values after tests if they could interfere,
  // though setMockInitialValues({}) at the start of each test often suffices.
  tearDown(() async {
    // Clear all preferences after each test to ensure isolation
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });
}
