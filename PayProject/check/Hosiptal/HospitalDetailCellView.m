//
//  HospitalDetailCellView.m
//  TPL-AUTO-CLAIM-iPad
//
//  Created by concise on 12-12-14.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#import "HospitalDetailCellView.h"

@implementation HospitalDetailCellView

@synthesize imageView;

- (id)initWithFrame:(CGRect)frame delegate:(id)delegate title:(NSString *)title placeHolder:(NSString *)placeHolder clearButtonMode:(UITextFieldViewMode)clearButtonMode tag:(NSInteger)fieldTag {
    if (self = [super initWithFrame:frame]) {
        //红色对号 和绿色对号
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apply_button_wrong.png"]];
        imageView.frame = CGRectMake(0, 0, 21, 44);
        [self addSubview:imageView];
        //前面标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 7, 100, 30)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont boldSystemFontOfSize:16];
        titleLabel.text = title;
        [self addSubview:titleLabel];
        [titleLabel release];
        //输入框
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, frame.size.width - 100, 44)];
        textField.delegate = delegate;
        textField.backgroundColor = [UIColor clearColor];
        textField.textAlignment = NSTextAlignmentRight;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.font = [UIFont boldSystemFontOfSize:15];
        textField.placeholder = placeHolder;
        textField.clearButtonMode = clearButtonMode;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.returnKeyType = UIReturnKeyNext;
        textField.textColor = [UIColor colorWithHexString:@"7b4001"];
        textField.tag = fieldTag;
        [self addSubview:textField];
        [textField release];
    }
    return self;
}

- (void)changeTextFieldText:(NSString *)text {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            textField.text = text;
        }
    }
}

- (BOOL)isFirst {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            if ([textField isFirstResponder]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)resignFirst {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            if ([textField isFirstResponder]) {
                [textField resignFirstResponder];
            }
        }
    }
}

- (UITextField *)getField {
    for (UIView *view in self.subviews) {//3个 imageView label textField
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            return textField;
        }
    }
    return nil;
}

- (void)becomeFirst {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            [textField becomeFirstResponder];
        }
    }
}

- (void)changeStatus:(CellView_Detail)detail {
    switch (detail) {
        case Detail_Null:
            [imageView setImage:[UIImage imageNamed:@"apply_button_wrong.png"]];
            break;
        case Detail_Right:
            [imageView setImage:[UIImage imageNamed:@"apply_button_right.png"]];
            break;
        case Detail_Wrong:
            [imageView setImage:[UIImage imageNamed:@"apply_button_wrong.png"]];
            break;
        default:
            break;
    }
}

- (void)dealloc {
    [imageView release];
    [super dealloc];
}

@end
