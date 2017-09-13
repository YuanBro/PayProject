//
//  PerTextField.m
//  PayProject
//
//  Created by Taiping002 on 2017/4/13.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "PerTextField.h"

@implementation PerTextField

-(id)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        self.borderStyle = UITextBorderStyleNone;;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.font = [UIFont systemFontOfSize:18];
        self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.textAlignment = NSTextAlignmentRight;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }

    return self;
}

@end
