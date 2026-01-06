import 'package:flutter/material.dart';

enum LoadingState { idle, loading, success, error }

class AsyncSolutionScreen extends StatefulWidget {
  const AsyncSolutionScreen({super.key});

  @override
  State<AsyncSolutionScreen> createState() => _AsyncSolutionScreenState();
}

class _AsyncSolutionScreenState extends State<AsyncSolutionScreen> {
  List<Map<String, dynamic>> _products = [];
  LoadingState _loadingState = LoadingState.idle;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _loadingState = LoadingState.loading;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));

      final products = [
        {'id': 1, 'name': 'Laptop', 'price': 999.99},
        {'id': 2, 'name': 'Mouse', 'price': 29.99},
        {'id': 3, 'name': 'Keyboard', 'price': 79.99},
        {'id': 4, 'name': 'Monitor', 'price': 299.99},
      ];

      if (mounted) {
        setState(() {
          _products = products;
          _loadingState = LoadingState.success;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadingState = LoadingState.error;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products (Fixed)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProducts,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_loadingState) {
      case LoadingState.loading:
        return const Center(child: CircularProgressIndicator());
      case LoadingState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(_errorMessage ?? 'An error occurred'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadProducts,
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      case LoadingState.success:
        if (_products.isEmpty) {
          return const Center(
            child: Text('No products available'),
          );
        }
        return ListView.builder(
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
        );
      case LoadingState.idle:
        return const Center(child: Text('Initializing...'));
    }
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
  LoadingState _loadingState = LoadingState.idle;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProductDetail();
  }

  Future<void> _loadProductDetail() async {
    setState(() {
      _loadingState = LoadingState.loading;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));

      final detail = {
        'id': widget.productId,
        'name': 'Product ${widget.productId}',
        'price': 99.99,
        'description': 'Detailed description for product ${widget.productId}',
      };

      if (mounted) {
        setState(() {
          _productDetail = detail;
          _loadingState = LoadingState.success;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadingState = LoadingState.error;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_loadingState) {
      case LoadingState.loading:
        return const Center(child: CircularProgressIndicator());
      case LoadingState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(_errorMessage ?? 'Failed to load product'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadProductDetail,
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      case LoadingState.success:
        return Padding(
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
        );
      case LoadingState.idle:
        return const Center(child: Text('Preparing...'));
    }
  }
}
