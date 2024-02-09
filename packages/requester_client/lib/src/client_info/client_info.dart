/// 向Requester提供应用运行信息
library;

typedef ClientInfo = Map<String, String>;

/// 实现接口，向Requester提供信息
typedef ClientInfoProvider = Stream<ClientInfo>;