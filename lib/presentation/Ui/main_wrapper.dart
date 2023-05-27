
import 'package:crypto_currency/presentation/Ui/Ui_helper/Bottom_nav.dart';
import 'package:crypto_currency/presentation/Ui/home_page.dart';
import 'package:crypto_currency/presentation/Ui/market_view_page.dart';
import 'package:crypto_currency/presentation/Ui/profile_page.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController _myPage = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.compare_arrows_outlined),
      ),
      bottomNavigationBar: BottomNav(
        pageController: _myPage,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        controller: _myPage,
        children: const [
          HomePage(),
          MarketViewPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
