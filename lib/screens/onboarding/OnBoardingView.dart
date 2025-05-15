
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/screens/onboarding/OnboardingViewModel.dart';
import 'package:todo_app/screens/onboarding/onboarding_slider.dart';
import 'package:todo_app/utils/routes.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_strings.dart';
import '../../utils/color_manager.dart';
import '../../utils/style_manager.dart';
import '../../utils/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController pageController = PageController();
  final OnboardingViewModel _viewModel = OnboardingViewModel();

  _binding() {
    _viewModel.onStart();
  }

  @override
  void initState() {
    _binding();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OnboardingSliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return _getContentWidget(snapshot.data!);
          } else {
            return Container();
          }
        });
  }

  Widget _getContentWidget(OnboardingSliderViewObject data) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorManager.water,
            statusBarBrightness: Brightness.light),
           actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(Routes.loginRoute);
                  },
                  child:  Text(
                    AppStrings.skip,
                    textAlign: TextAlign.end,
                    style: buttonText2.copyWith(color: ColorManager.secondary),
                  ),
                ),
              ),
            ),
           ],
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: data.pageCount,
        onPageChanged: (index) {
          _viewModel.onPageChanged(index);
        },
        itemBuilder: (context, index) {
          return OnboardingPage(
            onboardingSlider: data.onboardingSlider,
          );
        },
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _getBottomSheetWidget(data)
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget(OnboardingSliderViewObject? data) {
    return Container(
      decoration:  BoxDecoration(color: ColorManager.white),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (int index = 0; index < data!.pageCount; index++)
              Container(
                width: data.currentIndex == index ? AppSize.s11_5 : AppSize.s10,
                height:
                    data.currentIndex == index ? AppSize.s11_5 : AppSize.s10,
                margin: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: data.currentIndex == index
                      ? Border.all(
                          color: ColorManager.white,
                          width: AppSize.s1_5,
                        )
                      : null,
                  color: data.currentIndex == index
                      ? ColorManager.blue
                      : ColorManager.white,
                ),
              )
          ]),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: SizedBox(
              width: double.infinity, // يعرض الزر بعرض الشاشة المتاح
              child: ElevatedButton(
                onPressed: () {
                  data.currentIndex == data.pageCount -1 ? 
                  Navigator.of(context)
                        .pushReplacementNamed(Routes.loginRoute)
                  :
                  pageController.nextPage(
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.ease);
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.blue,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), 
                  ),
                  elevation: 4,
                ),
                child: Text(
                  data.currentIndex == data.pageCount -1 ? 'Get Started':'Next',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingSlider onboardingSlider;

  const OnboardingPage({super.key, required this.onboardingSlider});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          onboardingSlider.imagePath,
        ),
        const SizedBox(
          height: AppSize.s30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p8),
          child: Text(
            onboardingSlider.header,
            style:headline1.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Text(
            onboardingSlider.body,
            style:bodyText1.copyWith(color: ColorManager.grey),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: AppSize.s40,
        ),
      ],
    );
  }
}
