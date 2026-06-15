import 'package:equatable/equatable.dart';

class RegisterParam extends Equatable {
  const RegisterParam({
    required this.accessId,
    this.fullname,
    this.tokenFcm,
  });

  final String accessId;
  final String? fullname;
  final String? tokenFcm;

  Map<String, dynamic> toJson() => {
        'accessID': accessId,
        'tokenFCM': tokenFcm,
        if (fullname != null) 'fullname': fullname,
      };

  @override
  List<Object?> get props => [accessId, fullname, tokenFcm];
}
