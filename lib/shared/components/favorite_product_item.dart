import 'package:e_commerce_app/layout/layout_cubit/layout_cubit.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../shared/constants/constants.dart';

class FavoriteProductItem extends StatelessWidget {
   FavoriteProductItem({Key? key,required this.productModel,required this.cubit}) : super(key: key);
ProductModel productModel;
LayoutCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: thirdColor,
      margin: EdgeInsets.only(top:10,bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(productModel.image,fit: BoxFit.fill,width: 100,height: 100,),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                children: [
                  Text(productModel.name,style: TextStyle(color: fifthColor,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold),maxLines: 1,),
                  SizedBox(height: 5,),
                  Text('${productModel.price}\$',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  MaterialButton(onPressed: (){
                    cubit.addOrRemoveFavoritesProducts(productID: productModel.id.toString());
                  },
                    child: Text('Remove',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                    elevation: 3,
                    color: fourthColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
