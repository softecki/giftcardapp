import 'package:flutter/material.dart';
import 'package:malipo_agent/core/app_color.dart';
import 'package:malipo_agent/services/gift_card_api_service.dart';
import 'package:malipo_agent/models/user_model.dart';
import 'login_screen.dart' as gift_card_login;
import 'marketplace_screen.dart';
import 'my_gift_cards_screen.dart';
import 'wallet_screen.dart';
import 'business_dashboard_screen.dart';
import 'business_register_screen.dart';
import 'design_cards_screen.dart';
import 'redeem_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  UserModel? _user;
  bool _isLoading = true;

  final _apiService = GiftCardApiService();

  bool get _isMerchant => _user?.role == 'business_owner';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final response = await _apiService.getMe();
      if (!mounted) return;
      final payload = response['data'];
      dynamic userJson;
      if (payload is Map) {
        userJson = payload['user'] ?? payload;
      }
      UserModel? user;
      if (userJson is Map) {
        try {
          user = UserModel.fromJson(Map<String, dynamic>.from(userJson));
        } catch (_) {
          user = null;
        }
      }
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<Widget> _screens() {
    if (_user == null) {
      return [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Could not load profile. Log out and try again.',
                  textAlign: TextAlign.center,
                ),
                TextButton(onPressed: _loadUser, child: const Text('Retry')),
              ],
            ),
          ),
        ),
        const Center(child: Text('')),
      ];
    }
    if (_isMerchant) {
      if (_user!.business == null) {
        return [
          _SetupShop(
            onSetup: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const BusinessRegisterScreen(),
                ),
              );
              _loadUser();
            },
          ),
          const WalletScreen(),
        ];
      }
      return const [
        BusinessDashboardScreen(),
        DesignCardsScreen(),
        RedeemScreen(),
        WalletScreen(),
      ];
    }
    return const [
      MarketplaceScreen(),
      MyGiftCardsScreen(),
      WalletScreen(),
    ];
  }

  List<BottomNavigationBarItem> _nav() {
    if (_user == null) {
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
      ];
    }
    if (_isMerchant && _user!.business == null) {
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Shop'),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_outlined),
          label: 'Wallet',
        ),
      ];
    }
    if (_isMerchant) {
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.palette_outlined), label: 'Cards'),
        BottomNavigationBarItem(icon: Icon(Icons.qr_code_scanner), label: 'Redeem'),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
      ];
    }
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), label: 'Shop'),
      BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'My cards'),
      BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final screens = _screens();
    final nav = _nav();
    final index = _currentIndex.clamp(0, screens.length - 1);

    return Scaffold(
      backgroundColor: AppColor.cream,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isMerchant ? 'Merchant' : 'GiftCard',
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
            if (_user?.name != null)
              Text(
                _user!.name,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
          ],
        ),
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await _apiService.logout();
              } catch (_) {}
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const gift_card_login.LoginScreen(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColor.primaryColor,
        unselectedItemColor: Colors.grey[600],
        currentIndex: index,
        onTap: (i) {
          setState(() => _currentIndex = i);
        },
        items: nav,
      ),
    );
  }
}

class _SetupShop extends StatelessWidget {
  const _SetupShop({required this.onSetup});

  final VoidCallback onSetup;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.storefront, size: 72, color: AppColor.primaryColor),
          const SizedBox(height: 16),
          const Text(
            'Finish setting up your shop',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your shop name and card amounts so customers can buy, then redeem codes in the app.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700], height: 1.4),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onSetup,
            child: const Text('Create shop'),
          ),
        ],
      ),
    );
  }
}
