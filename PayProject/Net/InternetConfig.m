//
//  InternetConfig.m
//  ModelBuilder
//
//  Created by concise on 12-10-25.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#import "InternetConfig.h"
#import "NSString+Base64.h"
@implementation InternetConfig

//@synthesize cacheData;
@synthesize environment;

static  InternetConfig *sharedInstance = nil;

#pragma mark -
//类方法创建单例对象
+ (InternetConfig *)sharedInstance {
    @synchronized ([InternetConfig class]) {
        if (sharedInstance == nil) {
            sharedInstance = [[InternetConfig alloc] init];
            return sharedInstance;
        }
    }
    return sharedInstance;
}
//alloc创建对象
+ (id)alloc {
    @synchronized ([InternetConfig class]) {
        sharedInstance = [super alloc];
        return sharedInstance;
    }
    return nil;
}
//销毁下载类
+ (void)destroy {
    [sharedInstance release];
    sharedInstance = nil;
}

- (InternetConfig *)init {
    if (self = [super init]) {
        activeConnectionCount = 0;
        cacheData = [[NSMutableDictionary alloc] initWithCapacity:10];
        self.environment = [[[NSMutableDictionary alloc] initWithContentsOfFile:ConfigPath(@"InternetConfig.plist")] autorelease];
        connectionArray = [[NSMutableArray alloc] initWithCapacity:10];
        isLog = [[[self getEnvironment] objectForKey:@"Debug"] boolValue];
        isNetworkActivityIndicatorVisible = [[[self getEnvironment] objectForKey:@"NetworkActivityIndicatorVisible"] boolValue];
    }
    return self;
}

- (NSDictionary *)getEnvironment {
    if ([self.environment count] == 0) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:ConfigPath(@"InternetConfig.plist")];
        [self.environment setDictionary:dic];
    }
    return self.environment;
}

#pragma mark -
//发送服务器和接口拼装的URL请求
- (void)sendRequestWithID:(int)connectionId
                URLString:(NSString*)urlKey
                     Body:(NSString*)bodyString
         CallBackDelegate:(id)callBackDelegate
    RemovePreviousRequest:(BOOL)remove
                 useCache:(BOOL)isUseCache {
    
    //拼装URL
    //网络类型
    NSString *environmentKey = [[self getEnvironment] objectForKey:@"ENVIRONMENT"];
    //server地址
    NSString *server = [[[[self getEnvironment] objectForKey:@"serverAddress"] objectForKey:environmentKey] base64DecodedString];
    NSDictionary *interface = [[[self getEnvironment] objectForKey:@"serverInterface"] objectForKey:urlKey];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", server, [interface objectForKey:@"urlString"]];
    
    [self startInternetConnection:connectionId URLString:urlString Body:bodyString CallBackDelegate:callBackDelegate RemovePreviousRequest:remove useCache:YES];
}

//发送非拼装的URL请求
- (void)sendRequestWithID:(int)connectionId
          CustomURLString:(NSString *)urlKey
                     Body:(NSString *)bodyString
         CallBackDelegate:(id)callBackDelegate
    RemovePreviousRequest:(BOOL)remove
                 useCache:(BOOL)isUseCache {
//    NSLog(@"requestbodyString：%@",bodyString);
    
    //生成URL    
    NSDictionary *interface = [[[self getEnvironment] objectForKey:@"customInterface"] objectForKey:urlKey];
    NSString *environmentKey = [[self getEnvironment] objectForKey:@"ENVIRONMENT"];
    NSString *urlString = [[interface objectForKey:environmentKey] base64DecodedString];
    
    [self startInternetConnection:connectionId URLString:urlString Body:bodyString CallBackDelegate:callBackDelegate RemovePreviousRequest:remove useCache:YES];
}

