//
//  UserLoginView.m
//  PayProject
//
//  Created by yuan on 2017/1/11.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "UserLoginView.h"
#import "LanuchViewController.h"
@interface UserLoginView()
;

@end
@implementation UserLoginView
- (IBAction)neiqingbtn:(UIButton *)sender {
    sender.selected=YES;
     self.daili.selected=NO;
    self.dalirenText.textColor=[UIColor whiteColor];
}
- (IBAction)dailibtn:(UIButton *)sender {
    sender.selected=YES;
    self.neiqinText.textColor=[UIColor whiteColor];
    self.dalirenText.textColor=[UIColor blueColor];
    self.neiqin.selected=NO;
   
   
    
}
- (IBAction)logion:(UIButton *)sender
{
    //发送登录成功通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"success" object:nil];
  
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
