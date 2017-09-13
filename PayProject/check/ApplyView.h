//
//  ApplyView.h
//  PayProject
//
//  Created by Taiping002 on 2017/3/7.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerTextField.h"

@interface ApplyView : UIView<UITextFieldDelegate,UIPopoverControllerDelegate>
{

    UIPopoverController *_popvc;

}
@property(nonatomic,strong)UIButton* btn1;
@property(nonatomic,strong)UIButton* btn2;
@property(nonatomic,strong)UIImageView* imageview;
@property(nonatomic,strong) UIView* backview1;
@property(nonatomic,strong) UIView* backview2;

@property(nonatomic,strong) PerTextField*   text1;           //保单号
@property(nonatomic,strong) PerTextField*   idTypeField_;    //证件类型
@property(nonatomic,strong) PerTextField*   NumTypeField_;   //证件号码
@property(nonatomic,strong) PerTextField*   NameField_;      //姓名
@property(nonatomic,strong) PerTextField*  bornField_;       //出生日期
@property(nonatomic,strong) PerTextField*  text;
-(id)initWithFrame:(CGRect)frame;
@end
