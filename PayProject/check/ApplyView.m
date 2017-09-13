//
//  ApplyView.m
//  PayProject
//
//  Created by Taiping002 on 2017/3/7.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "ApplyView.h"
#import "PerLabel.h"
#import "PerTextField.h"
#import "PersonModel.h"
#define W     self.frame.size.width
#define H     self.frame.size.height


@implementation ApplyView


@synthesize text1;
@synthesize idTypeField_;
@synthesize NumTypeField_;
@synthesize NameField_;
@synthesize bornField_;
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {  UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024-40, 151)];
        imageview.image=[UIImage imageNamed:@""];
        [self addSubview:imageview];
        [self initOne];
    }
    return self;
}

-(void)initOne
{
    //第一行保单号
//    backview1=[[UIView alloc]initWithFrame:CGRectMake(0, 50, W,  H-50)];
//    backview1.backgroundColor=[UIColor clearColor];
//    backview2=[[UIView alloc]initWithFrame:CGRectMake(0, 50, W, H-50)];
//    backview2.backgroundColor=[UIColor clearColor];
    UIImageView *AccidentTitleImg=[[UIImageView alloc]init];
    AccidentTitleImg.frame=CGRectMake(0, 0, W, 50);
    AccidentTitleImg.image=[UIImage imageNamed:@"kalanbutton2.png"];
    [self addSubview:AccidentTitleImg];
    
    self.btn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, W*0.5, 50)];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"kalan_case.png"] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn1 setTitle:@"保单号+出险客户证件号" forState:UIControlStateNormal];
    self.btn1.titleLabel.font=[UIFont systemFontOfSize:20];
    [self.btn1 addTarget:self action:@selector(chackAction1:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.tag=0;
    [self addSubview:self.btn1];
    
    self.btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    self.btn2.frame=CGRectMake(W/2.0, 0, W/2.0, 50);
    [self.btn2 setTitle:@"保单号+出险客户信息" forState:UIControlStateNormal];
    [self.btn2 addTarget:self action:@selector(chackAction1:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 setTitleColor:[UIColor colorWithRed:72/255.0 green:192/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
     //[self.btn2 setBackgroundImage:[UIImage imageNamed:@"kalan_case.png"] forState:UIControlStateSelected];
    self.btn2.titleLabel.font=[UIFont systemFontOfSize:20];
    self.btn2.tag=1;
    [self addSubview:self.btn2];
    
    [self inittext];

}

-(void)loadview2
{
    //第二种方式
      CGFloat width=W/2-0.5;
    [self addSubview:self.backview2];
    self.backview2.hidden=YES;
    //姓名
    CGFloat width1=width*0.5-0.5;
    PerLabel* name=[[PerLabel alloc]initWithFrame:CGRectMake(width+1, 0, width1, 50)];
    name.text=@"   姓名";
    [self.backview2 addSubview:name];
    
    NameField_ = [[PerTextField alloc] initWithFrame:CGRectMake(width+1+width1+1-200,0,180, 50)];
    NameField_.delegate = self;
    NameField_.placeholder =@"花花";
    [self.backview2 addSubview:NameField_];
    
    //出生日期
    PerLabel* born=[[PerLabel alloc]initWithFrame:CGRectMake(width+1+width1+1, 0, width1, 50)];
    born.text=@"   出生日期";
    [self.backview2 addSubview:born];
    
    bornField_ = [[PerTextField alloc] initWithFrame:CGRectMake(width+1+width1+1+width1-200, 0,180, 50)];
    bornField_.delegate = self;
    bornField_.placeholder =@"请输入";

    [self.backview2 addSubview:bornField_];
    
    //性别
    PerLabel* sex=[[PerLabel alloc]initWithFrame:CGRectMake(width+1, 51, width, 50)];
    sex.text=@"   性别";
    [self.backview2 addSubview:sex];
    
    //男、女
    NSArray *array = [NSArray arrayWithObjects:@"男",@"女", nil];
    //初始化UISegmentedControl
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:array];
    segment.tintColor=[UIColor greenColor];
    segment.selectedSegmentIndex=0;
    //设置frame
    segment.frame = CGRectMake(width+1+width1+1+width1-140, 13+51, 120, 24);
    //添加到视图
    [self.backview2 addSubview:segment];
    
    //    PerLabel* label=[[PerLabel alloc]initWithFrame:CGRectMake(0, 0, width, H-50)];
    //    label.text=@"      保单号";
    //
    //    text=[[PerTextField alloc]initWithFrame:CGRectMake(width-230, 0, 200, H-50)];
    //    text.placeholder = @"请输入保单号  ";
    //    text.delegate=self;
    //保单号
    PerLabel* label1=[[PerLabel alloc]initWithFrame:CGRectMake(0, 0, width, H-50)];
    label1.text=@"      保单号";[self.backview2 addSubview:label1];
    text1.placeholder = @"请输入保单号  ";
    text1.delegate=self;

    [self.backview2  addSubview:text1];


}
-(void)inittext
{
    
    [self addSubview:self.backview1];
    CGFloat width=W/2-0.5;

//保单号
 PerLabel* label1=[[PerLabel alloc]initWithFrame:CGRectMake(0, 0, width, H-50)];
    label1.text=@"      保单号";
    [self.backview1 addSubview:label1];
    text1=[[PerTextField alloc]initWithFrame:CGRectMake(width-230, 0, 200, H-50)];
    text1.placeholder = @"请输入保单号  ";
    text1.delegate=self;

    [self.backview1 addSubview:text1];
    
    //证件类型
    PerLabel* label2=[[PerLabel alloc]initWithFrame:CGRectMake(width+1, 0,width, 50)];
    label2.text=@"     证件类型";
    [self.backview1 addSubview:label2];
    
    idTypeField_ = [[PerTextField alloc] initWithFrame:CGRectMake(W-200, 0,180, 50)];
    idTypeField_.delegate = self;
    idTypeField_.placeholder =@"请输入证件类型";
    [self.backview1 addSubview:idTypeField_];
    
    //证件号码
    PerLabel* label3=[[PerLabel alloc]initWithFrame:CGRectMake(width+1, 51, width, 50)];
    label3.text=@"     证件号码";
    [self.backview1 addSubview:label3];
    
    NumTypeField_ = [[PerTextField alloc] initWithFrame:CGRectMake(W-200, 51,180, 50)];
    NumTypeField_.delegate = self;
    NumTypeField_.placeholder =@"请输入证件号码";

    [self.backview1 addSubview:NumTypeField_];
    
    
}

-(void)chackAction1:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 0:
        {
            [self.btn1 setBackgroundImage:[UIImage imageNamed:@"kalan_case.png"] forState:UIControlStateNormal];
            
            [self.btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.btn2 setBackgroundImage:[UIImage imageNamed:@"nil"] forState:UIControlStateNormal];
           [self.btn2 setTitleColor:[UIColor colorWithRed:72/255.0 green:192/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
            
            self.backview2.hidden=YES;
            self.backview1.hidden=NO;
        
        }
            break;
        case 1:
        {
            [self.btn2 setBackgroundImage:[UIImage imageNamed:@"kalan_case.png"] forState:UIControlStateNormal];
            
            [self.btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.btn1 setBackgroundImage:[UIImage imageNamed:@"nil"] forState:UIControlStateNormal];
            [self.btn1 setTitleColor:[UIColor colorWithRed:72/255.0 green:192/255.0 blue:235/255.0 alpha:1] forState:UIControlStateNormal];
           
            [self loadview2];
            
            self.backview2.hidden=NO;
            self.backview1.hidden=YES;
            
        }
            break;
            
        default:
            break;
    }

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
  
    if (textField==idTypeField_) {
        [idTypeField_ resignFirstResponder];
        NSArray* TypeArry=[NSArray arrayWithObjects:ID_TYPE_TITLES, nil];
        NSLog(@"%lu",TypeArry.count);
        UIViewController* popcontroller=[[UIViewController alloc]init];
        UIView* typeview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, (50+1)*TypeArry.count)];
        
        for (int i=0; i<TypeArry.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(0, i*51, 320, 50);
            btn.backgroundColor=[UIColor whiteColor];
            [btn setTitle:TypeArry[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.tag=i;
            [btn addTarget:self action:@selector(SubForCaseKindAction:) forControlEvents:UIControlEventTouchUpInside];
            UILabel* label=[UILabel new];
             label.backgroundColor=[UIColor groupTableViewBackgroundColor];
            label.frame=CGRectMake(0, 50*(i+1), 320, 1);
            [typeview addSubview:label];
            [typeview addSubview:btn];

        }
        popcontroller.view=typeview;
        
        CGRect rect= CGRectMake(W-200, 50,180, 50);
        _popvc = [[UIPopoverController alloc] initWithContentViewController:popcontroller];
        [_popvc setValue:[NSNumber numberWithInt:1] forKey:@"popoverBackgroundStyle"];

        
        //            _popvc.contentViewController.view.layer.cornerRadius=8;
        //            _popvc.contentViewController.view.clipsToBounds=YES;
        //            _popvc.popoverBackgroundViewClass = [CustomPopoverBackgroundView class];
        [_popvc setPopoverContentSize:CGSizeMake(320,51*10) animated:NO];
        [_popvc presentPopoverFromRect:rect inView:self permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        _popvc.delegate = self;
    }
    
}
-(void)SubForCaseKindAction:(UIButton*)sender
{

    idTypeField_.text = [[PersonIdType componentsSeparatedByString:@","] objectAtIndex:sender.tag];

}

-(UIView*)backview1
{

    if (!_backview1) {
        _backview1=[[UIView alloc]initWithFrame:CGRectMake(0, 50, W,  H-50)];
        _backview1.backgroundColor=[UIColor clearColor];
        _backview1.hidden=NO;
    }

    return _backview1;
}
-(UIView*)backview2
{
    
    if (!_backview2) {
        _backview2=[[UIView alloc]initWithFrame:CGRectMake(0, 50, W, H-50)];
        _backview2.backgroundColor=[UIColor clearColor];
        _backview2.hidden=YES;
    }
    return _backview2;
}
@end
