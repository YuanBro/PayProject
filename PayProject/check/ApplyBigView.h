//
//  ApplyBigView.h
//  PayProject
//
//  Created by Taiping002 on 2017/4/14.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplyView.h"
@class ApplyBigView;
@protocol ApplyBigViewDelegate <NSObject>

-(void)addtableview:(BOOL)Next;

@end
@interface ApplyBigView : UIView
@property(nonatomic,strong)ApplyView*applyview;
@property(nonatomic,strong)UIButton* loginBtn;
@property(nonatomic,assign)id<ApplyBigViewDelegate>delegate;


-(id)initWithFrame:(CGRect)frame;
@end
