/// Request端口，设备发现服务
library;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nsd/nsd.dart' as nsd;
import 'package:requester/domain/client/client.dart';
import 'package:requester_common/requester_common.dart';
import 'package:requester_client/requester_client.dart';

part 'widget.dart';
part 'controller.dart';