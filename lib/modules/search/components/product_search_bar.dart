import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/modules/search/riverpod/search_state_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertest/core/router/route_constant.dart';
import 'package:fluttertest/core/shared/components/default_network_image.dart';
import 'package:fluttertest/core/shared/theme/color/app_color.dart';
import 'package:fluttertest/modules/cart/riverpod/cart_notifier.dart';
import 'package:fluttertest/modules/search/data/entities/model/product.dart';

class ProductSearchBar extends ConsumerStatefulWidget {
  final List<Product>? products;
  final Function(bool) onLoadingChanged;

  const ProductSearchBar({
    super.key,
    required this.products,
    required this.onLoadingChanged,
  });

  @override
  ConsumerState<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends ConsumerState<ProductSearchBar> {
  final SearchController _searchController = SearchController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SearchAnchor(
        searchController: _searchController,
        isFullScreen: false,
        viewConstraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        viewBuilder: (suggestions) {
          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.surfaceColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListView(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              children: suggestions.toList(),
            ),
          );
        },
        viewTrailing: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              ref.read(searchStateProvider.notifier).clearSearch();
              _searchController.closeView('');
              _searchController.clear();
              _searchFocusNode.unfocus();
            },
          ),
        ],
        viewOnSubmitted: (value) {
          ref.read(searchStateProvider.notifier).updateQuery(value);
          _searchController.closeView(value);
          _searchFocusNode.unfocus();
        },
        builder: (context, controller) {
          return SearchBar(
            focusNode: _searchFocusNode,
            controller: controller,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16),
            ),
            hintText: 'Search products...',
            leading: const Icon(Icons.search),
            trailing: controller.text.isNotEmpty
                ? [
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        ref.read(searchStateProvider.notifier).clearSearch();
                        _searchController.clear();
                        _searchFocusNode.unfocus();
                      },
                    ),
                  ]
                : null,
            onTap: () => controller.openView(),
            onChanged: (value) => controller.openView(),
            onSubmitted: (value) {
              _searchController.closeView(value);
              ref.read(searchStateProvider.notifier).updateQuery(value);
            },
          );
        },
        suggestionsBuilder: (context, controller) {
          if (controller.text.isEmpty) {
            return [_buildEmptySuggestion()];
          }

          final query = controller.text.toLowerCase();
          final suggestions =
              widget.products?.where((product) {
                final title = product.title?.toLowerCase() ?? '';
                final category = product.category?.toLowerCase() ?? '';
                return title.contains(query) || category.contains(query);
              }).toList() ??
              [];

          if (suggestions.isEmpty) {
            return [_buildNoResultsSuggestion(query)];
          }

          return suggestions.map((product) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: context.surfaceContainerColor.withOpacity(0.3),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: context.surfaceContainerColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: DefaultNetworkImage(
                      pathURL: product.image ?? '',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                title: Text(
                  product.title ?? 'N/A',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
                subtitle: Text(
                  '\$${product.price?.toStringAsFixed(2)} • ${product.category}',
                  style: TextStyle(fontSize: 12, color: context.steelDark),
                ),
                onTap: () async {
                  controller.closeView(product.title);
                  ref
                      .read(searchStateProvider.notifier)
                      .updateQuery(controller.text);

                  widget.onLoadingChanged(true);

                  final cartItemCount = await ref
                      .read(cartProvider.notifier)
                      .getCartItemCountByProductId(product.id ?? 0);

                  widget.onLoadingChanged(false);

                  if (!context.mounted) return;
                  context.push(
                    RouteConstant.productDetail,
                    extra: {
                      'product': product.toJson(),
                      'cartItemCount': cartItemCount,
                    },
                  );
                },
              ),
            );
          }).toList();
        },
      ),
    );
  }

  Widget _buildEmptySuggestion() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, size: 48, color: context.steelMedium),
            const SizedBox(height: 8),
            Text(
              'Start typing to search products',
              style: TextStyle(color: context.steelDark, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultsSuggestion(String query) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 48, color: context.steelMedium),
            const SizedBox(height: 8),
            Text(
              'No results found for "$query"',
              style: TextStyle(color: context.steelDark, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Try different keywords',
              style: TextStyle(color: context.steelMedium, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
