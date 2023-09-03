import 'package:e_commerce_app/layout/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_app/modules/screens/change_password_screen.dart';
import 'package:e_commerce_app/modules/screens/update_user_data_screen.dart';
import 'package:e_commerce_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/custome_listTile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String id = 'profilescreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit()..getUserData(),
      child: BlocBuilder<LayoutCubit, LayoutState>(
        builder: (context, state) {
          final cubit = BlocProvider.of<LayoutCubit>(context);
          return Scaffold(
            body:cubit.userModel != null ?
            Padding(
              padding: const EdgeInsets.only(top:20,left: 20,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration:   BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 5,
                        color: Colors.white,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(cubit.userModel!.image!),
                      radius: 60,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(cubit.userModel!.name!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: fifthColor),),
                  SizedBox(height: 10,),
                  Text(cubit.userModel!.email!,style: TextStyle(fontSize: 15,color: Colors.grey),),
                  SizedBox(height: 10,),
                  Text(cubit.userModel!.phone!,style: TextStyle(fontSize: 15,color: Colors.grey),),
                  SizedBox(height: 10,),
                  Expanded(child: ListView(
                    children: [
                      CustomeListTile(title: 'Update Data', icon:Icons.person,onTap: (){
                        Navigator.pushNamed(context, UpdateUserDataScreen.id);
                      },),
                      SizedBox(height: 10,),
                      CustomeListTile(title: 'Orders', icon: Icons.shopping_bag_rounded,onTap: (){},),
                      SizedBox(height: 10,),
                      CustomeListTile(title: 'Addresses', icon: Icons.directions_bus, onTap: (){}),
                      SizedBox(height: 10,),
                      CustomeListTile(title: 'Change Password', icon: Icons.lock_outline,onTap: (){
                        Navigator.pushNamed(context, ChangePasswordScreen.id);
                      },),
                      SizedBox(height: 10,),
                      CustomeListTile(title: 'Log out', icon: Icons.exit_to_app,onTap: (){},),
                      SizedBox(height: 10,),
                    ],
                  ))
                ],
              ),
            ):Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
