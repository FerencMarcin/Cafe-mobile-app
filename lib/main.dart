import 'package:cafe_mobile_app/theme/colors.dart';
import 'package:cafe_mobile_app/view/aboutUs_view.dart';
import 'package:cafe_mobile_app/view/login_view.dart';
import 'package:cafe_mobile_app/view/homePage_view.dart';
import 'package:cafe_mobile_app/view/newReservation_view.dart';
import 'package:cafe_mobile_app/view/orderDetails_view.dart';
import 'package:cafe_mobile_app/view/products_view.dart';
import 'package:cafe_mobile_app/view/registration_view.dart';
import 'package:cafe_mobile_app/view/resetPassword_view.dart';
import 'package:cafe_mobile_app/view/startViewManager.dart';
import 'package:cafe_mobile_app/view/unauthenticatedUser_view.dart';
import 'package:cafe_mobile_app/view/userOrders_view.dart';
import 'package:cafe_mobile_app/view/userProfile_view.dart';
import 'package:cafe_mobile_app/view/userReservations_view.dart';
import 'package:cafe_mobile_app/view/vouchers_view.dart';
import 'package:cafe_mobile_app/view/userVouchers_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'view/initial_view.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final String title = 'My cafe';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.darkGoldenrodMap,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pl', ''), // English, no country code
      ],
      home: InitialView(),
      routes: {
        '/start':(context) => const StartView(),
        '/unauthenticated':(context) => const UnauthenticatedUserView(),
        '/login':(context) => const LoginView(),
        '/registration':(context) => const RegistrationView(),
        '/resetPassword':(context) => const ResetPasswordView(),
        '/home':(context) => const HomePageView(),
        '/menu':(context) => const ProductsView(),
        '/vouchers':(context) => const VouchersView(),
        '/userVouchers':(context) => const UserVouchersView(),
        '/userProfile':(context) => const UserProfileView(),
        '/aboutUs':(context) => const AboutUsView(),
        '/userOrders':(context) => const UserOrdersView(),
        '/orderDetails':(context) => const OrderDetailsView(),
        '/userReservations':(context) => const UserReservationsView(),
        '/newReservation':(context) => const NewReservationView()
      },
    );
  }
}
