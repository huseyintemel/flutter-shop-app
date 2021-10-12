import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id,this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(icon: const Icon(Icons.edit),onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
            },),
            IconButton(icon: Icon(Icons.delete,color: Theme.of(context).errorColor,),onPressed: (){},),
          ],
        ),
      ),
    );
  }
}