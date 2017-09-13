//
//  InternetConfig.h
//  ModelBuilder
//
//  Created by concise on 12-10-25.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//
#import<UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "InternetConnection.h"
#import "InternetConfigDefine.h"
#import  "MBProgressHUD.h"
#pragma mark - 

@protocol InternetConnectionDelegate <NSObject>

@optional
//下载成功解析返回数据
- (void)connectionFinished:(InternetConnection *)connection_;
//下载出错
- (void)connectionFailed:(NSError *)error;

@end

//封装下载类
@interface InternetConfig : NSObject<MBProgressHUDDelegate> {
    
    NSMutableDictionary *cacheData;         //缓存，
    NSInteger       activeConnectionCount;  //当前活跃网络连接计数
	NSMutableArray *connectionArray;        //网络请求等待队列
    
    BOOL isLog;                             //是否输出控制台，从配置文件中读取
    BOOL isNetworkActivityIndicatorVisible; //是否显示网络状态，从配置文件中读取
    NSMutableDictionary        *environment;
    MBProgressHUD *hub;
}

@property (nonatomic, retain) NSMutableDictionary  *environment;

+ (InternetConfig *)sharedInstance;    //单例
+ (void)destroy;                        //销毁单例

//发送服务器和接口拼装的URL请求
- (void)sendRequestWithID:(int)connectionId					//请求鉴别id
                URLString:(NSString *)urlType				//请求的url类型，从InternetConfigDefine.h文件中的枚举中得到,对应serverInterface的接口
					 Body:(NSString *)bodyString			//请求的body
		 CallBackDelegate:(id)callBackDelegate				//请求的回调对象
	RemovePreviousRequest:(BOOL)remove                      //是否移除之前的请求
                 useCache:(BOOL)isUseCache;					//是否使用缓存	

//发送非拼装的URL请求
- (void)sendRequestWithID:(int)connectionId					//请求鉴别连接id
          CustomURLString:(NSString *)urlKey                //请求的url类型，从InternetConfigDefine.h文件中的枚举中得到,对应customInterface的接口
					 Body:(NSString *)bodyString			//请求的body
		 CallBackDelegate:(id)callBackDelegate				//请求的回调对象
	RemovePreviousRequest:(BOOL)remove                      //是否移除之前的请求
                 useCache:(BOOL)isUseCache;					//是否使用缓存

//根据urlType从配置文件中获取url地址
//- (NSString *)getUrlStringWithUrlKey:(NSString*)urlKey IsCustom:(BOOL)isCustom;

//移除所有请求
- (void)removeAllRequest;

//系统低内存时移除所有不活动的请求
- (void)removeAllRequestForSystemMemory;

//根据身份ID取消指定请求
- (void)removeConnectionWithID:(NSInteger)identityID;

//根据url类型清空数据
//- (void)removeCacheWithURLType:(NSString*)urlType;

//移除所有的存储数据,用于重新登录
//- (void)removeAllData;

@end