- (void)startInternetConnection:(int)connectionId
                      URLString:(NSString *)urlString
                           Body:(NSString *)bodyString
               CallBackDelegate:(id)callBackDelegate
          RemovePreviousRequest:(BOOL)remove
                       useCache:(BOOL)isUseCache {
    
    //是否移除之前未完成的网络请求
    if (remove) {
        [self removeAllRequest];
    }
    //是否使用缓存数据
    if (isUseCache) {
        if ([cacheData objectForKey:urlString] != nil && [callBackDelegate respondsToSelector:@selector(connectionFinished:)]) {
            //缓存存在，使用缓存数据，直接回调
            [callBackDelegate connectionFinished:[cacheData objectForKey:[NSNumber numberWithInt:connectionId]]];
            return;
        }
    }
    
    //生成URLRequest
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]
                                                                 cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                             timeoutInterval:[[[self getEnvironment] objectForKey:@"requestTimeout"] intValue]] autorelease];
//    [request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:bodyData];
    
	InternetConnection *connection = [[[InternetConnection alloc] initWithRequest:request delegate:self startImmediately:NO] autorelease];
    [connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    connection.identityID_ = connectionId;
    connection.callBackDelegate_ = callBackDelegate;
    connection.isStoreCache_ = isUseCache;

    //添加网络请求至网络队列,判断当前网络连接数是否超过限制，如是超过则暂缓执行
    [connectionArray addObject:connection];
    if (activeConnectionCount < CurrentConnectionLimit) {
        [connection start];
        connection.active_ = YES;
        activeConnectionCount += 1;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = isNetworkActivityIndicatorVisible;

        //zsb begin
        if (!ACDAtA.isIndicator) {
            hub = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows objectAtIndex:0] animated:YES];
        }

        //end
        if (isLog) {
           // NSLog(@" \n网络请求开始：URL = %@\n 发送数据： %@", urlString, bodyString);
        }
    }
}

- (void)removeAllRequest {
    @synchronized (connectionArray) {
        for (InternetConnection *removeConn in connectionArray) {
            [removeConn cancel];
            [self connection:removeConn didFailWithError:[NSError errorWithDomain:NSURLErrorDomain code:kCFURLErrorCancelled userInfo:nil]];
            [connectionArray removeObject:removeConn];
        }        
    }
}

- (void)removeConnectionWithID:(NSInteger)identityID {
    @synchronized (connectionArray) {
        for (InternetConnection *removeConn in connectionArray) {
            if (removeConn.identityID_ == identityID) {
                [removeConn cancel];
                if (removeConn.active_) {
                    [self connection:removeConn didFailWithError:[NSError errorWithDomain:NSURLErrorDomain code:kCFURLErrorCancelled userInfo:nil]];
                }
                [connectionArray removeObject:removeConn];
                break;
            }
        }
    }
}

- (void)removeAllRequestForSystemMemory {
    @synchronized (connectionArray) {
        for (InternetConnection *removeConn in connectionArray) {
            if (!removeConn.active_) {
                [removeConn cancel];
                [connectionArray removeObject:removeConn];
            };
        }
    }
}

- (void)removeCacheWithID:(NSInteger)connectionID {
    @synchronized (cacheData) {
        [cacheData removeObjectForKey:[NSNumber numberWithInteger:connectionID]];
    }
}

- (void)cleanConnectionCache {
    @synchronized (cacheData) {
        [cacheData removeAllObjects];
    }
}

#pragma mark -
#pragma mark ---------HTTPConnection Methods-----------
#pragma mark -
- (void)connection:(InternetConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if (isLog) {
        NSLog(@"服务器返回数据类型为：%@， 服务器数据编码为：%@", [response MIMEType], [response textEncodingName]);
    }
    connection.returnDataType_ = [response MIMEType];
    connection.returnDataEncoding_ = [response textEncodingName];
}

- (void)connection:(InternetConnection *)connection didReceiveData:(NSData *)data {
    if (isLog) {
        NSLog(@"data length ==== %d", data.length);
    }
    [connection.cacheData_ appendData:data];
}

