//
//  SectionView.h
//  PayProject
//
//  Created by Taiping002 on 2017/4/14.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckModel.h"

@interface SectionView : UIButton
@property(nonatomic,assign) NSInteger  Section;
@property(nonatomic,strong) UIColor* textcolor;
@property(nonatomic,copy) NSArray* datarray;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIImageView *imgView1;
@property(nonatomic,strong)CheckModel* model;

-(id)initWithFrame:(CGRect)frame and:(NSInteger)Section  CheckModel:(CheckModel*)model;

//- (void)setStatusByImage:(BOOL)isExtend;
@end
