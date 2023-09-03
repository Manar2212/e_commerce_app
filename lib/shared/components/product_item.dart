import 'package:e_commerce_app/layout/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProductItem extends StatelessWidget {
   ProductItem({Key? key,required this.productModel,required this.cubit}) : super(key: key);

  ProductModel productModel;
  LayoutCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            productModel.discount != 0 ? Container(
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text('${productModel.discount}% off',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ) : SizedBox(height: 0,),
            Expanded(child: Image.network(productModel.image,fit: BoxFit.fill,)),
            SizedBox(height: 8,),

            Text(productModel.name,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('${productModel.price}\$',style: TextStyle(color: fourthColor,fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    productModel.discount == 0 ? Text(''):Text('${productModel.oldPrice}\$',style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),),
                  ],
                ),
                 GestureDetector(
                   child: Icon(Icons.favorite,color: cubit.favoritesID.contains(productModel.id.toString())  ? Colors.red : Colors.grey ),
                   onTap: (){
                     cubit.addOrRemoveFavoritesProducts(productID: productModel.id.toString());
                   },
                 ),
              ],
            ),
            SizedBox(height: 5,),
            OutlinedButton(
              onPressed: (){
                cubit.addOrRemoveCartData(productID: productModel.id.toString());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add to Cart',style: TextStyle(fontWeight: FontWeight.bold,color: fifthColor),),
                   Icon(Icons.shopping_bag_rounded,color: cubit.cartsID.contains(productModel.id.toString()) ? fourthColor : Colors.grey)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
