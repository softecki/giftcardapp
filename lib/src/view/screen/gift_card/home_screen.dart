import 'package:flutter/material.dart';
import 'package:malipo_agent/core/app_color.dart';
import 'package:malipo_agent/services/gift_card_api_service.dart';
import 'package:malipo_agent/models/user_model.dart';
import 'marketplace_screen.dart';
import 'my_gift_cards_screen.dart';
import 'wallet_screen.dart';
import 'business_dashboard_screen.dart';
import 'business_register_screen.dart';

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

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final response = await _apiService.getMe();
      if (mounted) {
        setState(() {
          _user = UserModel.fromJson(response['data']['user']);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<Widget> _buildScreens() {
    if (_user == null) {
      return [
        const Center(child: CircularProgressIndicator()),
        const Center(child: CircularProgressIndicator()),
        const Center(child: CircularProgressIndicator()),
      ];
    }

    if (_user!.role == 'business_owner') {
      return [
        const BusinessDashboardScreen(),
        const MarketplaceScreen(),
        const WalletScreen(),
      ];
    } else {
      return [
        const MarketplaceScreen(),
        const MyGiftCardsScreen(),
        const WalletScreen(),
      ];
    }
  }

  List<BottomNavigationBarItem> _buildBottomNavItems() {
    if (_user == null) {
      return [];
    }

    if (_user!.role == 'business_owner') {
      return [
        const BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Marketplace',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Wallet',
        ),
      ];
    } else {
      return [
        const BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Marketplace',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'My Cards',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Wallet',
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final screens = _buildScreens();
    final navItems = _buildBottomNavItems();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _user?.role == 'business_owner' ? 'Business Dashboard' : 'Gift Cards',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _apiService.logout();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: navItems,
        selectedItemColor: AppColor.primaryColor,
      ),
      floatingActionButton: _user?.role == 'business_owner' &&
              _user?.business == null
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BusinessRegisterScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add_business),
              label: const Text('Register Business'),
            )
          : null,
    );
  }
}

