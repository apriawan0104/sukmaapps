import 'package:equatable/equatable.dart';

class ReadTermParam extends Equatable {
  const ReadTermParam({
    this.isReadTermCondition = true,
  });

  final bool isReadTermCondition;

  Map<String, dynamic> toJson() => {
        'isReadTermCondition': isReadTermCondition,
      };

  @override
  List<Object?> get props => [isReadTermCondition];
}
