import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/notification_controller.dart';
import '../../models/medicine/orders_model.dart';
import '../../models/medicine/cart_model.dart';
import '../../models/medicine/cart_item_model.dart';
import '../../services/cart_service.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();
  final notifController = Get.find<NotificationController>();

  final Rx<Cart?> _cart = Rx<Cart?>(null);
  final Rx<Orders?> order = Rx<Orders?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;

  Cart? get cart => _cart.value;
  List<CartItem> get items => _cart.value?.items ?? [];
  double get subtotal => _cart.value?.subtotal ?? 0;
  double get deliveryFee => _cart.value?.deliveryFee ?? 0;
  double get total => _cart.value?.total ?? 0;

  var isAddingToCart = false.obs;
  var isBuyingNow = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;
      final cart = await _cartService.getCart();
      _cart.value = cart;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load cart: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart(int medicineId, int quantity,
      {RxBool? loadingFlag}) async {
    try {
      // Gunakan loadingFlag jika tersedia, jika tidak pakai isUpdating
      (loadingFlag ?? isUpdating).value = true;

      final success = await _cartService.addToCart(medicineId, quantity);
      if (success) {
        await fetchCart();
        Get.snackbar(
          'Success',
          'Item added to cart',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        notifController.addNotification(
          'Keranjang',
          'Obat telah ditambahkan ke keranjang',
          'add_shopping_cart_outlined',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add item to cart: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      (loadingFlag ?? isUpdating).value = false;
    }
  }

  Future<void> updateQuantity(CartItem item, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeItem(item);
      return;
    }

    try {
      isUpdating.value = true;
      final success =
          await _cartService.updateCartItemQuantity(item.id, newQuantity);
      if (success) {
        await fetchCart();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update quantity: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> incrementQuantity(CartItem item) async {
    await updateQuantity(item, item.quantity + 1);
  }

  Future<void> decrementQuantity(CartItem item) async {
    await updateQuantity(item, item.quantity - 1);
  }

  Future<void> removeItem(CartItem item) async {
    try {
      isUpdating.value = true;
      final success = await _cartService.removeFromCart(item.id);
      if (success) {
        await fetchCart();
        Get.snackbar(
          'Success',
          'Item removed from cart',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to remove item: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  Future<void> checkoutCart(String paymentMethod) async {
    try {
      isLoading.value = true;
      final result = await _cartService.checkoutCart(paymentMethod);
      order.value = result;
      notifController.addNotification(
        'Keranjang',
        'Berhasil Checkout',
        'shopping_cart_checkout_outlined',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
