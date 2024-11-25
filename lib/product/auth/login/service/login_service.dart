import 'package:tekvando/product/auth/login/model/login_model.dart';
import 'package:tekvando/product/general/enum/http_methods.dart';
import 'package:tekvando/product/general/model/base_response.dart';
import 'package:tekvando/product/general/service/api_service.dart';

class LoginService extends ApiService {
  Future<BaseResponse<LoginModel?>> customerLogin(
    String mail,
    String password,
    String? onesignalId,
  ) {
    return requestMethod<LoginModel?>(
      path: '/auth/login',
      headers: {
        'Content-Type': 'application/json',
      },
      responseConverter: (p0) {
        if (p0 != null) {
          return LoginModel.fromJson(p0 as Map<String, dynamic>);
        }
        return null;
      },
      requestModel: {
        "email": mail,
        "password": password,
        "onesignal_id": onesignalId,
      },
      queryParameters: null,
      method: HttpMethod.post,
    );
  }

  // Future<BaseResponse<List<CategoryModel>?>?> fetch() {
  //   return requestMethod<List<CategoryModel>>(
  //     path: '/category/list',
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     responseConverter: (p0) {
  //       if (p0 is List<dynamic>) {
  //         return p0
  //             .map((json) =>
  //                 CategoryModel.fromJson(json as Map<String, dynamic>))
  //             .toList();
  //       } else {
  //         // Uygun bir hata işleme stratejisi
  //         throw const FormatException(
  //             'Invalid data format for CategoryModel list');
  //       }
  //     },
  //     requestModel: null,
  //     queryParameters: null,
  //     method: HttpMethod.get,
  //   );
  // }

  // Future<BaseResponse<List<CategoryModel>?>?> get(
  //   String name,
  // ) {
  //   return requestMethod<List<CategoryModel>?>(
  //     path: '/category/list/$name',
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     responseConverter: (p0) {
  //       if (p0 != null && p0 is List) {
  //         return p0.map((json) => CategoryModel.fromJson(json)).toList();
  //       }
  //       return null;
  //     },
  //     requestModel: null,
  //     queryParameters: null,
  //     method: HttpMethod.get,
  //   );
  // }

  // Future<BaseResponse<CategoryModel>?> add({
  //   required bool isActive,
  //   required String name,
  //   required int trendyolId,
  // }) {
  //   return requestMethod<CategoryModel>(
  //     path: '/category',
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     responseConverter: (p0) =>
  //         CategoryModel.fromJson(p0 as Map<String, dynamic>),
  //     requestModel: {
  //       "isActive": isActive,
  //       "name": name,
  //       "trendyolId": trendyolId, //trendyolId,
  //     },
  //     queryParameters: null,
  //     method: HttpMethod.post,
  //   );
  // }

  // Future<BaseResponse<bool>> update(
  //   bool isActive,
  //   String name,
  //   int userId,
  //   int id,
  //   int trendyolId,
  // ) {
  //   return requestMethod<bool>(
  //     path: '/category',
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     responseConverter: (p0) => p0,
  //     requestModel: {
  //       "isActive": isActive,
  //       "name": name,
  //       "userId": userId,
  //       "id": id,
  //       "trendyolId": trendyolId,
  //     },
  //     queryParameters: null,
  //     method: HttpMethod.put,
  //   );
  // }

  // Future<BaseResponse<bool>> delete(
  //   int id,
  // ) {
  //   return requestMethod<bool>(
  //     path: '/category/$id',
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     responseConverter: (p0) => p0,
  //     requestModel: null,
  //     queryParameters: null,
  //     method: HttpMethod.delete,
  //   );
  // }
}
