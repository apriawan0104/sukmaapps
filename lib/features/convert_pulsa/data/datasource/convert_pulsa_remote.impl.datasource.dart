import 'package:app_core/app_core.dart';
import 'package:injectable/injectable.dart';
import 'package:sukmaapps/core/core.dart';

import '../../../../common/common.dart';
import '../../domain/param/param.dart';
import '../model/model.dart';
import 'convert_pulsa_remote.datasource.dart';

@LazySingleton(as: ConvertPulsaRemoteDataSource)
class ConvertPulsaRemoteImplDataSource implements ConvertPulsaRemoteDataSource {
  ConvertPulsaRemoteImplDataSource(this._remoteClient);

  final HttpClient _remoteClient;

  @override
  Future<ValueGuard<void>> saveNumberFav(SavePhoneFavParam params) {
    return _remoteClient
        .post<Map<String, dynamic>>(
          WebServiceConstant.number,
          data: params.toJson(),
        )
        .mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<List<BankModel>>> getListBank(NoParams params) async {
    return _remoteClient
        .get<Map<String, dynamic>>(
      WebServiceConstant.bank,
    )
        .mapSuccess((response) {
      return ApiResponse.unwrapList(response.data)
          .map((e) => BankModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<ValueGuard<void>> saveRekeningFav(SaveRekeningFavParam params) async {
    return _remoteClient
        .post<Map<String, dynamic>>(
          WebServiceConstant.rekening,
          data: params.toJson(),
        )
        .mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<TransferModel>> saveTransKonfirm(
    SaveTransKonfirmParam params,
  ) async {
    return _remoteClient
        .post<Map<String, dynamic>>(
          WebServiceConstant.transOpen,
          data: params.toJson(),
        )
        .mapSuccess(
          (response) => TransferModel.fromJson(
            ApiResponse.unwrapMap(response.data),
          ),
        );
  }

  @override
  Future<ValueGuard<void>> cancelTrans(CancelParam params) async {
    return _remoteClient
        .delete<Map<String, dynamic>>(
          WebServiceConstant.cancelTrans,
          data: params.toJson(),
          queryParameters: params.toQuery(),
        )
        .mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<void>> deleteImage(DeleteImageParam params) async {
    return _remoteClient
        .delete<Map<String, dynamic>>(
          WebServiceConstant.deleteImage,
          queryParameters: params.toQuery(),
        )
        .mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<void>> uploadImage(UploadImageParam params) async {
    if (params.fileBytes != null) {
      return _remoteClient
          .uploadBytes<Map<String, dynamic>>(
            WebServiceConstant.uploadImage,
            params.fileBytes!,
            fileName: params.fileName ?? 'image.jpg',
            data: {'no_trans': params.noTrans},
          )
          .mapSuccess((_) {});
    }

    return _remoteClient.upload<Map<String, dynamic>>(
      WebServiceConstant.uploadImage,
      params.imagePath,
      data: {'no_trans': params.noTrans},
    ).mapSuccess((_) {});
  }

  @override
  Future<ValueGuard<void>> transEvidence(TransEvidenceParam params) async {
    if (params.fileBytes != null) {
      return _remoteClient
          .uploadBytes<Map<String, dynamic>>(
            WebServiceConstant.transEvidence,
            params.fileBytes!,
            fileName: params.fileName ?? 'image.jpg',
            data: {'no_trans': params.noTrans},
          )
          .mapSuccess((_) {});
    }

    return _remoteClient.upload<Map<String, dynamic>>(
      WebServiceConstant.transEvidence,
      params.imagePath,
      data: {'no_trans': params.noTrans},
    ).mapSuccess((_) {});
  }
}
