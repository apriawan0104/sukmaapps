// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_transaksi.adapter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDetailTransactionHash() =>
    r'94eb5dfec232de84c373ea5439ee9b531a70a9a9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getDetailTransaction].
@ProviderFor(getDetailTransaction)
const getDetailTransactionProvider = GetDetailTransactionFamily();

/// See also [getDetailTransaction].
class GetDetailTransactionFamily extends Family<AsyncValue<TransferEntity?>> {
  /// See also [getDetailTransaction].
  const GetDetailTransactionFamily();

  /// See also [getDetailTransaction].
  GetDetailTransactionProvider call({
    required String transNo,
  }) {
    return GetDetailTransactionProvider(
      transNo: transNo,
    );
  }

  @override
  GetDetailTransactionProvider getProviderOverride(
    covariant GetDetailTransactionProvider provider,
  ) {
    return call(
      transNo: provider.transNo,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getDetailTransactionProvider';
}

/// See also [getDetailTransaction].
class GetDetailTransactionProvider
    extends AutoDisposeFutureProvider<TransferEntity?> {
  /// See also [getDetailTransaction].
  GetDetailTransactionProvider({
    required String transNo,
  }) : this._internal(
          (ref) => getDetailTransaction(
            ref as GetDetailTransactionRef,
            transNo: transNo,
          ),
          from: getDetailTransactionProvider,
          name: r'getDetailTransactionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDetailTransactionHash,
          dependencies: GetDetailTransactionFamily._dependencies,
          allTransitiveDependencies:
              GetDetailTransactionFamily._allTransitiveDependencies,
          transNo: transNo,
        );

  GetDetailTransactionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.transNo,
  }) : super.internal();

  final String transNo;

  @override
  Override overrideWith(
    FutureOr<TransferEntity?> Function(GetDetailTransactionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDetailTransactionProvider._internal(
        (ref) => create(ref as GetDetailTransactionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        transNo: transNo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TransferEntity?> createElement() {
    return _GetDetailTransactionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDetailTransactionProvider && other.transNo == transNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, transNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetDetailTransactionRef on AutoDisposeFutureProviderRef<TransferEntity?> {
  /// The parameter `transNo` of this provider.
  String get transNo;
}

class _GetDetailTransactionProviderElement
    extends AutoDisposeFutureProviderElement<TransferEntity?>
    with GetDetailTransactionRef {
  _GetDetailTransactionProviderElement(super.provider);

  @override
  String get transNo => (origin as GetDetailTransactionProvider).transNo;
}

String _$detailTransactionControllerHash() =>
    r'8ef40c697bdc430c4728ae6858e79ad47755449f';

/// See also [DetailTransactionController].
@ProviderFor(DetailTransactionController)
final detailTransactionControllerProvider = AutoDisposeAsyncNotifierProvider<
    DetailTransactionController, void>.internal(
  DetailTransactionController.new,
  name: r'detailTransactionControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$detailTransactionControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DetailTransactionController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
