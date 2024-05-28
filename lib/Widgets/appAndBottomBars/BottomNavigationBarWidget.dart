import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:na_dom/screens/cart/CartPage.dart';
import 'package:na_dom/screens/catalog/CatalogPage.dart';
import 'package:na_dom/screens/mainScreens/MainPage.dart';
import 'package:na_dom/screens/order%20history/OrderHistoryPage.dart';

import '../../design.dart';
import '../../main.dart';
import '../../screens/faworiteProducts/FavoriteProductsPage.dart';

Widget BottomNavigationBarWidget ({
  required currentBottomBarIndex,
  required context,
  canGoAtChoosenPage,
  is_profile_page=false
}) {
  return BottomNavigationBar(
    currentIndex: currentBottomBarIndex,
    elevation: 1,
    selectedFontSize: 10,

    unselectedFontSize: 10,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(
        color: colorRed
    ),
    unselectedLabelStyle: TextStyle(
        color: colorBlack
    ),
    items: [
      BottomNavigationBarItem(
          icon: Padding(padding: EdgeInsets.only(top: 4,bottom: 2),child: SvgPicture.asset("lib/assets/Home.svg"),),
          activeIcon: Padding(padding: EdgeInsets.only(top: 4,bottom: 2), child: SvgPicture.asset("lib/assets/Home.svg", color: colorRed,)),
          label: "Главная"
      ),
      BottomNavigationBarItem(
          icon: Padding(padding: EdgeInsets.only(top: 4,bottom: 2),child: SvgPicture.asset("lib/assets/Category.svg"),),
          activeIcon: Padding(padding: EdgeInsets.only(top: 4,bottom: 2), child: SvgPicture.asset("lib/assets/Category.svg", color: colorRed,)),
          label: "Каталог"
      ),
      BottomNavigationBarItem(
          icon: Padding(padding: EdgeInsets.only(top: 4,bottom: 2),child: SvgPicture.asset("lib/assets/solar_delivery-bold.svg"),),
          activeIcon: Padding(padding: EdgeInsets.only(top: 4,bottom: 2), child: SvgPicture.asset("lib/assets/solar_delivery-bold.svg", color: colorRed,),),
          label: "Мои заказы"
      ),
      BottomNavigationBarItem(
          icon: Padding(padding: EdgeInsets.only(top: 4,bottom: 2),child: SvgPicture.asset("lib/assets/buy.svg"),),
          activeIcon: Padding(padding: EdgeInsets.only(top: 4,bottom: 2), child: SvgPicture.asset("lib/assets/buy.svg", color: colorRed,),),
          label: "Корзина"
      ),
      BottomNavigationBarItem( //SvgPicture.asset("lib/assets/more_square.svg") // SvgPicture.asset("lib/assets/more_square.svg", color: colorRed,)
          icon: Padding(padding: EdgeInsets.only(top: 4,bottom: 2),child: SvgPicture.asset("lib/assets/Heart2.svg")),
          activeIcon: Padding(padding: EdgeInsets.only(top: 4,bottom: 2), child: SvgPicture.asset("lib/assets/Heart2.svg", color: colorRed)),
          label: "Избранное"
      )
    ],
    onTap: (index){
      if (currentBottomBarIndex != index) {

        if (index == 0) {
          Navigator.pushAndRemoveUntil(
              context, CustomPageRoute(builder: (context) => const MainPage()),
              ModalRoute.withName('/mainPage') // Replace this with your root screen's route name (usually '/')
          );
        }
        if (index == 1) {
          Navigator.pushAndRemoveUntil(
              context, CustomPageRoute(builder: (context) => const CatalogPage()),
              ModalRoute.withName('/catalogPage') // Replace this with your root screen's route name (usually '/')
          );
        }
        if (index == 2) {
          Navigator.pushAndRemoveUntil(
              context, CustomPageRoute(builder: (context) => const OrderHistoryPage()),
              ModalRoute.withName('/orderHistoryPage') // Replace this with your root screen's route name (usually '/')
          );
        }
        if (index == 3) {
          Navigator.pushAndRemoveUntil(
              context, CustomPageRoute(builder: (context) => const CartPage()),
              ModalRoute.withName('/cartPage') // Replace this with your root screen's route name (usually '/')
          );
        }
        if (index == 4) {
          Navigator.pushAndRemoveUntil(
              context, CustomPageRoute(builder: (context) => const FavoriteProductsPage()),
              ModalRoute.withName('/favoriteProductsPage') // Replace this with your root screen's route name (usually '/')
          );
        }

      } else if (canGoAtChoosenPage == true) {

        if (index == 0) {
          Navigator.pushAndRemoveUntil(
              context, CustomPageRoute(builder: (context) => const MainPage()),
              ModalRoute.withName('/mainPage') // Replace this with your root screen's route name (usually '/')
          );
        }
        if (index == 1) {
          Navigator.pushAndRemoveUntil(
              context, CustomPageRoute(builder: (context) => const CatalogPage()),
              ModalRoute.withName('/catalogPage') // Replace this with your root screen's route name (usually '/')
          );
        }
        if (index == 2) {
          Navigator.pushAndRemoveUntil(
              context, CustomPageRoute(builder: (context) => const OrderHistoryPage()),
              ModalRoute.withName('/orderHistoryPage') // Replace this with your root screen's route name (usually '/')
          );
        }
        if (index == 3) {
          Navigator.pushAndRemoveUntil(
              context, CustomPageRoute(builder: (context) => const CartPage()),
              ModalRoute.withName('/cartPage') // Replace this with your root screen's route name (usually '/')
          );
        }
        if (index == 4) {
          Navigator.pushAndRemoveUntil(
              context, CustomPageRoute(builder: (context) => const FavoriteProductsPage()),
              ModalRoute.withName('/favoriteProductsPage') // Replace this with your root screen's route name (usually '/')
          );
        }

      }
    },
  );
}