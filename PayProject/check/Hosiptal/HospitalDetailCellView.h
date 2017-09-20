//
//  HospitalDetailCellView.h
//  TPL-AUTO-CLAIM-iPad
//
//  Created by concise on 12-12-14.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Detail_Null,//空
    Detail_Right,
    Detail_Wrong
} CellView_Detail;

@interface HospitalDetailCellView : UIView


@property (nonatomic, retain) UIImageView *imageView;

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate title:(NSString *)title placeHolder:(NSString *)placeHolder clearButtonMode:(UITextFieldViewMode)clearButtonMode tag:(NSInteger)fieldTag;
//改变文本框内容
- (void)changeTextFieldText:(NSString *)text;
//第一响应
- (BOOL)isFirst;
//注销第一响应
- (void)resignFirst;
//获得textField
- (UITextField *)getField;
//获得焦点
- (void)becomeFirst;
//改变状态
- (void)changeStatus:(CellView_Detail)detail;
@end
