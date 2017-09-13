//
//  TaipingInternetConfig.h
//  TPL-AUTO-CLAIM-iPad
//
//  Created by concise on 12-11-14.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InternetConfig.h"
#import "XMLDecoder.h"

//typedef enum {
//    User
//};

@protocol Connection_Parser_Delegate <NSObject>
@optional

/**************请求的回调函数，在callBackDelegate类中实现**************/
//下载完成之后的代理方法
- (void)callBackWithRequestType:(NSString *)requestType
                       WithData:(NSDictionary*)callBackDictionary
                   WithNetState:(int)netState;

- (void)callBackFailed:(NSError *)error errorType:(int)errorType;

@end

@interface TaipingInternetConfig : InternetConfig <XMLDecoderDelegate> {
    NSMutableArray  *keys_;
    NSString        *requestType_;
}

- (void)sendRequestWithRequestType:(NSString *)requestType					//请求鉴别连接type
                              Body:(NSString *)bodyString                   //请求的body
                  CallBackDelegate:(id)callBackDelegate                     //请求的回调对象
             RemovePreviousRequest:(BOOL)remove                             //是否移除之前的请求
                          useCache:(BOOL)isUseCache                         //是否缓存数据以供下次使用
                    getDataForKeys:(NSArray *)keyArray;                     //返回数据键值


+ (TaipingInternetConfig *)sharedInstance;
- (void)resetKeys;
@end
