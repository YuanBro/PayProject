//
//  CheckModel.h
//  PayProject
//
//  Created by Taiping002 on 2017/4/17.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckModel : NSObject
@property(nonatomic,copy)    NSString* PersonNum;    //保单号
@property(nonatomic,copy)    NSString* ApplyName;    //投保人
@property(nonatomic,copy)    NSString* BenifitName;  //被保人
@property(nonatomic,assign)  NSNumber* Status;            //是否暂停

////单例共享数据
//+ (CheckModel *)sharedInstance;
@end
