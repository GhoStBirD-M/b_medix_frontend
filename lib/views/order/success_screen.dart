import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../routes/app_pages.dart';
import '../../views/widgets/order/info_container.dart';
import '../../views/widgets/order/primary_button.dart';

class SuccessScreen extends StatefulWidget {
  final String paymentMethod;
  final String orderId;
  final String total;

  const SuccessScreen({
    super.key,
    required this.paymentMethod,
    required this.orderId,
    required this.total
  });

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final List<String> printers = ['ZQ120', 'XP-P300', 'RPP300', 'PAPERANG P1'];
  String? selectedPrinter;

  @override
  void initState() {
    super.initState();
    selectedPrinter = printers.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animated checkmark icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Color(0xFF10B981),
                ),
              ),
              const SizedBox(height: 32),
              // Title
              const Text(
                'Payment Successful!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 16),
              // Subtitle
              Text(
                'Your payment via ${widget.paymentMethod} has been successfully processed.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              // Receipt details
              InfoContainer(
                withShadow: true,
                children: [
                  _buildInfoRow('Order ID', widget.orderId),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(color: Color(0xFFE2E8F0)),
                  ),
                  _buildInfoRow('Payment Method', widget.paymentMethod.toUpperCase()),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(color: Color(0xFFE2E8F0)),
                  ),
                  _buildInfoRow('Date', DateFormat('MMMM dd, yyyy').format(DateTime.now())),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(color: Color(0xFFE2E8F0)),
                  ),
                  _buildInfoRow('Total', 'Rp ${NumberFormat.decimalPattern('id_ID').format(double.parse(widget.total).round())}'),
                ],
              ),
              const SizedBox(height: 24),
              // Styled dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedPrinter,
                    isExpanded: true,
                    hint: const Text(
                      'Choose Printer',
                      style: TextStyle(color: Color(0xFF64748B)),
                    ),
                    icon: const Icon(Icons.print, color: Color(0xFF64748B)),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1E293B),
                    ),
                    items: printers.map((String printer) {
                      return DropdownMenuItem<String>(
                        value: printer,
                        child: Text(printer),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPrinter = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Print Receipt button
              PrimaryButton(
                text: 'Print Receipt',
                onPressed: () {
                  print('Printing receipt with $selectedPrinter');
                  // Add actual printing logic here
                },
              ),
              const SizedBox(height: 12),
              // Back to Home button
              PrimaryButton(
                text: 'Back to Home',
                onPressed: () => Get.offAllNamed(AppPages.HOME),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }
}
