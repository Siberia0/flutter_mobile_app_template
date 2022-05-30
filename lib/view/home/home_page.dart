import 'package:flutter/material.dart';
import 'package:flutter_mobile_app_template/view/home/view_model/home_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../common/widget/common_appbar.dart';
import '../../const/app_color.dart';
import '../../exception/app_exception.dart';
import '../../provider/provider_access.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(),
        ),
      ],
      child: const HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  createState() => HomeState();
}

class HomeState extends State<HomeWidget> with ProviderAccess<HomeViewModel> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = getProvider(context, mounted);
      _init(viewModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.base,
        appBar: const CommonAppBar(title: 'Home'),
        body: Consumer<HomeViewModel>(builder: (context, viewModel, child) {
          if (viewModel.isProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                _init(getProvider(context, mounted));
              },
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Future<void> _init(HomeViewModel? viewModel) async {
    try {
      await viewModel?.fetchUserData();
    } on AppException catch (e) {
      viewModel?.showMessageDialog(context, e.message);
    }
  }
}
