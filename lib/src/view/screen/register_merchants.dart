import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb, compute;

import '../../../core/app_color.dart';
import '../../../core/app_data.dart';
import '../../data/database_helper.dart';
import '../../data/drift_platform_database_helper.dart';
import '../../../services/niimbot_printer_service.dart';
import '../../../services/jcdemo_launcher_service.dart';
import '../widget/custom_button.dart';
import '../widget/custom_text_field.dart';
import '../widget/niimbot_printer_widget.dart';
import 'encryptdecrpty.dart';
import 'home_screen.dart';

class MakePayment extends StatefulWidget {
  final String phone;

  const MakePayment(this.phone, {super.key});

  @override
  State<MakePayment> createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nidaController = TextEditingController();

  XFile? _imageFile;
  XFile? _secondImageFile;
  XFile? _thirdImageFile;
  Uint8List? _imageBytes;
  Uint8List? _secondImageBytes;
  Uint8List? _thirdImageBytes;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _secondPickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _secondImageBytes = bytes;
        _secondImageFile = pickedFile;
      });
    }
  }

  Future<void> _thirdPickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _thirdImageBytes = bytes;
        _thirdImageFile = pickedFile;
      });
    }
  }

  Future<void> _printTestReceipt() async {
    try {
      // Check if JcDemo is installed
      final bool isInstalled = await JcDemoLauncherService.isJcDemoInstalled();
      
      if (!isInstalled) {
        if (mounted) {
          JcDemoLauncherService.showInstallDialog(context);
        }
        return;
      }

      // Launch JcDemo with text print type
      final bool launched = await JcDemoLauncherService.launchJcDemoWithPrintType('text');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(launched ? 'JcDemo launched for test printing!' : 'Failed to launch JcDemo'),
            backgroundColor: launched ? Colors.green : Colors.red,
          ),
        );
      }

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launching JcDemo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _printRegistrationReceipt(List<dynamic> merchantData) async {
    try {
      // Check if printer is connected
      final status = await NiimbotPrinterService.checkConnection();
      if (!status['connected']) {
        // Printer not connected, but don't show error since registration was successful
        print('Printer not connected - skipping receipt print');
        return;
      }

      // Get merchant data (assuming first merchant in the list)
      final merchant = merchantData.isNotEmpty ? merchantData.first : {};
      
      // Create registration receipt data
      final receiptData = {
        'title': 'Merchant Registration Receipt',
        'merchant': merchant['name'] ?? nameController.text,
        'phone': merchant['merchant_phone'] ?? phoneController.text,
        'email': merchant['email'] ?? emailController.text,
        'nida': merchant['nida'] ?? nidaController.text,
        'agent': widget.phone,
        'transactionId': 'REG${DateTime.now().millisecondsSinceEpoch}',
        'date': DateTime.now().toIso8601String(),
        'items': [
          {'name': 'Merchant Registration', 'amount': 0.00},
          {'name': 'Business License Upload', 'amount': 0.00},
          {'name': 'NIDA Verification', 'amount': 0.00},
        ],
        'total': 0.00,
        'status': 'Registration Complete',
        'note': 'Merchant successfully registered in the system',
      };

      // Print the receipt using Niimbot printer
      final success = await NiimbotPrinterService.printTextReceipt(receiptData);
      
      // Show success message
      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration receipt printed successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        print('Failed to print registration receipt');
      }

    } catch (e) {
      // Don't show error to user since registration was successful
      print('Failed to print registration receipt: $e');
    }
  }

  Future<void> register(BuildContext context) async {
    if (_imageBytes == null) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please take a picture of business licence/Tin Number")));
      }
      return;
    }

    if(phoneController.text.length < 10){
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please Enter compete number")));
      }
      return;
    }

    if(nameController.text.length < 2){
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please Enter Name")));
      }
      return;
    }

    // Show loading dialog immediately
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(color: AppColor.primaryColor),
      ),
    );

    // Give UI time to render the dialog
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      final Map<String, dynamic> body = {
        'agent_phone': widget.phone,
        'nida': nidaController.text,
        'merchant_phone': phoneController.text,
        'name': nameController.text,
        'email': emailController.text,
      };

      // Compress and encode main image (bytes work on both web and mobile)
      Uint8List mainCompressed = await FlutterImageCompress.compressWithList(
        _imageBytes!,
        minWidth: 800,
        minHeight: 800,
        quality: 70,
      );
      if (mainCompressed.isEmpty) {
        mainCompressed = _imageBytes!;
      }
      final fileName = (_imageFile?.name.isNotEmpty ?? false)
          ? _imageFile!.name
          : 'document_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // Encode to base64 in isolate to prevent blocking
      final base64File = await _encodeToBase64(mainCompressed);
      body['document'] = base64File;
      body['filename'] = fileName;

      // Process second and third images in parallel if available
      final futures = <Future>[];
      
      // Second image (if available)
      if (_secondImageBytes != null) {
        futures.add(_processImage(
          imageFile: _secondImageFile,
          imageBytes: _secondImageBytes,
          prefix: 'second',
        ).then((result) {
          if (result != null) {
            body['second_document'] = result['base64'];
            body['second_filename'] = result['filename'];
          }
        }));
      }

      // Third image (if available)
      if (_thirdImageBytes != null) {
        futures.add(_processImage(
          imageFile: _thirdImageFile,
          imageBytes: _thirdImageBytes,
          prefix: 'third',
        ).then((result) {
          if (result != null) {
            body['third_document'] = result['base64'];
            body['third_filename'] = result['filename'];
          }
        }));
      }

      // Wait for all images to be processed
      await Future.wait(futures);

      // Encrypt body (this should be fast)
      final encryptedBody = ApiCrypto.encryptRequest(body);

      // Send request with timeout
      final uri = Uri.parse(AppData.url + '/merchants');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: encryptedBody,
      ).timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          throw TimeoutException('Request timed out after 60 seconds');
        },
      );

      // Decrypt response
      final decryptedResponse = ApiCrypto.decryptResponse(response.body);
      final responseBody = decryptedResponse;
      
      // Dismiss loading dialog before processing response
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
      
      if (response.statusCode == 200) {
        final transactionData = responseBody['merchant'];
        if (transactionData != null) {
          for (var transaction in transactionData) {
            if (kIsWeb) {
              await DriftPlatformDatabaseHelper.instance.insertMerchants(transaction);
            } else {
              await DatabaseHelper.instance.insertMerchants(transaction);
            }
          }
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Merchant Registration successfully!")),
          );
        }

        // Print registration receipt if printer is available (don't block UI)
        _printRegistrationReceipt(transactionData).catchError((e) {
          print('Failed to print receipt: $e');
        });

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } else {
        final errorMsg = responseBody['message'] ?? decryptedResponse['message'] ?? 'Registration Failed';
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
        }
      }
    } on TimeoutException catch (e) {
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Request timed out. Please check your connection and try again.')),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
        );
      }
    }
  }

  // Helper method to encode bytes to base64
  // Note: Base64 encoding is fast enough that we don't need isolate for typical image sizes
  Future<String> _encodeToBase64(Uint8List bytes) async {
    // Use compute only for very large images (> 1MB) to prevent blocking
    if (bytes.length > 1024 * 1024) {
      return await compute(_base64EncodeIsolate, bytes);
    }
    return base64Encode(bytes);
  }

  // Helper method to process images (compress and encode)
  Future<Map<String, String>?> _processImage({
    XFile? imageFile,
    Uint8List? imageBytes,
    required String prefix,
  }) async {
    try {
      if (imageBytes == null) return null;
      Uint8List compressed = await FlutterImageCompress.compressWithList(
        imageBytes,
        minWidth: 800,
        minHeight: 800,
        quality: 70,
      );
      if (compressed.isEmpty) {
        compressed = imageBytes;
      }
      final fileName = (imageFile?.name.isNotEmpty ?? false)
          ? imageFile!.name
          : '${prefix}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // Encode to base64 in isolate
      final base64String = await _encodeToBase64(compressed);
      
      return {
        'base64': base64String,
        'filename': fileName,
      };
    } catch (e) {
      print('Error processing $prefix image: $e');
      return null;
    }
  }

  // Static function for isolate
  static String _base64EncodeIsolate(Uint8List bytes) {
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const Text("Merchant Registration"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Text(
                "register_merchant_form".tr(),
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const Text(
                "Provide the merchant’s name, phone number, NIDA, and upload a photo of the business license.",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),

              _buildSunkenField(
                child: CustomTextField(
                  hintText: "Enter Business Name",
                  icon: Icons.edit,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                ),
              ),
              const SizedBox(height: 15),

              _buildSunkenField(
                child: CustomTextField(
                  hintText: "Enter Phone number",
                  icon: Icons.phone,
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 15),
              _buildSunkenField(
                child: CustomTextField(
                  hintText: "Enter Email",
                  icon: Icons.email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 15),
              _buildSunkenField(
                child: CustomTextField(
                  hintText: "Enter Nida",
                  icon: Icons.badge,
                  controller: nidaController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 15),

              // 📸 Sunken Image Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 6, bottom: 4),
                    child: Text("Business Licence", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                  _buildSunkenField(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: _imageBytes == null
                          ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                          SizedBox(height: 8),
                          Text("Tap to take picture"),
                        ],
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          _imageBytes!,
                          height: 180,
                          width: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 6, bottom: 4),
                    child: Text("Tin Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                  _buildSunkenField(
                    child: GestureDetector(
                      onTap: _secondPickImage,
                      child: _secondImageBytes == null
                          ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                          SizedBox(height: 8),
                          Text("Tap to take picture"),
                        ],
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          _secondImageBytes!,
                          height: 180,
                          width: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 6, bottom: 4),
                    child: Text("Identification", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                  _buildSunkenField(
                    child: GestureDetector(
                      onTap: _thirdPickImage,
                      child: _thirdImageBytes == null
                          ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                          SizedBox(height: 8),
                          Text("Tap to take picture"),
                        ],
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          _thirdImageBytes!,
                          height: 180,
                          width: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              

              const SizedBox(height: 20),
              _buildSunkenField(
                child: CustomButton(
                  onPressed: () => register(context),
                  text: 'Submit',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSunkenField({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(-3, -3),
            blurRadius: 6,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.9),
            offset: const Offset(3, 3),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: child,
    );
  }
}
