import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:na_dom/Widgets/hive_metod.dart';
import 'package:na_dom/screens/personalScreens/AboutThePetPage.dart';
import 'package:na_dom/screens/mainScreens/AllBrendsPage.dart';
import 'package:na_dom/screens/catalog/AllTypesOfCormPage.dart';
import 'package:na_dom/screens/mainScreens/BrendPage.dart';
import 'package:na_dom/screens/cart/CartPage.dart';
import 'package:na_dom/screens/catalog/CatalogPage.dart';
import 'package:na_dom/screens/cart/DeliveryAddressPage.dart';
import 'package:na_dom/screens/faworiteProducts/FavoriteProductsPage.dart';
import 'package:na_dom/screens/catalog/FilterPage.dart';
import 'package:na_dom/screens/mainScreens/MainPage.dart';
import 'package:na_dom/screens/personalScreens/MyDataPage.dart';
import 'package:na_dom/screens/order%20history/OrderDetailsPage.dart';
import 'package:na_dom/screens/order%20history/OrderHistoryPage.dart';
import 'package:na_dom/screens/personalScreens/PersonalAccountPage.dart';
import 'package:na_dom/screens/cart/PlacingAnOrderPage.dart';
import 'package:na_dom/screens/catalog/ProductPage.dart';
import 'package:na_dom/screens/catalog/JustShopPage.dart';
import 'package:na_dom/screens/sign/WelcomePage.dart';
import 'package:na_dom/screens/sign/sign_up.dart';
import 'package:na_dom/screens/sign/sign_verifiction_page.dart';
import 'package:path_provider/path_provider.dart';

import 'design.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...







void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  var UserStatus = await FirebaseAuth.instance.currentUser;

  runApp(MyApp(user_status: UserStatus,));
}

class MyApp extends StatelessWidget {
  final user_status;
  MyApp({super.key,required this.user_status});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: colorBottomNavigationBar,
              selectedItemColor: colorRed,
              unselectedItemColor: colorBlack
          )
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return CustomPageRoute(
              builder: (context) => user_status==null ? WelcomePage() : MainPage()
            );
          case '/mainPage':
            return CustomPageRoute(
              builder: (context) => const MainPage());
          case 'signUpPage':
            return CustomPageRoute(
              builder: (context) => SignUpPage(is_sign_up: true,),
            );
          case 'signVerificationPage':
            return CustomPageRoute(
                builder: (context) => SignVerificationPage(nomber: null, name: null, is_sign_in: null,),
            );
          case '/personalAccountPage':
            return CustomPageRoute(
              builder: (context) => PersonalAccountPage(),
            );
          case '/orderHistoryPage':
            return CustomPageRoute(
              builder: (context) => const OrderHistoryPage());
          case '/myDataPage':
            return CustomPageRoute(
              builder: (context) => const MyDataPage());
          case '/cartPage':
            return CustomPageRoute(
              builder: (context) => const CartPage());
          case '/deliveryAddressPage':
            return CustomPageRoute(
              builder: (context) => const DeliveryAddressPage(address: {},));
          case '/aboutThePetPage':
            return CustomPageRoute(
              builder: (context) => const AboutThePetPage(pet: "",));
          case '/placingAnOrderPage':
            return CustomPageRoute(
              builder: (context) => const PlacingAnOrderPage());
          case '/filterPage':
            return CustomPageRoute(
              builder: (context) => const FilterPage());
          case '/allBrendsPage':
            return CustomPageRoute(
              builder: (context) => const AllBrendsPage());
          case '/productPage':
            return CustomPageRoute(
              builder: (context) => const ProductPage(docID: 'mmm',));
          case '/orderDetailsPage':
            return CustomPageRoute(
              builder: (context) => const OrderDetailsPage(order: {},));
          case '/catalogPage':
            return CustomPageRoute(
              builder: (context) => const CatalogPage());
          case '/favoriteProductsPage':
            return CustomPageRoute(
                builder: (context) => const FavoriteProductsPage());
          case '/allTypesOfCormPage':
            return CustomPageRoute(
              builder: (context) => const AllTypesOfCormPage());
          // case '/suhoyCormPage':
          //   return CustomPageRoute(
          //     builder: (context) => const SuhoyCormPage());
          case '/brandPage':
            return CustomPageRoute(
              builder: (context) => const BrendPage(brendID: "f",));
          default:
            return null;
        }
      },
    );
  }
}

class CustomPageRoute<T> extends PageRoute<T> {
  CustomPageRoute({required this.builder});

  final WidgetBuilder builder;

  @override
  Color get barrierColor => Colors.black;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    final curve = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
    return FadeTransition(
      opacity: curve,
      child: builder(context),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
}