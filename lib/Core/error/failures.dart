// هنا انا بعمل class اسمه Failure في ال core layer وبعمله subclasses بترثه ومخصصة لكل نوع من ال failure اللي ممكن يحصل في ال api response بتاعتي زي network failure او server failure او cache failure
// ال class دا هستخدمه في ال repository بتاعي عشان احدد ال return type بتاع ال method اللي بتتعامل مع ال api اللي هي الشاشة دي هتتعامل معاها اللي هما featured books و best seller books
// هحدد ال errors اللي هتظهرلي في التطبيق في المستقبل فلما ي المستقبل يحصل error في ال api response هحدد ال errors هنا ك subclasses
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

// الكلاس الأساسي (الأب) لكل أنواع الأخطاء في التطبيق
abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

// ---------------------------------------------------------
// 1. أخطاء السيرفر (Server Failures)
// ---------------------------------------------------------
class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  // مصنع بيحول أخطاء Dio لرسائل واضحة
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          'Connection timeout with ApiServer. Please try again later.',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          'Send timeout with ApiServer. Please try again later.',
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          'Receive timeout with ApiServer. Please try again later.',
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          'SSL certificate error. Please check your connection security.',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioError
              .response!
              .statusCode!, // هرجع كود الحالة عشان نقدر نحدد نوع الخطأ
          dioError
              .response!
              .data, // هرجع البيانات عشان نقدر نطلع رسالة الخطأ المناسبة من السيرفر لو موجودة
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceled.');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection.');
      case DioExceptionType.unknown:
        if (dioError.message != null &&
            dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection.');
        }
        return ServerFailure('Unexpected Error, Please try again!');
    }
  }

  // دالة تحليل أكواد الـ HTTP اللي راجعة من السيرفر
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      try {
        return ServerFailure(
          response['error']['message'] ?? 'Authentication or data error.',
        );
      } catch (e) {
        return ServerFailure(
          'Authentication or data error. Please check your input.',
        );
      }
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 429) {
      // إضافة خطأ الـ Quota اللي بيظهر في حال تخطيت ال limit لل api
      return ServerFailure(
        'Too many requests. Your API quota is exhausted. Please try again tomorrow.',
      );
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure('Opps There was an Error, Please try again later');
    }
  }
}

// ---------------------------------------------------------
// 2. أخطاء التخزين المحلي (Cache Failures)
// لما تستخدم Hive عشان تحفظ الكتب وتفتحها بدون إنترنت
// ---------------------------------------------------------
class CacheFailure extends Failure {
  CacheFailure(super.errMessage);
  // ال HiveError مافيهاش property اسمها type زي ال DioException
  // عشان كدا بنستخدم ال message اللي جايه من ال error مباشرة أو بنعمل check يدوي
  factory CacheFailure.fromHiveError(HiveError error) {
    // بنحول الخطأ لرسالة نصية واضحة للمستخدم
    if (error.message.contains('not found') ||
        error.message.contains('not open')) {
      return CacheFailure(
        'Cache error: It appears that the saved data is currently unavailable.',
      );
    }
    return CacheFailure(
      'Local Storage Error: An error occurred while fetching data from local memory. the error is ${error.toString()}',
    );
  }
}

// ---------------------------------------------------------
// 3. أخطاء الشبكة (Network Failures)
// لما يكون في مشكلة في الاتصال بالإنترنت أو السيرفر مش متاح
// ---------------------------------------------------------
class NetworkFailure extends Failure {
  NetworkFailure(super.errMessage);

  // مصنع خاص يتعامل مع انقطاع الإنترنت المباشر
  factory NetworkFailure.fromSocketException(SocketException exception) {
    return NetworkFailure('No Internet Connection. Please check your network and try again.');
  }
}

// ---------------------------------------------------------
// 4. أخطاء غير متوقعة (Unexpected Failures)
// لأي خطأ غير مصنف في الأنواع السابقة
// ---------------------------------------------------------
class UnexpectedFailure extends Failure {
  UnexpectedFailure(super.errMessage);

  // نستخدمه في الـ catch(e) العامة
  factory UnexpectedFailure.fromException(Exception e) {
    return UnexpectedFailure('An unexpected error occurred. Please try again or contact support.');
  }
}

// ---------------------------------------------------------
// 5. أخطاء التحقق من البيانات (Data Validation Failures)
// لما البيانات اللي جايه من السيرفر مش بالشكل المتوقع أو ناقصة
// ---------------------------------------------------------
class DataValidationFailure extends Failure {
  DataValidationFailure(super.errMessage);

  // للتحقق من بيانات المدخلات
  factory DataValidationFailure.invalidInput(String message) {
    return DataValidationFailure(message.isEmpty ? 'Invalid input data provided.' : message);
  }
}

// ---------------------------------------------------------
// 6. أخطاء المصادقة (Authentication Failures)
// لما يكون في مشكلة في تسجيل الدخول أو صلاحيات الوصول
// ---------------------------------------------------------
class AuthenticationFailure extends Failure {
  AuthenticationFailure(super.errMessage);

  // للتعامل مع انتهاء صلاحية الـ Token
  factory AuthenticationFailure.sessionExpired() {
    return AuthenticationFailure('Session expired. Please log in again to secure your account.');
  }
}

// ---------------------------------------------------------
// 7. أخطاء الحفظ المحلي (Local Storage Failures)
// لما يكون في مشكلة في حفظ البيانات محلياً باستخدام Hive
// ---------------------------------------------------------
class LocalStorageFailure extends Failure {
  LocalStorageFailure(super.errMessage);

  // مخصص لمشاكل "الكتابة" على الجهاز
  factory LocalStorageFailure.saveError() {
    return LocalStorageFailure('Failed to save data locally. Please check your device storage.');
  }
}

// ---------------------------------------------------------
// 8. أخطاء التحليل (Parsing Failures)
// لما يكون في مشكلة في تحويل البيانات من JSON لكائنات Dart أو العكس
// ---------------------------------------------------------
class ParsingFailure extends Failure {
  ParsingFailure(super.errMessage);

  // خطأ تغير هيكل הـ JSON
  factory ParsingFailure.fromFormatException(FormatException exception) {
    return ParsingFailure('Data formatting error occurred. We are working to resolve this issue.');
  }
}

// ---------------------------------------------------------
// 9. أخطاء الوقت (Timeout Failures)
// لما يكون في مشكلة في الاتصال بسبب تأخر الاستجابة من السيرفر
// ---------------------------------------------------------
class TimeoutFailure extends Failure {
  TimeoutFailure(super.errMessage);

  // يستخدم لعمليات Future.timeout
  factory TimeoutFailure.timeEnded() {
    return TimeoutFailure('The operation timed out. Please check your connection speed.');
  }
}

// ---------------------------------------------------------
// 10. أخطاء مخصصة أخرى (Custom Failures)
// يمكنك إضافة أي فئة أخرى من الأخطاء حسب احتياجات تطبيقك
// ---------------------------------------------------------
class CustomFailure extends Failure {
  CustomFailure(super.errMessage);
  
  // لإرسال أي رسالة خطأ مخصصة بشكل ديناميكي
  factory CustomFailure.withMessage(String customErrMessage) {
    return CustomFailure(customErrMessage);
  }
}