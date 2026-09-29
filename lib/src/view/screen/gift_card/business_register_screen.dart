import 'package:flutter/material.dart';
import 'package:malipo_agent/core/app_color.dart';
import 'package:malipo_agent/models/category_model.dart';
import 'package:malipo_agent/services/gift_card_api_service.dart';
import 'home_screen.dart';

class BusinessRegisterScreen extends StatefulWidget {
  const BusinessRegisterScreen({super.key, this.fromSignup = false});

  final bool fromSignup;

  @override
  State<BusinessRegisterScreen> createState() => _BusinessRegisterScreenState();
}

class _BusinessRegisterScreenState extends State<BusinessRegisterScreen> {
  final _api = GiftCardApiService();
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _city = TextEditingController();
  final _desc = TextEditingController();
  List<CategoryModel> _categories = [];
  final Set<int> _selectedCats = {};
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _api.getCategories().then((res) {
      final list = (res['data']?['categories'] as List?) ?? [];
      if (!mounted) return;
      setState(() {
        _categories = list
            .whereType<Map>()
            .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      });
    }).catchError((_) {});
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _city.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await _api.registerBusiness(
        name: _name.text.trim(),
        phone: _phone.text.trim(),
        city: _city.text.trim(),
        description: _desc.text.trim(),
        denominations: const [10000, 20000, 50000, 100000],
        categoryIds: _selectedCats.toList(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your shop is live. You can design card amounts next.')),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (_) => false,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cream,
      appBar: AppBar(
        title: const Text('Set up your shop'),
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: !widget.fromSignup,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Customers will see this when they buy your gift cards.',
              style: TextStyle(height: 1.4),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(labelText: 'Shop name'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phone,
              decoration: const InputDecoration(labelText: 'Shop phone'),
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _city,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _desc,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Describe your cards / brand',
              ),
            ),
            if (_categories.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Categories', style: TextStyle(fontWeight: FontWeight.w700)),
              Wrap(
                spacing: 8,
                children: _categories
                    .map(
                      (c) => FilterChip(
                        label: Text(c.name),
                        selected: _selectedCats.contains(c.id),
                        onSelected: (on) {
                          setState(() {
                            if (on) {
                              _selectedCats.add(c.id);
                            } else {
                              _selectedCats.remove(c.id);
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Publish shop'),
            ),
          ],
        ),
      ),
    );
  }
}
