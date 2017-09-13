//
//  PerLabel.m
//  PayProject
//
//  Created by Taiping002 on 2017/4/13.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "PerLabel.h"

@implementation PerLabel

-(id)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"kalanBackground.png"]];
        self.textColor=[UIColor blackColor];
        self.textAlignment=NSTextAlignmentLeft;
    }

    return self;
}

@end
