import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;

    final loadedProduct = Provider.of<Products>(context).findById(productId);

    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title),),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: Image.network(loadedProduct.imageUrl,fit: BoxFit.cover,),
          ),
          const SizedBox(height: 10,),
          Text('\$${loadedProduct.price}',style: const TextStyle(fontSize: 24,color: Colors.grey),),
          const SizedBox(height: 10,),
          Text(loadedProduct.description,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}