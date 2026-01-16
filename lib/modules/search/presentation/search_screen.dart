import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/core/router/route_constant.dart';
import 'package:fluttertest/core/router/router.dart';
import 'package:fluttertest/core/shared/components/default_network_image.dart';
import 'package:fluttertest/core/shared/theme/color/app_color.dart';
import 'package:fluttertest/modules/cart/riverpod/cart_notifier.dart';
import 'package:fluttertest/modules/search/components/product_search_bar.dart';
import 'package:fluttertest/modules/search/data/entities/model/category_item.dart';
import 'package:fluttertest/modules/search/data/entities/model/product.dart';
import 'package:fluttertest/modules/search/riverpod/product_list_notifier.dart';
import 'package:fluttertest/modules/search/riverpod/search_state_notifier.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final SearchController _searchController = SearchController();
  final FocusNode _searchFocusNode = FocusNode();
  String _selectedCategory = 'All';
  bool _fetchingCartItemCount = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsRef = ref.watch(productListProvider);
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _fetchingCartItemCount
              ? Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: context.onBackgroundColor.withValues(alpha: 0.5),
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
          Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(productListProvider);
                  },
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          pinned: true,
                          forceElevated: innerBoxIsScrolled,
                          automaticallyImplyLeading: false,
                          flexibleSpace: SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // _buildSearchBar(productsRef.value),
                                ProductSearchBar(
                                  products: productsRef.value,
                                  onLoadingChanged: (isLoading) {
                                    setState(() {
                                      _fetchingCartItemCount = isLoading;
                                    });
                                  },
                                ),
                                _buildCategories(),
                              ],
                            ),
                          ),
                          expandedHeight: _calculateHeaderHeight(context),
                          collapsedHeight: _calculateHeaderHeight(context),
                        ),
                      ];
                    },
                    body: CustomScrollView(
                      slivers: [
                        // Results Count
                        SliverToBoxAdapter(child: _buildResultsCount()),

                        // Products Grid
                        SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: _buildProductsGrid(productsRef),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _buildCartBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: context.backgroundColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 10),
          Text(
            "Shop Products",
            style: TextStyle(
              color: context.onBackgroundColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Extract unique categories from products
  // TODO : switch to api call
  List<CategoryItem> _buildCategoriesList() {
    final Set<String?> uniqueCategories =
        ref
            .watch(productListProvider)
            .value
            ?.map((p) => p.category)
            .where((c) => c != null)
            .map((c) => c!)
            .toSet() ??
        {};

    // Create category items with appropriate icons
    final List<CategoryItem> categories = [
      CategoryItem(
        name: 'All',
        icon: Icons.grid_view_rounded,
        productCount: ref.watch(productListProvider).value?.length ?? 0,
      ),
    ];

    for (final category in uniqueCategories) {
      categories.add(
        CategoryItem(
          name: category ?? 'Unknown',
          icon: _getCategoryIcon(category ?? 'Unknown'),
          productCount:
              ref
                  .watch(productListProvider)
                  .value
                  ?.where((p) => p.category == category)
                  .length ??
              0,
        ),
      );
    }

    return categories;
  }

  Widget _buildCategories() {
    final categories = _buildCategoriesList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = _selectedCategory == category.name;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = category.name;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? context.zetrixRed50
                              : context.surfaceContainerColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? context.zetrixRed600
                                : context.outlineVariantColor,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Icon(
                          category.icon,
                          size: 32,
                          color: isSelected
                              ? context.zetrixRed600
                              : context.steelDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 75,
                        child: Text(
                          _formatCategoryName(category.name),
                          style: TextStyle(
                            color: isSelected
                                ? context.zetrixRed600
                                : context.onSurfaceColor,
                            fontSize: 11,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatCategoryName(String name) {
    if (name == 'All') return 'All';
    // Capitalize first letter of each word
    return name
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "men's clothing":
        return Icons.male;
      case "women's clothing":
        return Icons.female;
      case 'jewelery':
        return Icons.diamond;
      case 'electronics':
        return Icons.devices;
      default:
        return Icons.category;
    }
  }

  // Filter products based on search query and category
  List<Product> _getFilteredProducts(List<Product>? products) {
    if (products == null) return [];

    final searchState = ref.read(searchStateProvider);
    var filtered = products;

    if (searchState.selectedCategory != 'All') {
      filtered = filtered
          .where((p) => p.category == searchState.selectedCategory)
          .toList();
    }

    if (searchState.query.isNotEmpty) {
      final query = searchState.query.toLowerCase();
      filtered = filtered.where((p) {
        final title = p.title?.toLowerCase() ?? '';
        final description = p.description?.toLowerCase() ?? '';
        final category = p.category?.toLowerCase() ?? '';
        return title.contains(query) ||
            description.contains(query) ||
            category.contains(query);
      }).toList();
    }

    return filtered;
  }

  Widget _buildResultsCount() {
    final searchState = ref.watch(searchStateProvider);
    final productsRef = ref.watch(productListProvider);
    final filteredProducts = _getFilteredProducts(productsRef.value);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${filteredProducts.length} Products found'),
          if (searchState.query.isNotEmpty)
            TextButton.icon(
              onPressed: () {
                ref.read(searchStateProvider.notifier).clearSearch();
              },
              icon: const Icon(Icons.clear, size: 16),
              label: const Text('Clear search'),
            ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid(AsyncValue<List<Product>> products) {
    return products.map(
      data: (data) {
        final filteredProducts = _getFilteredProducts(data.value);

        if (filteredProducts.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: context.steelMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _searchQuery.isNotEmpty
                        ? 'No products found for "$_searchQuery"'
                        : 'No products in this category',
                    style: TextStyle(
                      color: context.steelDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try adjusting your search or filters',
                    style: TextStyle(color: context.steelMedium, fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  if (_searchQuery.isNotEmpty || _selectedCategory != 'All')
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                          _selectedCategory = 'All';
                          _searchController.clear();
                        });
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset Filters'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.zetrixRed600,
                        foregroundColor: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          );
        }

        return SliverGrid.builder(
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];
            return _buildProductCard(product);
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
        );
      },
      loading: (loading) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator.adaptive()),
        );
      },
      error: (error) {
        return SliverToBoxAdapter(
          child: Center(child: Text('Error: ${error.toString()}')),
        );
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: _fetchingCartItemCount
          ? null
          : () async {
              setState(() {
                _fetchingCartItemCount = true;
              });

              final cartItemCount = await ref
                  .read(cartProvider.notifier)
                  .getCartItemCountByProductId(product.id ?? 0);

              setState(() {
                _fetchingCartItemCount = false;
              });

              if (!mounted) return;
              context.push(
                RouteConstant.productDetail,
                extra: {
                  'product': product.toJson(),
                  'cartItemCount': cartItemCount,
                },
              );
            },
      child: Container(
        decoration: BoxDecoration(
          color: context.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.outlineVariantColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: context.onSurfaceColor.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Section with Badge and Favorite
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: context.surfaceContainerColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 5 / 3,
                    child: DefaultNetworkImage(
                      pathURL: product.image ?? 'N/A',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            // Product Info Section
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      product.title ?? 'N/A',
                      style: TextStyle(
                        color: context.onSurfaceColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Rating Row
                    Row(
                      children: [
                        _buildRatingStars(product.rating?.rate ?? 0),
                        const SizedBox(width: 4),
                        Text(
                          '${product.rating?.rate}',
                          style: TextStyle(
                            color: context.steelDark,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          ' (${product.rating?.count})',
                          style: TextStyle(
                            color: context.steelMedium,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Price
                    Text(
                      '\$${product.price?.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: context.zetrixRed600,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, size: 14, color: Colors.amber.shade600);
        } else if (index < rating) {
          return Icon(Icons.star_half, size: 14, color: Colors.amber.shade600);
        } else {
          return Icon(
            Icons.star_border,
            size: 14,
            color: Colors.amber.shade600,
          );
        }
      }),
    );
  }

  Widget _buildCartBar() {
    final cartState = ref.watch(cartProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        boxShadow: [
          BoxShadow(
            color: context.onSurfaceColor.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Cart Info
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total items in bag',
                    style: TextStyle(
                      color: context.steelDark,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${cartState.value?.totalItems ?? 0} items',
                    style: TextStyle(
                      color: context.onSurfaceColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

            // View Bag Button
            ElevatedButton(
              onPressed: () {
                // Navigate to cart
                context.push(RouteConstant.cart);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.zetrixRed600,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'View Bag',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateHeaderHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 768) {
      return screenHeight * 0.12;
    } else if (screenWidth >= 375) {
      return screenHeight * 0.25;
    } else {
      return screenHeight * 0.30;
    }
  }
}
