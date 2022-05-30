import 'package:flutter/material.dart';
import 'package:flutter_mobile_app_template/exception/api_exception.dart';

import '../../../common/usecase/dialog_usecase.dart';
import '../../../common/usecase/hive_usecase.dart';
import '../../../common/view_model/viewmodel_base.dart';
import '../../../exception/app_exception.dart';
import '../usecase/signin_usecase.dart';

class SignInViewModel extends ViewModelBase {
  final SignInUseCase _signInUseCase;
  final DialogUseCase _dialogUseCase;
  final HiveUseCase _hiveUseCase;
  SignInViewModel() : this.di(SignInUseCase(), DialogUseCase(), HiveUseCase());

  @visibleForTesting
  SignInViewModel.di(
      this._signInUseCase, this._dialogUseCase, this._hiveUseCase) {
    // set default
    _idTextController.text = _hiveUseCase.readSignInId();
  }

  final TextEditingController _idTextController = TextEditingController();
  TextEditingController get idTextController => _idTextController;
  final TextEditingController _passwordTextController = TextEditingController();
  TextEditingController get passwordTextController => _passwordTextController;

  Future<void> signIn() async {
    try {
      // validation
      if (!_signInUseCase.validateId(_idTextController.text) ||
          !_signInUseCase.validatePassword(_passwordTextController.text)) {
        throw AppException('Invalid ID or password.');
      }

      // Perform sign-in(Implement here)
      await Future.delayed(const Duration(seconds: 3));
    } on AppException catch (_) {
      rethrow;
    } on ApiException catch (e) {
      // rethrow as AppException
      throw AppException('Sign-in failed. (API error)', exception: e);
    } catch (e) {
      // rethrow as AppException
      throw AppException('Sign-in failed.', exception: e);
    }
  }

  Future<void> showMessageDialog(BuildContext context, String message) async {
    _dialogUseCase.showMessageDialog(context, message);
  }

  @override
  void dispose() {
    _idTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }
}
