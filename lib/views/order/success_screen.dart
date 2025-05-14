import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:get/get.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import '../../routes/app_pages.dart';
import '../../views/widgets/order/info_container.dart';
import '../../views/widgets/order/primary_button.dart';

class SuccessScreen extends StatefulWidget {
  final String paymentMethod;

  const SuccessScreen({super.key, required this.paymentMethod});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
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

  // Start scanning for Bluetooth printers
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

  // Function to print the receipt using the selected Bluetooth printer
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
    await Future.delayed(const Duration(milliseconds: 300)); // Tambah delay agar stabil

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    final List<int> bytes = [];
    bytes.addAll(generator.feed(1));
    bytes.addAll(generator.text('Payment Successfull!',
        styles: PosStyles(align: PosAlign.center, bold: true, height: PosTextSize.size2, width: PosTextSize.size2)));
    bytes.addAll(generator.text('-----------------------------'));
    bytes.addAll(generator.text('Order ID   : #ORD-12345'));
    bytes.addAll(generator.text('Method     : $paymentMethod'));
    bytes.addAll(generator.text('Date       : 10 May 2025'));
    bytes.addAll(generator.text('-----------------------------'));
    bytes.addAll(generator.text('Thank you!', styles: PosStyles(align: PosAlign.center)));
    bytes.addAll(generator.feed(0));
    bytes.addAll(generator.cut());

    // Split the bytes into chunks of 240 if needed
    const int chunkSize = 240;
    int offset = 0;
    while (offset < bytes.length) {
      final end = (offset + chunkSize < bytes.length) ? offset + chunkSize : bytes.length;
      final chunk = Uint8List.fromList(bytes.sublist(offset, end));
      await _flutterThermalPrinter.printData(selectedPrinter!, chunk);
      offset = end;
      await Future.delayed(const Duration(milliseconds: 100)); // optional delay
    }

    Get.snackbar("Success", "Receipt sent to printer.");
  } catch (e) {
    Get.snackbar("Error", "Failed to print: $e");
  } finally {
    await _flutterThermalPrinter.disconnect(selectedPrinter!);
  }
}


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your payment via ${widget.paymentMethod} has been successfully processed.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 48),
              InfoContainer(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order ID',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        '#ORD-12345',
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
                        'Payment Method',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        widget.paymentMethod,
                        style: const TextStyle(
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        '10 May 2025',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Printer selection
              DropdownButton<Printer>(
                hint: const Text("Select Printer"),
                value: selectedPrinter,
                onChanged: (Printer? printer) {
                  setState(() {
                    selectedPrinter = printer;
                  });
                },
                items: _printers.map((Printer printer) {
                  return DropdownMenuItem<Printer>(
                    value: printer,
                    child: Text(printer.name ?? 'No Name'),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              // Smaller Primary Buttons
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: PrimaryButton(
                  text: 'Print Receipt',
                  onPressed: () async {
                    await printReceipt(widget.paymentMethod);
                  },
                  fontSize: 14, // Adjusting font size for smaller buttons
                  padding: const EdgeInsets.symmetric(vertical: 10), // Reduced padding
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: PrimaryButton(
                  text: 'Back to Home',
                  onPressed: () => Get.offAllNamed(AppPages.HOME),
                  fontSize: 14, // Adjusting font size for smaller buttons
                  padding: const EdgeInsets.symmetric(vertical: 10), // Reduced padding
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
