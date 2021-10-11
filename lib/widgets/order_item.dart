import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(icon: expanded ? const Icon(Icons.expand_less) : const Icon(Icons.expand_more),onPressed: (){
              setState(() {
                expanded = !expanded;
              });
            },),
          ),
          if(expanded)
            Container(
              padding:const EdgeInsets.all(12),
              height: min(widget.order.products.length * 20.0 + 40,180),
              width: double.infinity,
              child: ListView(
                children: widget.order.products.map((prod) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(prod.title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Text('${prod.quantity}x  \$${prod.price}',style: const TextStyle(color: Colors.grey),)
                  ],
                )).toList(),
              ),
            )
        ],
      ),
    );
  }
}