# requester_client

Requester 客户端核心组件，使用此组件让App能和Requester分析工具通信和上报信息

## 开始使用

### 引入Requester核心

让`RequesterClientWidget`运行在App整个生命周期

```dart
Widget buildApp() {
  return RequesterClientWidget(
    port: 5010, // Requester Client开启这个端口，和Requester通信，建议不同的App使用不同的端口
    child: MaterialApp(
      home: const Home(),
    ),
  );
}
```

App完成这一步后，App打开时，Requester应当能在设备列表中看到这个App。

### Requester 网络请求日志和重载功能

向Dio添加Requester拦截器

```dart
void bindDio(BuildContext context, Dio dio) {
  dio.interceptors.addAll(
    requesterClientController.buildDioInterceptors(),
  );
}
```

App完成这一步后，Requester在设备详情里点击绑定好Log日志后，在日志页面就能看到请求日志了

### Requester 客户端自定义参数上报和修改

可以通过Requester修改客户端的参数，比如Token等

```dart
void bindParameter() {
  final infoProvider = RequesterClientController
      .of(context)
      .infoProvider;
  infoProvider.set('counter', _counter.toString());
  infoProvider.on('counter', (value) {
    _counter = int.tryParse(value) ?? _counter;
    setState(() {});
    return _counter.toString();
  });
}
```

App完成这一步后，Requester在设备详情里查看和修改Counter
