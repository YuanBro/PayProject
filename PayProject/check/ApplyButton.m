//
//  ApplyButton.m
//  PayProject
//
//  Created by yuan on 2017/1/24.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "ApplyButton.h"

@implementation ApplyButton
{
}

-(id)initWithFrame:(CGRect)frame 
{

    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setBackgroundImage:[UIImage imageNamed:@"apply_chek.png"] forState:0];
        
        _infolabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 3, 5, frame.size.width/2 + 30, frame.size.height - 10)];
        _infolabel.backgroundColor = [UIColor clearColor];
        _infolabel.textAlignment = NSTextAlignmentRight;
        _infolabel.font = [UIFont boldSystemFontOfSize:16];
        _infolabel.text = @"请选择";
        [self addSubview:_infolabel];
        
        
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, frame.size.width - 100);
    }

    return self;
}

-(void)changetext:(NSString *)test tag:(int)i
{

    self.infolabel.text=test;

}
@end
