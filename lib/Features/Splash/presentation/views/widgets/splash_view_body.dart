import 'package:clean_arch_bookly_app/Core/utils/app_router.dart';
import 'package:clean_arch_bookly_app/Core/utils/assets.dart';
import 'package:clean_arch_bookly_app/Features/Splash/presentation/views/widgets/sliding_animation_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  // SingleTickerProviderStateMixin : دا اللي بيهندل ال rate بتاع تغير ال values / هو اللي بيحدد امتي نعمل ال tick دي اللي هي زي صوت ال tick بتاع الساعة مع كل ثانية لان كل ثانية بيبق فيه tick كده وهو اللي بيحدد امتي هعمل refresh وامتي القيمة هتتطلع بحيث انها تتطلع بانسيابية زي منا عايز
  // احنا مستخدمين ال single عشان عندنا AnimationController واحد لو اكتر من واحد هنستخدم حاجة تانية
  // لازم StatefulWidget مع ال Animations عشان هي تعتبر تغيير بيحصل
  // AnimationController --> بيدينا value from 0 (begin) to 1 (end) دايما
  // لو احنا عايزين ندي لل AnimationController قيمة غير اي حاجة من 0 ل 1 فلازم نحط حاجة فوقه
  // فهنروح ننشا ال Animation ذات نفسه اللي احنا هنحطه فوق ال AnimationController واللي هياخد القيم منه ويطلعلنا القيم اللي انا محتاجها اللي هو ال range اللي انا عايزه
  late AnimationController
  animationController; // --> بنستخدمه عشان نعمل animation
  late Animation<Offset>
  slideTransitionAnimation; // --> هنعمل انيميشن من نوع slid
  // Offset يعني المكان او القيمة علي المحاور x,y

  @override
  void initState() {
    // استخدمنا ال initState عشان أول ما ال Widget تظهر في ال UI يبدأ ال Animation يشتغل علطول
    super.initState();
    initSlideTransitionAnimation();
    navigateToHome();
    // مبدا ال single responsability principle هو بكل بساطة إننا نقسم الكود لوظائف صغيرة (Methods) كل واحدة مسؤولة عن حاجة معينة، عشان كدا عملنا الـ initSlideTransitionAnimation في Method لوحدها والـ Navigation في Method تانية و الانتقال لشاشة ال home_view في method عشان الكود يكون منظم وسهل القراءة والصيانة.
  }

  @override
  void dispose() {
    // لازم نعمل dispose لاي controller عندنا عشان هو بيكون recources لو معملتش ليها dispose فهي بتفضل مفتوحة حتي لو الويدجت دي اتقفلت فبالتالي بنعمل حاجة اسمها Memory Leak يعني فيه recources كده محجوزة ومهدرة مش بيتم استخدامها وبتعمل مشاكل طبعا فبنقفلها بال dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 40,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment
          .stretch, // عشان ال child اللي هو الصورة تاخد ال width بتاع الشاشة
      children: [
        Image.asset(AssetsData.logo),
        SlidingAnimationText(
          slideTransitionAnimation: slideTransitionAnimation,
        ),
      ],
    );
  }

  void initSlideTransitionAnimation() {
    animationController = AnimationController(
      // vsync: this --> يعني ال SingleTickerProviderStateMixin اللي فوق دا
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    // كده احنا عملنا ال AnimationController ولو احنا عايزين نستخدمه زي مهو كده ب value من 0 ل 1 هنستخدم animationController.value =0 or 1; بس احنا عايزين value من 0 ل 60 مثلا اللي هي دقيقة كاملة فهنستخدم ال Animation slideTransitionAnimation اللي هنحطه فوق دا عشان يدينا القيمة اللي احنا عايزينها
    slideTransitionAnimation = Tween<Offset>(
      // Tween animation دي هتتعامل مع القيمة Offset
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(animationController);
    // هنستخدم معاه ويدجت اسمها SlideTransition علي المكان اللي عايزين نعمله انيميشن
    // بس كده ال ui مش هيتعمله update خالص وهنحل دا كدا :
    // slideTransitionAnimation.addListener(() => setState(() {}));
    // .addListener --> بمعني حط ودانك معاه ولما القيمة تتغير اعملي setState يعني حدث ال ui بس كده الشاشة كلها هتتحدث مش النص بس او الحاجة اللي احنا عايزين نعملها انيميشن
    // الحل هو ان احنا ن wrap ال SlideTransition مع AnimatedBuilder
    animationController
        .forward(); //--> عشان تمشي ال animation بصورة سلسة لحد نهايته
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // Get.to(
        //   () => const HomeView(),
        //   transition: Transition.fade,
        //   duration: kTransitonDuration,
        // );
        GoRouter.of(context).push(AppRouter.kHomeView);
      }
    });
  }
}
