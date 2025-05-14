import 'package:flutter/material.dart';
import '../widgets/payment/payment_method_card.dart';
import '../widgets/payment/info_note.dart';

class PaymentMethodInfoScreen extends StatelessWidget {
  const PaymentMethodInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Payment Methods',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Available Payment Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'We offer two convenient payment methods for your transactions',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              
              // Cash Payment Card
              PaymentMethodCard(
                icon: Icons.payments_outlined,
                iconColor: Colors.green,
                title: 'Cash Payment',
                subtitle: 'Pay with physical cash upon delivery',
                description: 'With Cash payment, you can pay directly to our courier when your order arrives. Make sure to prepare the exact amount to simplify the transaction process. This method is perfect for those who prefer traditional payment options.',
                benefits: [
                  'No additional fees',
                  'Pay only when you receive your order',
                  'No need for electronic devices or internet',
                  'Available for all delivery options'
                ],
                note: 'Our couriers may not always have change available, so please prepare the exact amount when possible.',
              ),
              
              const SizedBox(height: 20),
              
              // QRIS Payment Card
              PaymentMethodCard(
                icon: Icons.qr_code,
                iconColor: Colors.blue,
                title: 'QRIS Payment',
                subtitle: 'Quick Response Code Indonesian Standard',
                description: 'QRIS (Quick Response Code Indonesian Standard) allows you to make payments by scanning a QR code using your mobile banking or e-wallet app. It\'s fast, secure, and widely accepted across Indonesia.',
                benefits: [
                  'Instant payment confirmation',
                  'Supported by all major banks and e-wallets',
                  'Secure and traceable transactions',
                  'No need to prepare exact cash amount'
                ],
                note: 'Make sure your phone has a working camera and internet connection to use QRIS payment.',
              ),
              
              const SizedBox(height: 30),
              
              // Footer
              InfoNote(
                icon: Icons.info_outline,
                iconColor: Colors.blue,
                backgroundColor: Colors.blue[50]!,
                borderColor: Colors.blue[100]!,
                title: 'Need Help?',
                message: 'Contact our customer service if you have any questions about payment methods.',
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}