//
//  InternetConfigDefine.h
//  ModelBuilder
//
//  Created by concise on 12-10-25.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#define ConfigPath(x) [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:x]

#define CurrentConnectionLimit  1


#define TaipingServerDev    @"TaipingServerDev"
#define kTaipingServerDev   1000


#define URLErrorUnknown                     @"未知错误"

#define URLErrorBadURL                      @"非法的URL"

#define URLErrorCannotFindHost              @"无法连接至服务器"

#define URLErrorNotConnectedToInternet      @"网络未连接"

#define URLErrorCannotConnectToHost         @"无法连接至服务器"

#define URLErrorTimedOut                    @"连接服务器超时"

#define URLErrorCancelled
