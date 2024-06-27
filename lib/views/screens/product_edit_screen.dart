import 'package:dars64_statemanagement/controllers/products_controller.dart';
import 'package:dars64_statemanagement/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductEditScreen extends StatefulWidget {
  final Product? product;

  ProductEditScreen({this.product, super.key});

  @override
  _ProductEditScreenState createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late double _price;
  late Color _color;

  @override
  void initState() {
    super.initState();
    _title = widget.product?.title ?? '';
    _price = widget.product?.price ?? 0.0;
    _color = widget.product?.color ?? Colors.white;
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if (widget.product == null) {
        Provider.of<ProductsController>(context, listen: false).addProduct(
          Product(
            id: UniqueKey().toString(),
            title: _title,
            price: _price,
            color: _color,
          ),
        );
      } else {
        Provider.of<ProductsController>(context, listen: false).updateProduct(
          widget.product!.id,
          _title,
          _price,
          _color,
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Yangi mahsulot' : 'Mahsulotni tahrirlash'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _title = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _price = double.parse(value ?? '0');
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero.';
                  }
                  return null;
                },
              ),
              // Add more fields as necessary, like a color picker
            ],
          ),
        ),
      ),
    );
  }
}
