import 'package:equatable/equatable.dart';

class GetPrefixParam extends Equatable {
  const GetPrefixParam({
    required this.number,
  });

  final String number;

  Map<String, dynamic> toJson() => {
        'number': number,
      };

  @override
  List<Object?> get props => [number];
}
