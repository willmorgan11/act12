import 'package:flutter/material.dart';
import '../models/items.dart';

// Reusable form for adding and editing items with validation
class ItemForm extends StatefulWidget {
  final Item? item;
  final Function(Item) onSubmit;

  const ItemForm({super.key, this.item, required this.onSubmit});

  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _priceController = TextEditingController(
        text: widget.item?.price.toString() ?? '');
    _quantityController = TextEditingController(
        text: widget.item?.quantity.toString() ?? '');
    _categoryController = TextEditingController(text: widget.item?.category ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Item Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an item name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _priceController,
            decoration: const InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a price';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              if (double.parse(value) < 0) {
                return 'Price cannot be negative';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _quantityController,
            decoration: const InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter quantity';
              }
              final intValue = int.tryParse(value);
              if (intValue == null) {
                return 'Please enter a valid number';
              }
              if (intValue < 0) {
                return 'Quantity cannot be negative';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _categoryController,
            decoration: const InputDecoration(labelText: 'Category'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a category';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final item = Item(
                  id: widget.item?.id ?? '',
                  name: _nameController.text,
                  price: double.parse(_priceController.text),
                  quantity: int.parse(_quantityController.text),
                  category: _categoryController.text,
                  createdAt: widget.item?.createdAt ?? DateTime.now(),
                );
                widget.onSubmit(item);
                Navigator.pop(context);
              }
            },
            child: Text(widget.item == null ? 'Add Item' : 'Update Item'),
          ),
        ],
      ),
    );
  }
}