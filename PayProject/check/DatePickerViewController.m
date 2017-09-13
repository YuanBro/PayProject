//
//  DatePickerViewController.m
//  TPL-AUTO-CLAIM-iPad
//
//  Created by concise on 12-11-8.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#import "DatePickerViewController.h"

#define kDatePickerTag  -99

@implementation DatePickerViewController

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    //datePicker.maximumDate = [NSDate dateWithTimeInterval:86400 sinceDate:[NSDate date]];
    datePicker.maximumDate=[NSDate date];
    datePicker.backgroundColor=[UIColor clearColor];
    [self.view addSubview:datePicker];
#if 0
    
    UIView *vvv=[[UIView alloc]initWithFrame:CGRectMake(0, 87, 320, 1)];
    vvv.backgroundColor=[UIColor colorWithRed:181/255.0 green:185/255.0 blue:188/255.0 alpha:1];
    vvv.userInteractionEnabled=YES;
    [self.view addSubview:vvv];
    [vvv release];
    
    UIView *vvv1=[[UIView alloc]initWithFrame:CGRectMake(0, 127, 320, 1)];
    vvv1.backgroundColor=[UIColor colorWithRed:181/255.0 green:185/255.0 blue:188/255.0 alpha:1];
    vvv1.userInteractionEnabled=YES;
    [self.view addSubview:vvv1];
    [vvv1 release];
#endif
//    if (is_iOS7) {
    
        UIView *v = [[datePicker subviews] objectAtIndex:0];
        
        //改变最外层的背景
        UIView *v0 = [[v subviews] objectAtIndex:0 ];
        v0.backgroundColor = [UIColor clearColor];
//        
//    }else{
//        
//        UIView *v = [[datePicker subviews] objectAtIndex:0];
//        
//        //改变最外层的背景
//        UIView *v0 = [[v subviews] objectAtIndex:0 ];
//        v0.backgroundColor = [UIColor whiteColor];
//        
//        UIView *v20 = [[v subviews] objectAtIndex:20];
//        v20.alpha = 0.0;
//        UIView *v1 = [[v subviews] objectAtIndex:1 ];
//        v1.alpha = 0;
//        UIView *v2 = [[v subviews] objectAtIndex:2 ];
//        v2.alpha = 0;
//        UIView *v3 = [[v subviews] objectAtIndex:3 ];
//        v3.alpha = 0;
//        UIView *v4 = [[v subviews] objectAtIndex:4 ];
//        v4.backgroundColor = [UIColor whiteColor];
//        UIView *v5 = [[v subviews] objectAtIndex:5 ];
//        v5.alpha = 0.0;
//        UIView *v6 = [[v subviews] objectAtIndex:6 ];
//        v6.alpha=0.6;
//        v6.frame=CGRectMake(0, 0, 0, 0);
//        
//        //第二列的设置--------------------------------
//        UIView *v7 = [[v subviews] objectAtIndex:7 ];
//        v7.alpha = 0;
//        UIView *v8 = [[v subviews] objectAtIndex:8 ];
//        v8.alpha = 0;
//        UIView *v9 = [[v subviews] objectAtIndex:9 ];
//        v9.alpha = 0;
//        UIView *v10 = [[v subviews] objectAtIndex:10 ];
//        v10.backgroundColor = [UIColor whiteColor];
//        UIView *v11 = [[v subviews] objectAtIndex:11 ];
//        v11.alpha = 0.0;
//        UIView *v12 = [[v subviews] objectAtIndex:12 ];
//        v12.alpha=0.6;
//        v12.frame=CGRectZero;
//        //    v12.backgroundColor=[UIColor blackColor];
//        
//        //第三列的设置--------------------------------
//        UIView *v13 = [[v subviews] objectAtIndex:13 ];
//        v13.alpha = 0;
//        UIView *v14 = [[v subviews] objectAtIndex:14 ];
//        v14.alpha = 0;
//        UIView *v15 = [[v subviews] objectAtIndex:15 ];
//        v15.alpha = 0;
//        UIView *v16 = [[v subviews] objectAtIndex:16 ];
//        v16.backgroundColor = [UIColor whiteColor];
//        UIView *v17 = [[v subviews] objectAtIndex:17 ];
//        v17.alpha = 0.0;
//        UIView *v18 = [[v subviews] objectAtIndex:18 ];
//        v18.alpha=0.6;
//        v18.frame=CGRectZero;
//        //    v18.backgroundColor=[UIColor blackColor];
//        
//        UIView *v19 = [[v subviews] objectAtIndex:19 ];
//        v19.alpha=0.0;
//    }
    
    datePicker.tag = kDatePickerTag;
  
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIDatePicker *datePicker = (UIDatePicker *)[self.view viewWithTag:kDatePickerTag];
    [self changeDate:datePicker];
}

- (void)changeDate:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [formatter stringFromDate:datePicker.date];
    if ([delegate respondsToSelector:@selector(changeDateWith:)]) {
        [delegate changeDateWith:dateString];
    }
}

- (void)setMaxDate:(NSDate *)maxDate {
    UIDatePicker *datePicker = (UIDatePicker *)[self.view viewWithTag:kDatePickerTag];
    [datePicker setMaximumDate:maxDate];
}

- (void)setminiDate:(NSDate *)miniDate {
    UIDatePicker *datePicker = (UIDatePicker *)[self.view viewWithTag:kDatePickerTag];
    [datePicker setMinimumDate:miniDate];
}

- (void)dealloc {

}

@end