- (void)connectionDidFinishLoading:(InternetConnection *)connection {
//    NSStringEncoding    encoding;
//    if ([connection.returnDataEncoding_ isEqualToString:@"gbk"]) {
//        encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000); //for gbk
//    }else {
//        encoding = NSUTF8StringEncoding;
//    }
	NSString *dataString = [[[NSString alloc] initWithData:connection.cacheData_ encoding:NSUTF8StringEncoding] autorelease];
    if (isLog) {
        NSLog(@"InternetConfig :服务器成功返回数据：\n%@", dataString);
    }
    
    if (connection.isStoreCache_) {
        [cacheData setObject:connection forKey:[NSNumber numberWithInteger:connection.identityID_]];
    }
    
    if ([connection.callBackDelegate_ respondsToSelector:@selector(connectionFinished:)]) {
        [connection.callBackDelegate_ performSelector:@selector(connectionFinished:) withObject:connection];
    }
    
    //将成功的请求从请求队列中移除
    @synchronized (connectionArray) {
        for (InternetConnection *removeConn in connectionArray) {
            if ([removeConn isEqual:connection]) {
                [removeConn cancel];
                [connectionArray removeObject:removeConn];
                break;
            }
        }
    }
    activeConnectionCount -= 1;
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //zsb begin
    if (!ACDAtA.isIndicator) {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows objectAtIndex:0] animated:YES];
        
    }

    //zsb end
    
    //自动开始请求队列第一位（先进先出）连接
    [self startNextConnection];

}

- (void)connection:(InternetConnection *)connection didFailWithError:(NSError *)error {
    if (isLog) {
        NSLog(@"internet error code = %i, description = %@", [error code], [error localizedDescription]);
    }
    
    //zsb begin
    if (!ACDAtA.isIndicator) {
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].windows objectAtIndex:0] animated:YES];
        
    }

    //zsb end

	BOOL isUserCancel = NO;
    switch ([error code]) {
        case kCFURLErrorUnknown:
            [self alertWithDelegate:nil info:URLErrorUnknown];
            break;
        case kCFURLErrorBadURL:
            [self alertWithDelegate:nil info:URLErrorBadURL];
            break;
        case kCFURLErrorCannotFindHost:
            [self alertWithDelegate:nil info:URLErrorCannotFindHost];
            break;
        case kCFURLErrorNotConnectedToInternet:
            [self alertWithDelegate:nil info:URLErrorNotConnectedToInternet];
            break;
        case kCFURLErrorCannotConnectToHost:
            [self alertWithDelegate:nil info:URLErrorCannotConnectToHost];
            break;
        case kCFURLErrorTimedOut:
            [self alertWithDelegate:nil info:URLErrorTimedOut];
            break;
        case kCFURLErrorCancelled://URLErrorCancelled
            if (isLog) {
                NSLog(@"%@", [NSString stringWithFormat:@"用户取消连接 id = %d", connection.identityID_]);
            };
            isUserCancel = YES;
            break;
        default:
            break;
    }
    
    if ([connection.callBackDelegate_ respondsToSelector:@selector(connectionFailed:)] && !isUserCancel) {
        [connection.callBackDelegate_ performSelector:@selector(connectionFailed:) withObject:error];
    }
    
    [connectionArray removeObject:connection];
    activeConnectionCount -= 1;
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    //自动开始请求队列第一位（先进先出）连接
    [self startNextConnection];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    if (isLog) {
        NSLog(@"缓存输出");
    }
    return cachedResponse;
}

- (void)startNextConnection {
    if ([connectionArray count] > 0) {
        InternetConnection *conn = [connectionArray objectAtIndex:0];
        [conn start];
        conn.active_ = YES;
        activeConnectionCount += 1;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = isNetworkActivityIndicatorVisible;

        //zsb begin
        if (!ACDAtA.isIndicator) {
            [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].windows objectAtIndex:0] animated:YES];
        }

        //zsb end
        if (isLog) {
            NSLog(@" \n队列网络请求开始：%@", [conn description]);
        }
    }
}

- (void)alertWithDelegate:(id)delegate_ info:(NSString *)alertInfo {
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                    message:alertInfo
                                                   delegate:delegate_
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

#pragma mark ----------for SSL----------
#if 1
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
	if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
	{
//		if ([trustedHosts containsObject:challenge.protectionSpace.host])
			[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	}
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}
#endif
@end
