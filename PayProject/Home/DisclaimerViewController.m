//
//  DisclaimerViewController.m
//  TPL-AUTO-CLAIM-iPad
//
//  Created by Taiping002 on 14-1-16.
//  Copyright (c) 2014年 cisetech. All rights reserved.
//

#import "DisclaimerViewController.h"
#import "CheckViewController.h"
#import "PayViewController.h"

@interface DisclaimerViewController ()
{
    UIButton* checkbutton;//选中
    UILabel *completeLabel;//同意
    
    UIButton *confirmButton;//确认
    BOOL isSlected;

}



@end

@implementation DisclaimerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isSlected = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"succec1.png"]];
    //文字内容
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 1024, 40)];
    titleLabel.font = [UIFont boldSystemFontOfSize:24];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"反保险欺诈提示";
    [self.view addSubview:titleLabel];
    
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 180, 1024 - 60, 40)];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.font = [UIFont boldSystemFontOfSize:18];
    infoLabel.text = @"诚信是保险合同基本原则,涉嫌保险欺诈将承担以下责任：";
    infoLabel.textColor = [UIColor blackColor];
    [self.view addSubview:infoLabel];
    
    UILabel *infoLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 210, 1024 - 60, 80)];
    infoLabel1.backgroundColor = [UIColor clearColor];
    infoLabel1.font = [UIFont boldSystemFontOfSize:18];
    infoLabel1.text = @"[刑事责任]进行保险诈骗犯罪活动，可能会受到拘役、有期徒刑，并处罚金或者没收财产的刑事处罚。保险事故的鉴定人、证明人故意提供虚假的证明文件，为他人诈骗提供条件的,以保险诈骗罪的共犯论处。";
    infoLabel1.textColor = [UIColor blackColor];
    infoLabel1.lineBreakMode = NSLineBreakByWordWrapping;
    infoLabel1.numberOfLines = 0;
    
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:infoLabel1.text];
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:13.0f];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [infoLabel1.text length])];
    infoLabel1.attributedText = attributedString1;
    
    [self.view addSubview:infoLabel1];
  
    
    UILabel *infoLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 280, 1024 - 60, 80)];
    infoLabel2.backgroundColor = [UIColor clearColor];
    infoLabel2.font = [UIFont boldSystemFontOfSize:18];
    infoLabel2.text = @"[行政责任]进行保险诈骗活动,尚不构成犯罪的，可能会受到15日以下拘留、5000元以下罚款的行政处罚；保险事故的鉴定人、证明人故意提供虚假的证明文件，为他人诈骗提供条件的,也会受到相应的行政处罚。";
    infoLabel2.textColor = [UIColor blackColor];
    infoLabel2.lineBreakMode = NSLineBreakByWordWrapping;
    infoLabel2.numberOfLines = 0;
    
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:infoLabel2.text];
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle2 setLineSpacing:13.0f];
    [attributedString2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [infoLabel2.text length])];
    infoLabel2.attributedText = attributedString2;
    
    [self.view addSubview:infoLabel2];
    
    UILabel *infoLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(30, 360, 1024, 30)];
    infoLabel3.backgroundColor = [UIColor clearColor];
    infoLabel3.font = [UIFont boldSystemFontOfSize:18];
    infoLabel3.text = @"[民事责任]故意或因重大过失未履行如实告知义务，保险公司可能不承担赔偿或给付保险金的责任。";
    infoLabel3.textColor = [UIColor blackColor];
    [self.view addSubview:infoLabel3];

    
    
    
    
    //选中
    checkbutton=[UIButton buttonWithType:UIButtonTypeCustom];
  
        checkbutton.frame=CGRectMake(Width / 2-100-25+43+20+10, 470, 25, 25);
    
    [checkbutton setBackgroundImage:[UIImage imageNamed:@"report_xuanze1.png"] forState:UIControlStateNormal];
    [checkbutton addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkbutton];
    
    
   
    //同意
    
        completeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width / 2-100+53+20+10 ,470,200, 25)];
        
    completeLabel.font=[UIFont systemFontOfSize:22];
    completeLabel.text=@"同意";
    completeLabel.userInteractionEnabled=YES;
    completeLabel.backgroundColor=[UIColor clearColor];
    [self.view addSubview:completeLabel];
    
    
    //确认
    confirmButton=[UIButton buttonWithType:UIButtonTypeCustom];
   
    [confirmButton setFrame:CGRectMake(Width / 2 -240, 520, 200, 51)];
   
    confirmButton.titleLabel.font=[UIFont systemFontOfSize:22];
    confirmButton.enabled=NO;
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"report_chaxun.png"] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    confirmButton.tag=100;
    [self.view addSubview:confirmButton];
    
    //返回
    UIButton *claimQueryButton=[UIButton buttonWithType:UIButtonTypeCustom];

        [claimQueryButton setFrame:CGRectMake(Width / 2 +40, 520, 200, 51)];
    
    claimQueryButton.titleLabel.font=[UIFont systemFontOfSize:22];
    [claimQueryButton setTitle:@"返回" forState:UIControlStateNormal];
    [claimQueryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [claimQueryButton setBackgroundImage:[UIImage imageNamed:@"report_chaxun.png"] forState:UIControlStateNormal];
    [claimQueryButton addTarget:self action:@selector(goBackIndex) forControlEvents:UIControlEventTouchUpInside];
    claimQueryButton.tag=101;
 
    [self.view addSubview:claimQueryButton];
    




}
#pragma mark - 确认
-(void)confirm
{
    switch (ACDATA.TAG) {
        case 0:
                [self.navigationController pushViewController:[CheckViewController new] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[PayViewController new] animated:YES];
            break;
          
        default:
            break;
    }

    
    
}
#pragma mark-返回
-(void)goBackIndex{
    
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - 选中
- (void)complete:(UIButton *)sender {
    if (isSlected==YES) {
        
        [checkbutton setBackgroundImage:[UIImage imageNamed:@"report_xuanze.png"] forState:UIControlStateNormal];
        confirmButton.enabled=YES;
    }else{
        [checkbutton setBackgroundImage:[UIImage imageNamed:@"report_xuanze1.png"] forState:UIControlStateNormal];
        confirmButton.enabled=NO;
    }
    isSlected=!isSlected;
}



#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
