//
//  InternetConnection.m
//  ModelBuilder
//
//  Created by concise on 12-11-1.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#import "InternetConnection.h"

@implementation InternetConnection

@synthesize identityID_;
@synthesize cacheData_;
@synthesize callBackDelegate_;
@synthesize active_;
@synthesize isStoreCache_;
@synthesize returnDataType_;
@synthesize returnDataEncoding_;

- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately
{
    if (self = [super initWithRequest:request delegate:delegate startImmediately:startImmediately]) {
        self.identityID_ = -1;
        self.active_ = NO;
        self.isStoreCache_ = NO;
        NSMutableData *data = [[NSMutableData alloc] initWithCapacity:100];
        self.cacheData_ = data;
      
    }
    
    return self;
}

- (void)dealloc {
   
}

@end
