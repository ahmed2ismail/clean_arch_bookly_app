// دي ويدجت بتعمل حركة fading يعني بتخلي ال opacity بتاع ال child بتاعها بيزيد وينقص بشكل مستمر عشان يدي احساس بالحركة، ودي بتكون مفيدة في حالة ال loadingIndicator وبديله لل loadingIndicator العادي مثلا عشان تخلي المستخدم يحس ان في حاجة بتحصل مش بس واقف كده، فبتدي ال opacity من 0.2 لحد 0.8 وبعدين ترجع تاني ل 0.2 وهكذا بشكل مستمر
// واحنا بنديلها ال child بتاعها اللي هو في حالتنا ال ListView اللي بتعرض ال loadingIndicator بتاع الكتب لحد ما يخلص تحميلهم وتظهر الصور بتاعتهم
// باخد الويجدت اللي بتعرض ال loadingIndicator وبلفها جوا ال CustomFadingWidget عشان اعمل الحركة دي عليها وبظبطها عشان تكون بشكل ال loading زي ال shimmer كده الاتنين كويسين
import 'package:flutter/material.dart';

class CustomFadingWidget extends StatefulWidget {
  const CustomFadingWidget({super.key, required this.child});

  final Widget child;

  @override
  State<CustomFadingWidget> createState() => _CustomFadingWidgetState();
}

class _CustomFadingWidgetState extends State<CustomFadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: .2,
      end: .8,
    ).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.repeat(reverse: true);
    // repeat: عشان يفضل يكرر الحركة لانه في حالة ال forward بيكمل لحد النهاية وبعدين بيقف، اما في حالة ال repeat بيكمل لحد النهاية وبعدين يرجع للبداية ويكمل وهكذا يعني بيفضل شغال طول مهو موجود علي الشاشة عندي
    // reverse: عشان يرجع من النهاية للبداية يعني يمشي في الاتجاهين، يعني لو ما حطيناش ال reverse هيكمل لحد النهاية وبعدين بيقف، اما لما نحط ال reverse بيكمل لحد النهاية وبعدين يرجع للبداية ويكمل وهكذا
  }

  @override
  void dispose() {
    _animationController.removeListener(() {});
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: _animation.value, child: widget.child);
  }
}
