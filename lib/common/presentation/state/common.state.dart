import 'package:equatable/equatable.dart';

import '../../domain/entity/entity.dart';

class CommonState extends Equatable {
  const CommonState({
    this.items = const <CommonItemEntity>[],
  });

  final List<CommonItemEntity> items;

  @override
  List<Object?> get props => [items];

  CommonState copyWith({
    List<CommonItemEntity>? items,
  }) {
    return CommonState(
      items: items ?? this.items,
    );
  }
}
