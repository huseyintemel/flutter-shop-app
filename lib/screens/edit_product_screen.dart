import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
    final priceFocusNode = FocusNode();
    final descriptionFocusNode = FocusNode();
    final imageUrlController = TextEditingController();
    final imageFocusNode = FocusNode();
    final form = GlobalKey<FormState>();
    var editedProduct = Product(id: '', title: '', description: '', price: 0, imageUrl: '');
    @override
    void initState() {
      imageFocusNode.addListener(updateImageUrl);

      super.initState();
    }
    
    @override
    void dispose(){
      imageUrlController.dispose();
      priceFocusNode.dispose();
      descriptionFocusNode.dispose();

      super.dispose();
    }
    void updateImageUrl(){
      if(!imageFocusNode.hasFocus){
        setState(() {
          
        });
      }
    }

    void saveForm(){
      final isValid = form.currentState?.validate();
      if(!isValid!){
        return;
      }
      form.currentState?.save();
      Provider.of<Products>(context,listen: false).addProduct(editedProduct);
      Navigator.of(context).pop();
    }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product'),actions: [
        IconButton(icon:const Icon(Icons.save),onPressed: (){
          saveForm();
        },)
      ],),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: form,
          child: ListView(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title',),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(priceFocusNode),
              validator: (value){
                if(value!.isEmpty){
                  return 'Please enter a text';
                }
                return null;
              },
              onSaved: (value){
                editedProduct = Product(id: editedProduct.id, title: value!, description: editedProduct.description, price: editedProduct.price, imageUrl: editedProduct.imageUrl);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price',),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: priceFocusNode,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(descriptionFocusNode),
              validator: (value){
                if(value!.isEmpty){
                  return 'Please enter a price';
                }
                if(double.tryParse(value) == null ){
                  return 'Please enter a valid price';
                }
                if(double.parse(value) <= 0 ){
                  return 'Price should be greater than zero';
                }
                return null;
              },
              onSaved: (value){
                editedProduct = Product(id: editedProduct.id, title: editedProduct.title, description: editedProduct.description, price: double.parse(value!), imageUrl: editedProduct.imageUrl);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description',),
              maxLines : 3,
              keyboardType: TextInputType.multiline,
              focusNode : descriptionFocusNode,
              validator: (value){
                if(value!.isEmpty){
                  return 'Please enter a description';
                }
                if(value.length < 10 ){
                  return 'Please enter a long text';
                }
                return null;
              },
              onSaved: (value){
                editedProduct = Product(id: editedProduct.id, title: editedProduct.title, description: value!, price: editedProduct.price, imageUrl: editedProduct.imageUrl);
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width:100,
                  height: 100,
                  margin: const EdgeInsets.all(8),
                  decoration : BoxDecoration(border: Border.all(width: 1,color: Colors.grey)),
                  child: Container(
                    child: imageUrlController.text.isEmpty ? const Text('Enter a image url') : FittedBox(child: Image.network(imageUrlController.text,fit: BoxFit.cover,)), 
                  ),
                ),
                 Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image Url',),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: imageFocusNode,
                      controller:imageUrlController,
                      onFieldSubmitted: (_){
                        saveForm();
                      },
                      onEditingComplete: (){
                        setState(() {
                          
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter a url';
                        }
                        if(!value.startsWith('http') && !value.startsWith('https')){
                          return 'Please enter valid url';
                        }
                        return null;
                      },
                      onSaved: (value){
                        editedProduct = Product(id: editedProduct.id, title: editedProduct.title, description: editedProduct.description, price: editedProduct.price, imageUrl: value!);
                      },
                    ),
                 ),
              ],
            )
          ],),
        ),
      ),
    );
  }
}