/// Request日志接收服务
library;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nsd/nsd.dart' as nsd;
import 'package:requester/domain/log/log.dart';
import 'package:requester_client/requester_client.dart';
import 'package:requester_common/requester_common.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:requester_client/rpc.dart' as rpc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'widget.dart';
part 'controller.dart';
part 'log.g.dart';
