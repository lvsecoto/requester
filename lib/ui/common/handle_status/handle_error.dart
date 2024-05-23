import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:requester/common/error/error.dart';

import '../show_message.dart';

/// 运行[call]，如有错误则显示错误
Future<T> handlerError<T>(
  BuildContext context,
  FutureOr<T> Function() call, {
  bool Function(dynamic)? handleError,
}) async {
  late T result;
  try {
    result = await call();
  } on DioException catch (e) {
    String errorMessage;
    final error = e.error;
    if (error is UserError) {
      errorMessage = error.message;
    } else if (error is SocketException) {
      errorMessage =
          '(网络错误:${error.osError?.errorCode.toString() ?? '空'})${error.osError?.message ?? '未知错误'}';
    } else {
      errorMessage = e.message ?? '';
    }
    if (!(handleError?.call(error) ?? false)) {
      if (context.mounted) {
        unawaited(context.showMessage(Text(errorMessage)));
      }
    }
    rethrow;
  } on UserError catch (e) {
    if (!(handleError?.call(e) ?? false)) {
      if (context.mounted) {
        unawaited(context.showMessage(Text(e.toString())));
      }
    }
    rethrow;
  } catch (e) {
    if (!(handleError?.call(e) ?? false)) {
      if (context.mounted) {
        unawaited(context.showMessage(Text(e.toString())));
      }
    }
    rethrow;
  }
  return result;
}
