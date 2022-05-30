import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_app_template/common/usecase/dialog_usecase.dart';
import 'package:flutter_mobile_app_template/view/home/usecase/home_usecase.dart';

import '../../../common/view_model/viewmodel_base.dart';
import '../../../exception/api_exception.dart';
import '../../../exception/app_exception.dart';

class HomeViewModel extends ViewModelBase {
  final HomeUseCase _homeUseCase;
  final DialogUseCase _dialogUseCase;
  HomeViewModel() : this.di(HomeUseCase(), DialogUseCase());

  @visibleForTesting
  HomeViewModel.di(this._homeUseCase, this._dialogUseCase);

  // progress status
  bool _isProgress = true;
  bool get isProgress {
    return _isProgress;
  }

  @override
  void dispose() {
    _homeUseCase.close();
    super.dispose();
  }

  Future<void> fetchUserData() async {
    _isProgress = true;
    notifyListeners();

    try {
      //final userEntity = await _homeUseCase.requestRestApi(path: '/user', method: HttpMethod.get);
      await Future.delayed(const Duration(seconds: 3));
    } on AppException catch (_) {
      rethrow;
    } on ApiException catch (e) {
      // rethrow as AppException
      throw AppException('Fetching user data failed. (API error)',
          exception: e);
    } catch (e) {
      // rethrow as AppException
      throw AppException('Fetching user data failed.', exception: e);
    } finally {
      _isProgress = false;
      notifyListeners();
    }
  }

  Future<void> showMessageDialog(BuildContext context, String message) async {
    _dialogUseCase.showMessageDialog(context, message);
  }
}
