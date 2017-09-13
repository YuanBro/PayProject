//
//  TaipingInternetConfig.m
//  TPL-AUTO-CLAIM-iPad
//
//  Created by concise on 12-11-14.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#import "TaipingInternetConfig.h"

#define NetError        -100
#define XMLParseError   -200

@implementation TaipingInternetConfig

static id callBackDelegate_ = nil;

static  TaipingInternetConfig *sharedInstance = nil;

#pragma mark -

+ (TaipingInternetConfig *)sharedInstance
{
    @synchronized ([TaipingInternetConfig class]) {
        if (sharedInstance == nil) {
            sharedInstance = [[TaipingInternetConfig alloc] init];
            return sharedInstance;
        }
    }
    [sharedInstance resetKeys];
    return sharedInstance;
}

+ (id)alloc {
    @synchronized ([TaipingInternetConfig class]) {
        sharedInstance = [super alloc];
        return sharedInstance;
    }
    return nil;
}

+ (void)destroy {
    [sharedInstance release];
    sharedInstance = nil;
}

- (TaipingInternetConfig *)init { 
    if (self = [super init]) {
        keys_ = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

#pragma mark -

- (void)resetKeys {
    [keys_ removeAllObjects];
    requestType_ = nil;
}

- (void)sendRequestWithRequestType:(NSString *)requestType					//请求鉴别连接type
                              Body:(NSString *)bodyString                   //请求的body
                  CallBackDelegate:(id)callBackDelegate                     //请求的回调对象
             RemovePreviousRequest:(BOOL)remove                             //是否移除之前的请求
                          useCache:(BOOL)isUseCache
                    getDataForKeys:(NSArray *)keyArray {
    
    callBackDelegate_ = callBackDelegate;
    [keys_ setArray:keyArray];
    requestType_ = [[[NSString alloc] initWithString:requestType] autorelease];
    
    NSArray *types = [RequestTypes componentsSeparatedByString:@","];
    for (int i = 0; i <[types count]; i++) {
        if ([requestType isEqualToString:[types objectAtIndex:i]]) {
            [super sendRequestWithID:i
                     CustomURLString:TaipingServerDev
                                Body:bodyString
                    CallBackDelegate:self
               RemovePreviousRequest:remove
                            useCache:isUseCache];
        }
    }

}

#pragma mark -
#pragma mark -----Internet-----

- (void)connectionFinished:(InternetConnection *)connection_ {
    NSString *str=[[NSString alloc]initWithData:connection_.cacheData_ encoding:NSUTF8StringEncoding];
    if ([str rangeOfString:@"<REQUEST_TYPE>C11</REQUEST_TYPE>"].location !=NSNotFound&&[str rangeOfString:@"Image Send Succeed"].location !=NSNotFound) {
        str=@"<?xml version=\"1.0\" encoding=\"UTF-8\"?><PACKET type=\"RESPONSE\" version=\"1.0\"><HEAD><REQUEST_TYPE>C11</REQUEST_TYPE><RESPONSE_CODE>1</RESPONSE_CODE><ERROR_CODE></ERROR_CODE><ERROR_MESSAGE></ERROR_MESSAGE></HEAD><BODY><NOTICE_MESSAGE>Image Send Succeed</NOTICE_MESSAGE></BODY></PACKET>";
        connection_.cacheData_=(NSMutableData *)[str dataUsingEncoding:NSUTF8StringEncoding];
    }
    [[XMLDecoder sharedInstance] decodeWithData:connection_.cacheData_ forKeys:keys_ callBackDelegate:self];
    
}

- (void)connectionFailed:(NSError *)error {
    NSLog(@"Tai ping internet config error = %@", [error localizedDescription]);//数据请求失败
    if ([callBackDelegate_ respondsToSelector:@selector(callBackFailed:errorType:)]) {
        [callBackDelegate_ callBackFailed:error errorType:NetError];
    }
}

#pragma mark -----XML Parse-----

- (void)parseXMLFinished:(NSDictionary *)xmlDic {
//    NSLog(@"parseXMLFinished , dic======= %@", xmlDic);
    if ([callBackDelegate_ respondsToSelector:@selector(callBackWithRequestType:WithData:WithNetState:)]) {
        [callBackDelegate_ callBackWithRequestType:requestType_
                                          WithData:xmlDic
                                      WithNetState:0];
    }
}
- (void)parseXMLFailed:(NSError *)parseError {
    NSLog(@"Tai ping XML parse error = %@", [parseError localizedDescription]);//数据解析失败
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                    message:@"数据解析失败"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
    if ([callBackDelegate_ respondsToSelector:@selector(callBackFailed:errorType:)]) {
        [callBackDelegate_ callBackFailed:parseError errorType:XMLParseError];
    }
}

#pragma mark -

@end
