//
//  Acdata.m
//  PayProject
//
//  Created by Taiping002 on 2017/4/19.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "Acdata.h"

@implementation Acdata
@synthesize TAG;
static  Acdata *sharedInstance = nil;
+ (Acdata *)sharedInstance {
    @synchronized ([Acdata class]) {
        if (sharedInstance == nil) {
            sharedInstance = [[Acdata alloc] init];
            return sharedInstance;
        }
    }
    return sharedInstance;
}

+ (id)alloc {
    @synchronized ([Acdata class]) {
        sharedInstance = [super alloc];
        return sharedInstance;
    }
    return nil;
}



- (Acdata *)init {
    if (self = [super init]) {
//        _answerCodeArr = [[NSMutableArray alloc]init];
//        _nameArray = [[NSMutableArray alloc]init];
//        //_titleArray = [[NSMutableArray alloc]init];
//        _titleCountArray = [[NSMutableArray alloc]init];
//        IRDic=[[NSMutableDictionary alloc]init];
//        colorDic=[[NSMutableDictionary alloc]init];
//        isUserLogin = NO;
//        flag_first=NO;
//        flag_mulu=NO;
//        flag_net=NO;
//        flag_apply=NO;
//        flag_report=NO;
//        flag_btnEnable=NO;
//        flag_btnEnable1=NO;
//        flag_btnEnable2=NO;
//        flag_imgpicker=NO;
//        flag_IRV=NO;
//        isMoveAccept=NO;
//        isSelect=NO;
//        isSure=NO;
//        isOut=NO;
//        isPass=NO;
//        
//        arr_image=[[NSMutableArray alloc]init];
//        smallarr=[[NSMutableArray alloc]initWithCapacity:1];
//        smallarr1=[[NSMutableArray alloc]initWithCapacity:1];
//        smallarr2=[[NSMutableArray alloc]initWithCapacity:1];
//        
//        Name_ARR=[[NSMutableArray alloc]init];
//        ApplicationType=[[NSMutableArray alloc]init];
//        ACCResultType=[[NSMutableArray alloc]init];
//        ACCResultType1=[[NSMutableArray alloc]init];
//        First=[[NSMutableArray alloc]init];
//        flag_enter_from_indexview = NO;
//        SaveArrCount=0;
//        DeleteNumber=-1;
//        numberForArr=0;
//        _titleCountArrayIndex = 0;
//        _pictureSize = 0;
//        isIndicator = NO;
        
    }
    return self;
}


@end
