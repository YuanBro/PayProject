//
//  LanuchViewController.m
//  PayProject
//
//  Created by yuan on 2017/1/11.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "LanuchViewController.h"
#import "UserLoginView.h"
#import "HomeViewController.h"
#import "NavigationController.h"
@interface LanuchViewController ()

@end

@implementation LanuchViewController
{
    
    UserLoginView* loginview;
    UIImageView *logoView;
    UIImageView *handView;
    
}
- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return  UIDeviceOrientationLandscapeLeft;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logionsuccess:) name:@"success" object:nil];
    logoView = [[UIImageView alloc] initWithFrame:CGRectMake(378, 177-40, 348 , 348)] ;

    
    
//    if (is_iOS7) {
//        
//        logoView.frame = CGRectMake(378, 157, 348, 348);
//    }
    
    [logoView setImage:[UIImage imageNamed:@"LOGO1.png"]];
    [self.view addSubview:logoView];
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView* backimage=[[UIImageView alloc]initWithFrame:self.view.frame];
    backimage.image=[UIImage imageNamed:@"background123"];
    
    [self.view addSubview:backimage];
    
    UIImageView *cloudView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width*1.57, Height)] ;
    [cloudView setImage:[UIImage imageNamed:@"Clouds.png"]];
    [self.view addSubview:cloudView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:4];
    
    // cloudView.frame.size.origin.x -= 563;
    CGRect cloudframe;
    cloudframe=cloudView.frame;
    cloudframe.origin.x-=563;
    [cloudView setFrame:cloudframe];
    [UIView commitAnimations];
    //[controller setModalTransitionStyle:transition];//???
    
//    loginview=[[UserLoginView alloc]initWithFrame:CGRectMake(319, 778, 384, 320)];
    loginview=[[[NSBundle mainBundle]loadNibNamed:@"UserLoginView" owner:nil options:nil] objectAtIndex:0];
    loginview.frame=CGRectMake(319, 778, 384, 320);
    loginview.tag = -100;
    loginview.neiqin.selected=YES;
    [self.view addSubview:loginview];
    
    [UIView beginAnimations:NULL context:NULL];//动画效果
    [UIView setAnimationDelegate:self];
    //    [UIView setAnimationDidStopSelector:@selector(activeUserNameField)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:3];
    loginview.frame=CGRectMake(319, 224+100, 384, 320);
    [UIView commitAnimations];
}

-(void)logionsuccess:(NSNotification *)nonoty
{
    NavigationController* nav=[[NavigationController alloc]initWithRootViewController:[HomeViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
