import 'package:flutter/material.dart';

class AsyncChallengeScreen extends StatefulWidget {
  const AsyncChallengeScreen({super.key});

  @override
  State<AsyncChallengeScreen> createState() => _AsyncChallengeScreenState();
}

class _AsyncChallengeScreenState extends State<AsyncChallengeScreen> {
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _products = [
        {'id': 1, 'name': 'Laptop', 'price': 999.99},
        {'id': 2, 'name': 'Mouse', 'price': 29.99},
        {'id': 3, 'name': 'Keyboard', 'price': 79.99},
        {'id': 4, 'name': 'Monitor', 'price': 299.99},
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Intentional flaw: This calls the async method on every rebuild!
    _loadProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products (Buggy)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProducts,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  title: Text(product['name']),
                  subtitle: Text('\$${product['price']}'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(productId: product['id']),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Map<String, dynamic>? _productDetail;

  @override
  void initState() {
    super.initState();
    _loadProductDetail();
  }

  Future<void> _loadProductDetail() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _productDetail = {
        'id': widget.productId,
        'name': 'Product ${widget.productId}',
        'price': 99.99,
        'description': 'Detailed description for product ${widget.productId}',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: _productDetail == null
          ? Container() // Loading state is just a blank screen (bad UX)
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _productDetail!['name'],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${_productDetail!['price']}',
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  Text(_productDetail!['description']),
                ],
              ),
            ),
    );
  }
}
