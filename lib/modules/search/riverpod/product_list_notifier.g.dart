// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductListNotifier)
final productListProvider = ProductListNotifierProvider._();

final class ProductListNotifierProvider
    extends $AsyncNotifierProvider<ProductListNotifier, List<Product>> {
  ProductListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'productListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productListNotifierHash();

  @$internal
  @override
  ProductListNotifier create() => ProductListNotifier();
}

String _$productListNotifierHash() =>
    r'e8826bac924882a46d7bfc6518ecaf85154ad17d';

abstract class _$ProductListNotifier extends $AsyncNotifier<List<Product>> {
  FutureOr<List<Product>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Product>>, List<Product>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Product>>, List<Product>>,
              AsyncValue<List<Product>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
