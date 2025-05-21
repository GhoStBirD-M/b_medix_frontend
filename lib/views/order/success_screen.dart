import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
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
    required this.total,
  });

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final FlutterThermalPrinter _flutterThermalPrinter = FlutterThermalPrinter.instance;

  List<Printer> _printers = [];
  Printer? selectedPrinter;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  void _startScan() async {
    await _flutterThermalPrinter.getPrinters(connectionTypes: [
      ConnectionType.BLE,
    ]);
    _flutterThermalPrinter.devicesStream.listen((devices) {
      setState(() {
        _printers = devices;
      });
    });
  }

  Future<void> printReceipt(String paymentMethod) async {
    if (_printers.isEmpty) {
      Get.snackbar("No Printer Found", "No Bluetooth printer detected.");
      return;
    }

    if (selectedPrinter == null) {
      Get.snackbar("Select Printer", "Please select a Bluetooth printer.");
      return;
    }

    try {
      await _flutterThermalPrinter.connect(selectedPrinter!);
      await Future.delayed(const Duration(milliseconds: 300));

      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);
      final List<int> bytes = [];
      bytes.addAll(generator.feed(1));
      bytes.addAll(generator.text('Payment Successfull!',
          styles: PosStyles(
              align: PosAlign.center,
              bold: true,
              height: PosTextSize.size2,
              width: PosTextSize.size2)));
      bytes.addAll(generator.text('-----------------------------'));
      bytes.addAll(generator.text('Order ID   : ${widget.orderId}'));
      bytes.addAll(generator.text('Method     : $paymentMethod'));
      bytes.addAll(generator.text(
          'Date       : ${DateFormat('dd MMM yyyy').format(DateTime.now())}'));
      bytes.addAll(generator.text('-----------------------------'));
      bytes.addAll(generator.text('Thank you!',
          styles: PosStyles(align: PosAlign.center)));
      bytes.addAll(generator.feed(0));
      bytes.addAll(generator.cut());

      const int chunkSize = 240;
      int offset = 0;
      while (offset < bytes.length) {
        final end = (offset + chunkSize < bytes.length) ? offset + chunkSize : bytes.length;
        final chunk = Uint8List.fromList(bytes.sublist(offset, end));
        await _flutterThermalPrinter.printData(selectedPrinter!, chunk);
        offset = end;
        await Future.delayed(const Duration(milliseconds: 100));
      }

      Get.snackbar("Success", "Receipt sent to printer.");
    } catch (e) {
      Get.snackbar("Error", "Failed to print: $e");
    } finally {
      await _flutterThermalPrinter.disconnect(selectedPrinter!);
    }
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
            children: [
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
              const Text(
                'Payment Successful!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 16),
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
              InfoContainer(
                withShadow: true,
                children: [
                  _buildInfoRow('Order ID', widget.orderId),
                  const Divider(color: Color(0xFFE2E8F0)),
                  _buildInfoRow('Payment Method', widget.paymentMethod.toUpperCase()),
                  const Divider(color: Color(0xFFE2E8F0)),
                  _buildInfoRow('Date', DateFormat('MMMM dd, yyyy').format(DateTime.now())),
                  const Divider(color: Color(0xFFE2E8F0)),
                  _buildInfoRow('Total', 'Rp ${NumberFormat.decimalPattern('id_ID').format(double.parse(widget.total).round())}'),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Printer>(
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
                    items: _printers.map((Printer printer) {
                      return DropdownMenuItem<Printer>(
                        value: printer,
                        child: Text(printer.name ?? 'No Name'),
                      );
                    }).toList(),
                    onChanged: (Printer? newValue) {
                      setState(() {
                        selectedPrinter = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                text: 'Print Receipt',
                onPressed: () {
                  printReceipt(widget.paymentMethod);
                },
              ),
              const SizedBox(height: 12),
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
