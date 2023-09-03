import 'package:e_commerce_app/layout/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);
  static String id = 'layoutscreen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutState>(
    builder: (context, state) {
      final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: thirdColor,
        elevation: 0,
        title: Image.asset('assets/images/—Pngtree—online shopping logo desing_8918925.png',width: 80,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cubit.bottomNavIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey,
        onTap: (index){
          cubit.ChangeBottomNavBar(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label:'Home' ),
          BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile')
        ],
      ),
      body: cubit.layoutScreens[cubit.bottomNavIndex],
    );
  },
);
  }
}
