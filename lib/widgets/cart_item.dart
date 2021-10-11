import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id,this.productId,this.price,this.quantity,this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background : Container(
        color: Theme.of(context).errorColor,
        child: const Icon(Icons.delete,size:32,color: Colors.white,),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
      ),
      onDismissed: (direction){
          Provider.of<Cart>(context,listen: false).removeItem(productId);
      },
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showDialog(context: context, builder: (ctx){
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to remove item from cart?'),
            actions: [
              TextButton(child: const Text('No'),onPressed: () => Navigator.of(ctx).pop(false),style: TextButton.styleFrom(
                primary:Colors.blueGrey.shade700,
              ),),
              TextButton(
              child: const Text('Yes'),
              onPressed: () => Navigator.of(ctx).pop(true),
              style: TextButton.styleFrom(
                backgroundColor: Colors.redAccent,
                primary: Colors.white,
              ),
              ),
            ],
          );
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4,horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(child: Padding(padding: const EdgeInsets.all(6),child: FittedBox(child: Text('\$$price'))),),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}