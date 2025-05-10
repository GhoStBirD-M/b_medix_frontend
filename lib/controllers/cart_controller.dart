import 'package:get/get.dart';
import '../../models/orders_model.dart';
import '../models/cart_model.dart';
import '../models/cart_item_model.dart';
import '../services/cart_service.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();

  final Rx<Cart?> _cart = Rx<Cart?>(null);
  final Rx<Orders?> order = Rx<Orders?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;

  Cart? get cart => _cart.value;
  List<CartItem> get items => _cart.value?.items ?? [];
  double get subtotal => _cart.value?.subtotal ?? 0;
  double get deliveryFee => _cart.value?.deliveryFee ?? 0;
  double get total => _cart.value?.total ?? 0;

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
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart(int medicineId, int quantity) async {
    try {
      isUpdating.value = true;
      final success = await _cartService.addToCart(medicineId, quantity);
      if (success) {
        await fetchCart();
        Get.snackbar(
          'Success',
          'Item added to cart',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to add item to cart: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUpdating.value = false;
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
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to remove item: ${e.toString()}',
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
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
