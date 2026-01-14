import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/core/router/route_constant.dart';
import 'package:fluttertest/core/router/router.dart';
import 'package:fluttertest/core/shared/components/default_network_image.dart';
import 'package:fluttertest/core/shared/theme/color/app_color.dart';
import 'package:fluttertest/modules/search/data/entities/model/category_item.dart';
import 'package:fluttertest/modules/search/data/entities/model/product.dart';
import 'package:fluttertest/modules/search/riverpod/product_list_notifier.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  int _cartItemCount = 3;

  final List<String> _filters = [
    'Filter',
    'In stock',
    'Fast delivery',
    'Top rated',
    'On sale',
  ];

  int _selectedFilterIndex = -1;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
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

  void _addToCart(Product product) {
    setState(() {
      _cartItemCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart'),
        backgroundColor: context.zetrixRed600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(productListProvider);
              },
              child: CustomScrollView(
                slivers: [
                  // Search Bar
                  // SliverToBoxAdapter(child: _buildSearchBar()),

                  // Filter Chips
                  // SliverToBoxAdapter(child: _buildFilterChips()),

                  // Categories
                  // SliverToBoxAdapter(child: _buildCategories()),

                  // Results Count
                  SliverToBoxAdapter(child: _buildResultsCount()),

                  // Products Grid
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: _buildProductsGrid(),
                  ),

                  // Bottom spacing for the cart bar
                  const SliverToBoxAdapter(child: SizedBox(height: 80)),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: _buildCartBar(),
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: context.surfaceContainerColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.outlineVariantColor, width: 1),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: TextStyle(
              color: context.onSurfaceColor.withValues(alpha: 0.5),
              fontSize: 16,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: context.onSurfaceColor.withValues(alpha: 0.5),
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: context.onSurfaceColor.withValues(alpha: 0.5),
                    ),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          style: TextStyle(color: context.onSurfaceColor, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedFilterIndex == index;
          final isFilterButton = index == 0;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_filters[index]),
                  if (isFilterButton) ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 18,
                      color: isSelected
                          ? context.onPrimaryColor
                          : context.onSurfaceColor,
                    ),
                  ],
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilterIndex = selected ? index : -1;
                });
              },
              backgroundColor: context.surfaceContainerColor,
              selectedColor: context.zetrixRed600,
              labelStyle: TextStyle(
                color: isSelected
                    ? context.onPrimaryColor
                    : context.onSurfaceColor,
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? context.zetrixRed600
                      : context.outlineVariantColor,
                ),
              ),
              showCheckmark: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          );
        },
      ),
    );
  }

  // Extract unique categories from products
  // TODO : swtich to api call
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
                        width: 70,
                        height: 70,
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

  Widget _buildResultsCount() {
    final productsRef = ref.watch(productListProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${productsRef.value?.length ?? 0} Products found',
            style: TextStyle(
              color: context.steelDark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsGrid() {
    final productsRef = ref.watch(productListProvider);
    return productsRef.map(
      data: (data) {
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            final product = data.value[index];
            return _buildProductCard(product);
          }, childCount: data.value.length),
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
      onTap: () {
        router.push(RouteConstant.productDetail, extra: product);
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
                    '$_cartItemCount items',
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
}
