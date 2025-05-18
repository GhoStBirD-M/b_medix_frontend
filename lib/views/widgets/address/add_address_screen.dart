import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile/address_controller.dart';
import '../../../models/profile/address_model.dart';

class AddAddressScreen extends StatefulWidget {
  final Address? address;

  const AddAddressScreen({super.key, this.address});

  @override
  // ignore: library_private_types_in_public_api
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final AddressController addressController = Get.find<AddressController>();
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _labelController;
  late TextEditingController _recipientController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _postalCodeController;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers with existing data if editing
    _labelController = TextEditingController(text: widget.address?.label ?? '');
    _recipientController = TextEditingController(text: widget.address?.recipient ?? '');
    _phoneController = TextEditingController(text: widget.address?.phoneNumber ?? '');
    _addressController = TextEditingController(text: widget.address?.fullAddress ?? '');
    _cityController = TextEditingController(text: widget.address?.city ?? '');
    _postalCodeController = TextEditingController(text: widget.address?.postalCode ?? '');
    _isDefault = widget.address?.isDefault ?? false;
  }

  @override
  void dispose() {
    _labelController.dispose();
    _recipientController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.address != null;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Alamat' : 'Tambah Alamat Baru'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                controller: _labelController,
                label: 'Label Alamat',
                hint: 'Rumah, Kantor, dll',
                prefixIcon: Icons.label_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Label alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              _buildTextField(
                controller: _recipientController,
                label: 'Nama Penerima',
                hint: 'Masukkan nama penerima',
                prefixIcon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama penerima tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              _buildTextField(
                controller: _phoneController,
                label: 'Nomor Telepon',
                hint: 'Masukkan nomor telepon',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              _buildTextField(
                controller: _addressController,
                label: 'Alamat Lengkap',
                hint: 'Masukkan alamat lengkap',
                prefixIcon: Icons.home_outlined,
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              _buildTextField(
                controller: _cityController,
                label: 'Kota',
                hint: 'Masukkan kota',
                prefixIcon: Icons.location_city_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kota tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              _buildTextField(
                controller: _postalCodeController,
                label: 'Kode Pos',
                hint: 'Masukkan kode pos',
                prefixIcon: Icons.markunread_mailbox_outlined,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kode pos tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              
              SwitchListTile(
                title: Text('Jadikan Alamat Utama'),
                value: _isDefault,
                activeColor: Colors.teal,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _isDefault = value;
                  });
                },
              ),
              
              SizedBox(height: 32),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveAddress,
                  icon: Icon(isEditing ? Icons.save : Icons.add_location_alt),
                  label: Text(isEditing ? 'Simpan Perubahan' : 'Simpan Alamat'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: maxLines > 1 ? 16 : 0,
          horizontal: 16,
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
    );
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final address = Address(
        id: widget.address?.id ?? '',
        label: _labelController.text.trim(),
        recipient: _recipientController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        fullAddress: _addressController.text.trim(),
        city: _cityController.text.trim(),
        postalCode: _postalCodeController.text.trim(),
        isDefault: _isDefault,
      );

      if (widget.address != null) {
        addressController.updateAddress(address);
      } else {
        addressController.addAddress(address);
      }
    }
  }
}