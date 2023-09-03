import 'package:e_commerce_app/layout/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_app/layout/layout_screen.dart';
import 'package:e_commerce_app/modules/screens/auth_screens/auth_cubits/auth_cubit.dart';
import 'package:e_commerce_app/modules/screens/auth_screens/login_screen.dart';
import 'package:e_commerce_app/modules/screens/auth_screens/register_screen.dart';
import 'package:e_commerce_app/modules/screens/categories_screen.dart';
import 'package:e_commerce_app/modules/screens/change_password_screen.dart';
import 'package:e_commerce_app/modules/screens/home_screen.dart';
import 'package:e_commerce_app/modules/screens/profile_screen.dart';
import 'package:e_commerce_app/modules/screens/update_user_data_screen.dart';
import 'package:e_commerce_app/shared/constants/constants.dart';
import 'package:e_commerce_app/shared/network/local/local_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/screens/splash_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();
  token =  CacheNetwork.getCacheData(key: 'token');
  currentPassword = CacheNetwork.getCacheData(key: 'password');
  print('token is : $token , and currentPassword is : $currentPassword');
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor customPrimaryColor = MaterialColor(0xfff79418,
    {
      50:Color(0xffde6600),
      100:Color(0xffde6600),
      200:Color(0xffde6600),
      300:Color(0xffde6600),
      400:Color(0xffde6600),
      500:Color(0xffde6600),
      600:Color(0xffde6600),
      700:Color(0xffde6600),
      800:Color(0xffde6600),
      900:Color(0xffde6600),
    }
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => LayoutCubit()..getCartsData()..getFavoritesProducts()..getBannerData()..getCategoriesData()..getProductsData()),
      ],
      child: MaterialApp(
        routes: {
          HomeScreen.id : (context) => HomeScreen(),
          RegisterScreen.id : (context) => RegisterScreen(),
          LoginScreen.id :(context) => LoginScreen(),
          ProfileScreen.id :(context) => ProfileScreen(),
          LayoutScreen.id :(context) => LayoutScreen(),
          ChangePasswordScreen.id :(context) => ChangePasswordScreen(),
          UpdateUserDataScreen.id :(context) => UpdateUserDataScreen(),
          'splashscreen' :(context) => SplashScreen(),
        },
        initialRoute: 'splashscreen' ,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: customPrimaryColor,
        ),
      ),
    );
  }
}
