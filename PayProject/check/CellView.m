//
//  CellView.m
//  PayProject
//
//  Created by Taiping002 on 2017/4/14.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "CellView.h"
#define SW         self.frame.size.width
#define SH         self.frame.size.height
@implementation CellView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"kalanBackground.png"]];
        [self addsublabel];
        
    }
    
    
    return self;
    
}
-(void)addsublabel
{
    
    CGFloat w=(SW-3)/6;
    
    for (int i=0; i<4; i++) {
        UILabel* label=[[UILabel alloc]init];
        label.textColor=[UIColor whiteColor];
        label.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"kalan_case.png"]];
        label.font=[UIFont systemFontOfSize:18];
        label.textAlignment=NSTextAlignmentCenter;
        switch (i) {
            case 0:
            {
                label.frame=CGRectMake(0, 0, 2*w, SH);
                label.text=@"保单号";
            }
                break;
            case 1:
            {
                label.frame=CGRectMake(2*w+1, 0,w, SH);
                label.text=@"投保人姓名";
            }
                break;
            case 2:
            {
                label.frame=CGRectMake(2*w+1+w+1, 0, w-1, SH);
                label.text=@"被保人姓名";
            }
                break;
            case 3:
            {
                label.frame=CGRectMake(2*w+1+w+1+w+1, 0, 2*w, SH);
                label.text=@"是否暂停";
            }
                break;
                
            default:
                break;
        }
        
        [self addSubview:label];
    }
    
}

@end
