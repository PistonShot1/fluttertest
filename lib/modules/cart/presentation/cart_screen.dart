import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/core/shared/components/default_network_image.dart';
import 'package:fluttertest/modules/cart/riverpod/cart_notifier.dart';
import 'package:fluttertest/modules/search/data/entities/model/product.dart';
import 'package:intl/intl.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLow,
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        left: false,
        right: false,
        child: cartState.map(
          data: (data) {
            final cartProducts = data.value.cartProducts;
            if (cartProducts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 64,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your cart is empty',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              );
            }

            // Calculate totals
            double subtotal = 0;
            for (var cartProduct in cartProducts) {
              if (cartProduct.product?.price != null) {
                subtotal +=
                    cartProduct.product!.price! * cartProduct.cartItem.quantity;
              }
            }
            final total = subtotal;

            return Column(
              children: [
                // Cart Items List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      final cartProduct = cartProducts[index];
                      return _buildCartItemCard(
                        context,
                        cartProduct,
                        colorScheme,
                        theme,
                      );
                    },
                  ),
                ),

                // Order Summary
                _buildOrderSummary(
                  context,
                  subtotal,
                  total,
                  colorScheme,
                  theme,
                ),
              ],
            );
          },
          loading: (loading) =>
              Center(child: CircularProgressIndicator.adaptive()),
          error: (error) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: colorScheme.error),
                const SizedBox(height: 16),
                Text(
                  'Error loading cart',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.error,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error.error.toString(),
                  style: theme.textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartItemCard(
    BuildContext context,
    dynamic cartProduct,
    ColorScheme colorScheme,
    ThemeData theme,
  ) {
    final product = cartProduct.product;
    final cartItem = cartProduct.cartItem;
    final quantity = cartItem.quantity;
    final price = product?.price ?? 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: product?.image != null
                ? DefaultNetworkImage(
                    pathURL: product!.image!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    radius: 8,
                  )
                : Container(
                    width: 80,
                    height: 80,
                    color: colorScheme.surfaceContainer,
                    child: Icon(
                      Icons.image_outlined,
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
          ),
          const SizedBox(width: 12),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.title ?? 'Unknown Product',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product?.category ?? '',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${NumberFormat('#,##0.00').format(price)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Quantity Controls
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Delete Button
              IconButton(
                onPressed: () async => await _deleteHandler(product),
                icon: Icon(Icons.delete_outline, color: colorScheme.primary),
                style: IconButton.styleFrom(
                  backgroundColor: colorScheme.primaryContainer.withValues(
                    alpha: 0.2,
                  ),
                ),
              ),
              Row(
                children: [
                  // Minus Button
                  IconButton(
                    onPressed: () async =>
                        await _minusHandler(product, quantity),
                    icon: Icon(
                      Icons.remove,
                      size: 20,
                      color: colorScheme.onSurface,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.surfaceContainer,
                      minimumSize: const Size(32, 32),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  // Quantity Display
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      quantity.toString(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Plus Button
                  IconButton(
                    onPressed: () async => await _addHandler(product, quantity),
                    icon: Icon(
                      Icons.add,
                      size: 20,
                      color: colorScheme.onSurface,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.surfaceContainer,
                      minimumSize: const Size(32, 32),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(
    BuildContext context,
    double subtotal,
    double total,
    ColorScheme colorScheme,
    ThemeData theme,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            context,
            'Subtotal',
            subtotal,
            colorScheme,
            theme,
            isTotal: false,
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            context,
            'Total',
            total,
            colorScheme,
            theme,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    double amount,
    ColorScheme colorScheme,
    ThemeData theme, {
    required bool isTotal,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: colorScheme.onSurface,
          ),
        ),
        Text(
          '\$${NumberFormat('#,##0.00').format(amount)}',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Future<void> _addHandler(Product product, int quantity) async {
    await ref
        .read(cartProvider.notifier)
        .incrementCartItem(product, quantity + 1);
  }

  Future<void> _minusHandler(Product product, int quantity) async {
    if (quantity <= 0) {
      return;
    }
    ref.read(cartProvider.notifier).decreaseCartItem(product, quantity - 1);
  }

  Future<void> _deleteHandler(Product product) async {
    ref.read(cartProvider.notifier).deleteCartItem(product);
  }
}
