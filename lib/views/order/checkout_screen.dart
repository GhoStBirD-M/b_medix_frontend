import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/profile/address_controller.dart';
import '../../controllers/medicine/cart_controller.dart';
import '../../views/widgets/order/order_widgets.dart';
import 'qris_payment_screen.dart';
import 'success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;

  const CheckoutScreen({
    super.key,
    required this.totalAmount,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String? selectedPaymentMethod;
  final CartController cartController = Get.put(CartController());
  final addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Checkout'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Methods',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            PaymentMethodItem(
              title: 'QRIS',
              icon: Icons.qr_code,
              isSelected: selectedPaymentMethod == 'qris',
              onTap: () {
                setState(() {
                  selectedPaymentMethod = 'qris';
                });
              },
            ),
            const Divider(),
            PaymentMethodItem(
              title: 'Tunai',
              icon: Icons.money,
              isSelected: selectedPaymentMethod == 'tunai',
              onTap: () {
                setState(() {
                  selectedPaymentMethod = 'tunai';
                });
              },
            ),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            InfoContainer(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    Text(
                      'Rp ${NumberFormat.decimalPattern('id_ID').format(widget.totalAmount - 10000)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Delivery',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const Text(
                      'Rp 10.000',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp ${NumberFormat.decimalPattern('id_ID').format(widget.totalAmount)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SafeArea(
              child: Obx(() => PrimaryButton(
                    text: 'Pay',
                    isLoading: cartController.isLoading.value,
                    onPressed: selectedPaymentMethod == null
                        ? null
                        : () async {
                            if (addressController.defaultAddress == null) {
                              Get.snackbar(
                                'Alamat belum dipilih',
                                'Silakan tambahkan alamat terlebih dahulu.',
                                backgroundColor: Colors.orange,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }
                            try {
                              await cartController
                                  .checkoutCart(selectedPaymentMethod!);
                              if (selectedPaymentMethod == 'qris') {
                                Get.offAll(QrisPaymentScreen(
                                    amount: widget.totalAmount));
                              } else if (selectedPaymentMethod == 'tunai') {
                                Get.to(SuccessScreen(
                                  paymentMethod: selectedPaymentMethod!,
                                  orderId:
                                      "ORD-${DateTime.now().millisecondsSinceEpoch}",
                                  total: widget.totalAmount.toString(),
                                ));
                              }
                            } catch (e) {
                              Get.snackbar(
                                'Error',
                                e.toString(),
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
