//
//  ApplyBigView.m
//  PayProject
//
//  Created by Taiping002 on 2017/4/14.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "ApplyBigView.h"
#import <MBProgressHUD.h>
@implementation ApplyBigView
{

    BOOL Next;
}


-(id)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor clearColor];
        self.userInteractionEnabled=YES;
  
        [self initUI];
    }

    return self;

}
-(void)initUI
{
 CGFloat w= (Width-80)/3;
    self.applyview=[[ApplyView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 151)];
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame=CGRectMake((self.frame.size.width-w)*0.5, 152, w, 50);
    [self.loginBtn setBackgroundColor:[UIColor greenColor]];
    [self.loginBtn setTitle:@"查询" forState:0];
    [self.loginBtn setTitleColor:[UIColor blackColor] forState:0];
   
    Next=NO;
   
  
  //  [self.loginBtn addTarget:self action:@selector(comfirom:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(comfirom:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginBtn];
    [self addSubview:self.applyview];
    
    


}
-(void)comfirom:(UIButton*)sender
{

    NSLog(@"%@",self.applyview.text1);
     [self.loginBtn setTitle:@"下一步" forState:0];

if(sender.selected)
{

    Next=YES;
}
    sender.selected=YES;
    NSLog(@"就跟");

    [self.delegate addtableview:Next];
    
}

@end
