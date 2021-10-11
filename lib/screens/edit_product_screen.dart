import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product'),),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title',),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(priceFocusNode),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price',),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: priceFocusNode,
              onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(descriptionFocusNode),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description',),
              maxLines : 3,
              keyboardType: TextInputType.multiline,
              focusNode : descriptionFocusNode,
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
                      onEditingComplete: (){
                        setState(() {
                          
                        });
                      }
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