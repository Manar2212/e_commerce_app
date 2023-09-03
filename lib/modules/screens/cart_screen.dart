import 'package:e_commerce_app/layout/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_app/shared/components/cart_product_item.dart';
import 'package:e_commerce_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<LayoutCubit>(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Expanded(
                  child: cubit.carts.isNotEmpty ?
                  ListView.builder(itemBuilder: (context,index){
                    return CartProductItem(productModel: cubit.carts[index], cubit: cubit);
                  }, itemCount:cubit.carts.length): Center(child: CircularProgressIndicator()),
                ) ,
                Container(
                  width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: thirdColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(child: Text('TotalPrice : ${cubit.totalPrice} \$',style: TextStyle(fontWeight: FontWeight.bold,color: fourthColor,fontSize: 20),))),
              ],
            ),
          )
        );
      },
    );
  }
}
