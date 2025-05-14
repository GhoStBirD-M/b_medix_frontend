import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/address_model.dart';
import 'package:uuid/uuid.dart';

class AddressController extends GetxController {
  final storage = GetStorage();
  final storageKey = 'addresses';

  RxList<Address> addresses = <Address>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAddresses();
  }

  void loadAddresses() {
    isLoading.value = true;
    try {
      final addressesJson = storage.read<List<dynamic>>(storageKey) ?? [];

      addresses.value =
          addressesJson.map((json) => Address.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load addresses',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void saveAddresses() {
    try {
      final addressesJson = addresses.map((a) => a.toJson()).toList();
      storage.write(storageKey, addressesJson);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save addresses',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void addAddress(Address address) {
    final newAddress = address.copyWith(id: Uuid().v4());

    if (addresses.isEmpty || newAddress.isDefault) {
      for (var i = 0; i < addresses.length; i++) {
        if (addresses[i].isDefault) {
          addresses[i] = addresses[i].copyWith(isDefault: false);
        }
      }
    }

    addresses.add(newAddress);
    saveAddresses();
    Get.back();
    Get.snackbar(
      'Success',
      'Address added successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
    );
  }

  void updateAddress(Address address) {
    final index = addresses.indexWhere((a) => a.id == address.id);
    if (index != -1) {
      if (address.isDefault) {
        for (var i = 0; i < addresses.length; i++) {
          if (addresses[i].isDefault && addresses[i].id != address.id) {
            addresses[i] = addresses[i].copyWith(isDefault: false);
          }
        }
      }

      addresses[index] = address;
      saveAddresses();
      Get.back();
      Get.snackbar(
        'Success',
        'Address updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
    }
  }

  void deleteAddress(String id) {
    addresses.removeWhere((a) => a.id == id);
    saveAddresses();
    Get.snackbar(
      'Success',
      'Address deleted successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
    );
  }

  void setDefaultAddress(String id) {
    for (var i = 0; i < addresses.length; i++) {
      if (addresses[i].id == id) {
        addresses[i] = addresses[i].copyWith(isDefault: true);
      } else if (addresses[i].isDefault) {
        addresses[i] = addresses[i].copyWith(isDefault: false);
      }
    }
    saveAddresses();
    Get.snackbar(
      'Success',
      'Default address updated',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
    );
  }
}
