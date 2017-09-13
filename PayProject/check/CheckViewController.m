//
//  CheckViewController.m
//  PayProject
//
//  Created by yuan on 2017/1/12.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "CheckViewController.h"
#import "ApplyButton.h"
#import "ApplyView.h"
//#import "ApplyViewController.h"
#import "ApplyBigView.h"
#import "ApplyTableview.h"
#import <MBProgressHUD.h>
#import "CheckModel.h"
#import "DatePickerViewController.h"
#import "HosiptalView.h"
#import "ApplyMessiageView.h";
#import "ProtectMessiageView.h"


#define WIDTH (self.view.frame.size.width-36)/3
@interface CheckViewController ()<ApplyBigViewDelegate,UIPopoverControllerDelegate,DatePickerViewControllerDelagate>//免审核
@property(nonatomic,strong)ApplyButton* btn;//三个按钮
@end

@implementation CheckViewController
{
    UIPopoverController *_popvc;
    UIPopoverController *popover_;
    BOOL UP;
    ApplyBigView* checkview;
    UIButton* loginBtn;
    ApplyTableview* tableview;
    UIView*FrameView;
    CheckModel* Model;
    NSString* admissionDate;
    
    //视图
    
     //医院信息
    HosiptalView* hosipatalview;
    //申请人信息
    ApplyMessiageView* applynameView;
    //受益人信息
    ProtectMessiageView* protectnameView;
    
    //底部滑动视图
     UIScrollView        *scrollView;

      UIScrollView        *autoClaimView;
}
static CGFloat w;
- (void)viewDidLoad
{
    [super viewDidLoad];
    //背景视图
    scrollView = [[UIScrollView alloc] init];
    
    scrollView.frame = CGRectMake(0, 0, 1024, 768);
    scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"apply_background.png"]];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    self.view = scrollView;
    scrollView.scrollEnabled=NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAdmissionDate:) name:@"changeAdmissionDate" object:nil];
    Model=[CheckModel new];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"apply_background.png"]];
    FrameView=[[UIView alloc]initWithFrame:CGRectMake(20, 790, 1024-40, 768)];
    FrameView.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"apply_background.png"]];
    [self.view addSubview:FrameView];
    checkview=[[ApplyBigView alloc]initWithFrame:CGRectMake(0, 0, 1024-40, 202)];
    checkview.userInteractionEnabled=YES;
    checkview.delegate=self;
    
    self.navigationController.navigationBar.hidden=NO;
    self.title=@"免审核申请";
    w= (Width-48)/3;
    
    NSArray*title=@[@"出险客户",@"事故结果",@"事故时间"];
    for(int i=0;i<3;i++)
    {
        self. btn=[[ApplyButton alloc]initWithFrame:CGRectMake(12+(12+w)*i, 20, w, 40)];
        [self.btn setBackgroundColor:[UIColor clearColor]];
        
        [self.btn setTitleColor:[UIColor blackColor] forState:0];
        UP=NO;
        
        [self.btn setTitle:title[i] forState:0];
        self.btn.tag=i;
        [self.view addSubview:self.btn];
        [self.btn addTarget:self action:@selector(fun:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
  

    
}
-(void)fun:(UIButton*)sender
{
    
    switch (sender.tag)
    {
        case 0:
        {
            if(UP)
            {
                [UIView beginAnimations:@"" context:nil];
                [UIView setAnimationDuration:0.3];
                FrameView.frame=CGRectMake(20, 768, 1024-40,768);
                [UIView commitAnimations];
                UP=NO;
            }
            else
            {
                
                [FrameView addSubview:checkview];
                [UIView beginAnimations:NULL context:NULL];//动画效果
                [UIView setAnimationDelegate:self];
                //    [UIView setAnimationDidStopSelector:@selector(activeUserNameField)];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                [UIView setAnimationDuration:0.3];
                FrameView.frame=CGRectMake(20, 80, 1024-40, 768);
                [UIView commitAnimations];
                UP=YES;
            }
        }
            break;
        case 1:
        {
            NSLog(@"222");
            NSArray *case_kind_arr=[NSArray arrayWithObjects:@"住院", nil];
            UIViewController *sortViewController = [[UIViewController alloc] init];
            UIView *theView = [[UIView alloc] init];
            for (int i=0;i<1; i++) {
                theView.frame=CGRectMake(0, 0, 320, 50*i+50);
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=CGRectMake(0, i*51, 320, 50);
                btn.backgroundColor=[UIColor whiteColor];
                [btn setTitle:case_kind_arr[i] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.tag=i+10;
                [btn addTarget:self action:@selector(SubForCaseKindAction:) forControlEvents:UIControlEventTouchUpInside];
                [theView addSubview:btn];
                
                
            }
            
            sortViewController.view = theView;
          
            _popvc = [[UIPopoverController alloc] initWithContentViewController:sortViewController];
          
            [_popvc setValue:[NSNumber numberWithInt:1] forKey:@"popoverBackgroundStyle"];
            [_popvc setPopoverContentSize:CGSizeMake(320,51) animated:NO];
            
            
            [_popvc presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
            

            break;
        }
        case 2:
        {
            DatePickerViewController *datePickerViewController = [[DatePickerViewController alloc] init];
            datePickerViewController.delegate = self;
            if (admissionDate==nil) {
                [datePickerViewController setMaxDate:[NSDate date]];
            }else {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd";
                NSDate *admissDate = [NSDate dateWithTimeInterval:8 * 60 * 60 sinceDate:[formatter dateFromString:admissionDate]];
                [datePickerViewController setMaxDate:admissDate];
            }
            
            popover_ = [[UIPopoverController alloc] initWithContentViewController:datePickerViewController];
           
            popover_.delegate = self;
            popover_.popoverContentSize = CGSizeMake(320, 220);
            [popover_ setValue:[NSNumber numberWithInt:1] forKey:@"popoverBackgroundStyle"];
            [popover_ presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

        
        }
            break;
        default:
            break;
    }
    
}

-(void)addtableview:(BOOL)Next
{
  
    if (Next)
    {
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.3];
        FrameView.frame=CGRectMake(20, 768, 1024-40,768);
        [UIView commitAnimations];
        
         UP=NO;
       
    }
    else
    {
        
     
        tableview=[[ApplyTableview alloc]initWithFrame:CGRectMake(0, 250, 1024-40, 768-130-160-10) style:0];
        
        
        [FrameView addSubview:tableview];

        
    }
    
    Model=tableview.array[1];
 
    [self changetext:Model.ApplyName tag:0];
    
}

-(void)changetext:(NSString *)test tag:(int)i
{
//
//    switch (i)) {
//        case 0:
//         self.btn.infolabel=
//            break;
//            
//        default:
//            break;
//    }
    for (id obc in self.view.subviews) {
        if ([obc isKindOfClass:NSClassFromString(@"ApplyButton")]) {
            ApplyButton* btn=(ApplyButton*)obc;
            
            if (btn.tag==i) {
                NSLog(@"哈哈哈");
                btn.infolabel.text=test;
            }
           
        }
    }


}

#pragma mark - 事故结果
-(void)SubForCaseKindAction:(UIButton*)sender
{

    [self changetext:sender.titleLabel.text tag:1];
    
    [_popvc dismissPopoverAnimated:YES];

}
- (void)getAdmissionDate:(NSNotification *)info{
    
    admissionDate =[[NSString alloc] initWithString:info.userInfo[@"value"]];
    NSLog(@"getAdmissionDate：admissionDate:%@",admissionDate);
    
}
- (void)changeDateWith:(NSString *)dateString {
    [self changetext:dateString tag:2];
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    if (popoverController == popover_) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"validTime" object:nil];    }
    [self initViews];
}

- (void)initViews
{
    hosipatalview=[[HosiptalView alloc]initWithFrame:CGRectMake(12, 70+35+Height, 2*WIDTH, self.view.frame.size.height-105) itemCount:1];
      //  hospitalInfoView.delegate = self;
        [scrollView addSubview:hosipatalview];
        [scrollView sendSubviewToBack:hosipatalview];
        [UIView animateWithDuration:.5 animations:^{
    
    
        hosipatalview.frame = CGRectMake(12, 20+ 40 + 10, 2*WIDTH, self.view.frame.size.height-105);
                //            personInfoView.frame = CGRectMake(12, 65 + 15 + 2 + 20, 335, 480);
                //            beneficiaryInfoView.frame = CGRectMake(12, 340 + 15 + 20, 335, 480);
    
//                personInfoView.frame = CGRectMake(12,-35, 335, 480);
//                beneficiaryInfoView.frame = CGRectMake(12, 340 + 15 + 20-(65 + 15 + 2 + 20)-35, 335, 480);
    
         
//            confirmBtn.hidden=NO;
    
        }completion:^(BOOL finished) {
           
        }];
        

    
    
    //    CGFloat screenHeight = [[UIScreen mainScreen] applicationFrame].size.height;
//    
//    //医院信息视图
//    hospitalInfoView = [[HospitalInfoView alloc] initWithFrame:CGRectMake(320+30, 70 + 35 + screenHeight, 686-30, 650) itemCount:1];
//    hospitalInfoView.delegate = self;
//    [autoClaimView_ addSubview:hospitalInfoView];
//    [autoClaimView_ sendSubviewToBack:hospitalInfoView];
//    
//    //申请人
//    personInfoView = [[ApplyPersonInfoView alloc] initWithFrame:CGRectMake(12, 65 + 40 + screenHeight+2, 335, 480)];
//    personInfoView.backgroundColor=[UIColor clearColor];
//    [personInfoView initInsuredInfo:insuredInfo_];
//    [_scroperson addSubview:personInfoView];
//    
//    //受益人
//    beneficiaryInfoView = [[BeneficiaryInfoView alloc] initWithFrame:CGRectMake(12, 340 + 40 + screenHeight, 335, 480)];
//    
//    
//    [beneficiaryInfoView initBeneficiaryName:insuredInfo_ ];
//    [_scroperson addSubview:beneficiaryInfoView];
//    
//    [UIView animateWithDuration:.5 animations:^{
//        
//        confirmBtn.hidden=NO;
//        if (is_iOS7) {
//            
//            hospitalInfoView.frame = CGRectMake(320+30, 70 + 35 + 20, 686-30, 650);
//            //            personInfoView.frame = CGRectMake(12, 65 + 15 + 2 + 20, 335, 480);
//            //            beneficiaryInfoView.frame = CGRectMake(12, 340 + 15 + 20, 335, 480);
//            
//            personInfoView.frame = CGRectMake(12,-35, 335, 480);
//            beneficiaryInfoView.frame = CGRectMake(12, 340 + 15 + 20-(65 + 15 + 2 + 20)-35, 335, 480);
//            
//        }else{
//            
//            hospitalInfoView.frame = CGRectMake(320+30, 70 + 35, 686-30, 650);
//            personInfoView.frame = CGRectMake(12, 0, 335, 480);
//            beneficiaryInfoView.frame = CGRectMake(12, 340 + 40, 335, 480);
//        }
//        confirmBtn.hidden=NO;
//        
//    }completion:^(BOOL finished) {
//        [confirmBtn setEnabled:YES];
//    }];
//    
//    
//    
//    
//    //扣费助手
//    calculatorView = [[CalculatorView alloc] init];
//    calculatorView.delegate = self;
//    [autoClaimView_ addSubview:calculatorView];
//    isShowBtn=YES;
//    
//    _scroperson.scrollEnabled=NO;
//    
//    
//    //
//    //    //医院信息视图
//    //    hospitalInfoView = [[HospitalInfoView alloc] initWithFrame:CGRectMake(320+30, 70 + 35 + screenHeight, 686-30, 650) itemCount:1];
//    //    hospitalInfoView.delegate = self;
//    //    [autoClaimView_ addSubview:hospitalInfoView];
//    //    [autoClaimView_ sendSubviewToBack:hospitalInfoView];
//    //
//    //    //申请人照片
//    //
//    //    _personimage=[[UIImageView alloc]initWithFrame:CGRectMake(12, 65 + 40 + screenHeight+2, 335, 480)];
//    _personimage=[[UIImageView alloc]init];
//    //    [_personimage setImage:[UIImage imageNamed:@"lxt_335x335-4.png"]];
//    //
//    //   UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(warn:)];
//    //
//    //    _personimage.userInteractionEnabled=YES;
//    //
//    //    [_personimage addGestureRecognizer:tap];
//    //
//    //
//    //    [_scroperson addSubview:_personimage];
//    //
//    //    //申请人
//    //    personInfoView = [[ApplyPersonInfoView alloc] initWithFrame:CGRectMake(12, 340 + 40 + screenHeight, 335, 480)];
//    //    personInfoView.backgroundColor=[UIColor clearColor];
//    //    [personInfoView initInsuredInfo:insuredInfo_];
//    //    [_scroperson addSubview:personInfoView];
//    //
//    //    //受益人
//    //    beneficiaryInfoView = [[BeneficiaryInfoView alloc] initWithFrame:CGRectMake(12, 340+340+40 + 40 + screenHeight, 335, 480)];
//    //
//    //
//    //    [beneficiaryInfoView initBeneficiaryName:insuredInfo_ ];
//    //    [_scroperson addSubview:beneficiaryInfoView];
//    //
//    //    [UIView animateWithDuration:.5 animations:^{
//    //
//    //        confirmBtn.hidden=NO;
//    //        if (is_iOS7) {
//    //
//    //            _personimage.frame=CGRectMake(0, 0, 335, 310);
//    //
//    //            hospitalInfoView.frame = CGRectMake(320+30, 70 + 35 + 20, 686-30, 650);
//    //            personInfoView.frame = CGRectMake(0, 280, 335, 480);
//    //            beneficiaryInfoView.frame = CGRectMake(0, 230+230+90, 335, 480);
//    //        }
//    //
//    //        //        }else{
//    //        //
//    //        //            hospitalInfoView.frame = CGRectMake(320+30, 70 + 35, 686-30, 650);
//    //        //            personInfoView.frame = CGRectMake(0, -40, 335, 480);
//    //        //            beneficiaryInfoView.frame = CGRectMake(0, 230, 335, 480);
//    //        //        }
//    //        confirmBtn.hidden=NO;
//    //
//    //    }completion:^(BOOL finished) {
//    //        [confirmBtn setEnabled:YES];
//    //    }];
//    //    
//    //    
//    //    
//    //    
//    //    //扣费助手
//    //    calculatorView = [[CalculatorView alloc] init];
//    //    calculatorView.delegate = self;
//    //    [autoClaimView_ addSubview:calculatorView];
//    //    isShowBtn=YES;
//    
//    
}
@end
