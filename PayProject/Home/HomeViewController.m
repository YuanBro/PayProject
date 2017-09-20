//
//  HomeViewController.m
//  PayProject
//
//  Created by yuan on 2017/1/12.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "HomeViewController.h"
#import "DisclaimerViewController.h"
@interface HomeViewController ()
@property(nonatomic, weak) void(^block)();
@end

@implementation HomeViewController
{
    UIButton *backBtn;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
 self.view.backgroundColor = [UIColor colorWithRed:231.0/255 green:231.0/255 blue:231.0/255 alpha:1];
    [self initbackbtn];
    int value = 10;
    void(^blockC)() = ^{
        NSLog(@"just a block === %d", value);
    };
    
    NSLog(@"%@", blockC);
    _block = blockC;

    
}
-(void)backToFront
{

    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void)initbackbtn
{
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(15, 11, 100, 36)];
    backBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    [backBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"first_back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToFront) forControlEvents:UIControlEventTouchUpInside];
 
    
    UILabel *lineImgv=[[UILabel alloc]init];
    lineImgv.frame=CGRectMake(0, 0, 1024, 60);
    lineImgv.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:lineImgv];
       [self.view addSubview:backBtn];
    UILabel *backIMgv=[[UILabel alloc]init];
    backIMgv.backgroundColor=[UIColor whiteColor];
    backIMgv.frame=CGRectMake(20, 73-5, 1024-40, 362+20+5);
    backIMgv.userInteractionEnabled=YES;
    [self.view addSubview:backIMgv];
    UIImageView *firstIMgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"index_ad.png"]];
    firstIMgv.frame=CGRectMake(23, 73-2, 1024-46, 362+20+2);
    [self.view addSubview:firstIMgv];

    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"index_logo.png"]];
    [logoView setFrame:CGRectMake((1024 - 185) / 2, 4, 185, 51)];
    [self.view addSubview:logoView];
    
    //首页四个按钮的创建
  //  NSArray *titles = [IndexMenuListTitles componentsSeparatedByString:@","];
    NSMutableArray *menuImg=[NSMutableArray arrayWithObjects:@"first_mianshenhe.png",@"first_kuaipeifu",@"first_yichaxun.png",@"first_baoan.png",nil];
    for (int i = 0; i < [menuImg count]; i++) {
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuButton setFrame:CGRectMake(20 + 20*i + 231*i, 485, 231, 231)];
        [menuButton setBackgroundImage:[UIImage imageNamed:[menuImg objectAtIndex:i]] forState:UIControlStateNormal];
        [menuButton setTag:i];
        [menuButton addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:menuButton];
    }


}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(void)menuAction:(UIButton*)sender
{
    ACDATA.TAG=(int)sender.tag;

    switch (sender.tag) {
        case 0:
        {
            NSLog(@"免审核");
            [self.navigationController pushViewController:[DisclaimerViewController new] animated:YES];
             NSLog(@"%@", _block);
        }
            break;
        case 1:
        {
            NSLog(@"快赔付");
              [self.navigationController pushViewController:[DisclaimerViewController new] animated:YES];
        }
            break;
        case 2:
            NSLog(@"易查询");
            break;
        case 3:
            NSLog(@"E报案");
            break;
            
        default:
            break;
    }

}
@end
