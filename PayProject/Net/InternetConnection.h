//
//  InternetConnection.h
//  ModelBuilder
//
//  Created by concise on 12-11-1.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#import <Foundation/Foundation.h>

//继承的URLConnection
@interface InternetConnection : NSURLConnection {
    NSInteger       identityID_;
    NSMutableData   *cacheData_;
//    id              callBackDelegate_;
    BOOL            active_;
    BOOL            isStoreCache_;
    NSString        *returnDataType_;
    NSString        *returnDataEncoding_;

}

@property (nonatomic, assign) NSInteger identityID_; //请求标识，为每一个请求分配的ID
@property (nonatomic, retain) NSMutableData *cacheData_; //服务器返回的Data数据
@property (nonatomic, assign) id callBackDelegate_;
@property (nonatomic, assign) BOOL  active_;
@property (nonatomic, assign) BOOL  isStoreCache_;
@property (nonatomic, retain) NSString *returnDataType_;
@property (nonatomic, retain) NSString *returnDataEncoding_;

@end
