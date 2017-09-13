//
//  Acdata.h
//  PayProject
//
//  Created by Taiping002 on 2017/4/19.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Acdata : NSObject
@property(nonatomic,assign) int TAG;
+ (Acdata *)sharedInstance;
@end
