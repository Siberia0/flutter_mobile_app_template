import 'package:flutter/material.dart';
import 'package:flutter_mobile_app_template/app_base.dart';
import 'package:flutter_mobile_app_template/view/signin/view_model/signin_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../common/widget/common_elevated_button.dart';
import '../../common/widget/common_loading_widget.dart';
import '../../common/widget/common_textformfield.dart';
import '../../const/app_color.dart';
import '../../const/app_page.dart';
import '../../exception/app_exception.dart';
import '../../provider/provider_access.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SignInViewModel>(
          create: (context) => SignInViewModel(),
        ),
      ],
      child: const SignInWidget(),
    );
  }
}

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key? key}) : super(key: key);

  @override
  createState() => SignInState();
}

class SignInState extends State<SignInWidget>
    with ProviderAccess<SignInViewModel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus
          ?.unfocus(), // Unfocus when tapping on areas where UI parts are not placed
      child: Scaffold(
        backgroundColor: AppColor.base,
        body: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Consumer<SignInViewModel>(
                  builder: (context, viewModel, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CommonTextFormField(
                          TextInputType.emailAddress,
                          256,
                          viewModel.idTextController,
                          'ID',
                          key: const ValueKey('TextForm-SignInId'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50.0),
                          child: CommonTextFormField(
                            TextInputType.visiblePassword,
                            12,
                            viewModel.passwordTextController,
                            'Password',
                            key: const ValueKey('TextForm-Password'),
                            addRedEyeIcon: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CommonElevatedButton(
                                  title: 'Sign in',
                                  onTap: () async {
                                    try {
                                      await CommonLoadingWidget.of(context)
                                          .during(viewModel.signIn())
                                          .then((_) {
                                        Navigator.pushNamedAndRemoveUntil(
                                            navigatorKey.currentContext!,
                                            AppPage.home.screenID,
                                            (route) => false);
                                      });
                                    } on AppException catch (e) {
                                      viewModel.showMessageDialog(
                                          context, e.message);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
