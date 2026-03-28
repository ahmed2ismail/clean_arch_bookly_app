class AssetsData {
  // إحنا عملنا الكلاس ده عشان يكون "Single Source of Truth" (مصدر واحد للحقيقة). لو في يوم حبيت تغير اسم صورة اللوجو أو مكانها، هتغيرها في مكان واحد بس (كلاس AssetsData) وهتتغير أوتوماتيكياً في كل صفحات التطبيق.
  // دا هيبقي دفتر عناوين عشان بدل ما تكتب: 'assets/images/Logo.png' في كل صفحة بتكتب بس: AssetsData.logo مثلا
  // دا هيشيل كل الصور بتاع التطبيق عن طريق انشاء متغير static وبيشيل القيمة بتاعت الصورة
  // كلمة static معناها إن المتغير ده "ملك للكلاس نفسه" مش للمولود (Object) اللي هيطلع منه.
  // why static:
  // 1- لو المتغير مش static عشان تستخدمه لازم تعمل كدة:
  // AssetsData myAssets = AssetsData(); ثم myAssets.logo
  //لكن بـ static إنت بتنادي عليه فوراً: AssetsData.logo
  // 2- توفير الرام (Memory): لأن الصورة دي بتتحجز في الذاكرة "مرة واحدة بس" مهما استخدمتها في 100 صفحة، عكس المتغيرات العادية اللي بتتحجز مع كل نسخة جديدة من الكلاس.

  static const String logo = 'assets/images/Logo.png';
  static const String testImage = 'assets/images/test_image.png';
}