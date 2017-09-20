//
//  HospitalDetailInfoView.m
//  TPL-AUTO-CLAIM-iPad
//
//  Created by concise on 12-11-9.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#import "HospitalDetailInfoView.h"
#import "HospitalDetailCellView.h"
#import "IllnessView.h"
#define horizontalLineCount 5
#define ItemHeight  480
//#define TextFieldTag    1000

#define IllnessTag      10000

@implementation HospitalDetailInfoView


@synthesize delegate,inter,payment;
//@synthesize hospital_;

static CGFloat offset_ = 0.0f;
int i=0;
-(void)ttt
{
    isyes=NO;
}
- (id)initWithFrame:(CGRect)frame target:(id)target_ inRow:(NSInteger)row diagnosePopover:(UIPopoverController *)popover {
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bbb:) name:@"aaa" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ttt) name:@"uuu" object:nil];
        self.backgroundColor=[UIColor clearColor];
   
       
        isyes=YES;


        //竖线
        UIView *verticalLine;
//        if (TestModeEx) {
//            verticalLine = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width / 2, frame.size.height / (horizontalLineCount+1)-6, 1, frame.size.height * 3 / (horizontalLineCount+1))];
//        } else {
            verticalLine = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width / 2, frame.size.height / horizontalLineCount-6, 1, frame.size.height * 3 / horizontalLineCount)];
//        }
        verticalLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"apply_line.png"]];
       
        [self addSubview:verticalLine];
      
        
        //4条横线
//        if (TestModeEx) {
//            for (int i = 0; i < (horizontalLineCount+1); i++) {
//                UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height * i / (horizontalLineCount+1)-6, frame.size.width, 1)];
//                if (i == 0) {
//                    
//                }else {
//                    horizontalLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"apply_line222.png"]];
//                }
//                [self addSubview:horizontalLine];
//                [horizontalLine release];
//            }
//        } else {
            for (int i = 0; i < horizontalLineCount; i++) {
                UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height * i / horizontalLineCount-6, frame.size.width, 1)];
                if (i == 0) {
                }else {
                    horizontalLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"apply_line222.png"]];
                }
              
                [self addSubview:horizontalLine];
            
            }
//        }
        
        
        //标题
        NSArray *titleArray = [HospitalInfoLists componentsSeparatedByString:@","];
        //1.入住医院
        hospitalNameView = [[HospitalDetailCellView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width * 0.8, 38)
                                                                                        delegate:self
                                                                                           title:[titleArray objectAtIndex:0]
                                                                                     placeHolder:MSG_CHOOSE
                                                                                 clearButtonMode:UITextFieldViewModeNever 
                                                                                             tag:0];
        //liucong begin
//        if (TestModeEx) {
//            [hospitalNameView getField].text = @"上海市瑞金医院";
//            [hospitalNameView changeStatus:Detail_Right];
//        }
        //liucong end
        [self addSubview:hospitalNameView];
        //2.入院日期
        hospitalbeginDateView = [[HospitalDetailCellView alloc] initWithFrame:CGRectMake(0, 44-6, frame.size.width / 2, 38)
                                                                     delegate:self
                                                                        title:[titleArray objectAtIndex:1]
                                                                  placeHolder:MSG_CHOOSE
                                                              clearButtonMode:UITextFieldViewModeNever
                                                                          tag:1];
        //liucong begin
        if (TestModeEx) {
            [hospitalbeginDateView getField].text = @"2013-07-10";
            [hospitalbeginDateView changeStatus:Detail_Right];
        }
        //liucong end
        [self addSubview:hospitalbeginDateView];
        //3.出院日期
        hospitalendDateView = [[HospitalDetailCellView alloc] initWithFrame:CGRectMake(frame.size.width / 2, 44-6, frame.size.width / 2, 38)
                                                                   delegate:self
                                                                      title:[titleArray objectAtIndex:2]
                                                                placeHolder:MSG_CHOOSE
                                                            clearButtonMode:UITextFieldViewModeNever
                                                                        tag:2];
        //liucong begin
        if (TestModeEx) {
            [hospitalendDateView getField].text = @"2013-07-15";
            [hospitalendDateView changeStatus:Detail_Right];
        }
        //liucong end
        [self addSubview:hospitalendDateView];
        //4.发票总金额
        hospitalTotalAmountView = [[HospitalDetailCellView alloc] initWithFrame:CGRectMake(0, 44*2-6, frame.size.width / 2, 38)
                                                                       delegate:self
                                                                          title:[titleArray objectAtIndex:3]
                                                                    placeHolder:MSG_INPUT
                                                                clearButtonMode:UITextFieldViewModeWhileEditing
                                                                            tag:3];
        //liucong begin
        if (TestModeEx) {
            [hospitalTotalAmountView getField].text = @"600";
            [hospitalTotalAmountView changeStatus:Detail_Right];
        }
        //liucong end
        [self addSubview:hospitalTotalAmountView];
        //统筹支付金额
        hospitalSocietyPayAmountView = [[HospitalDetailCellView alloc] initWithFrame:CGRectMake(frame.size.width / 2, 44*2-6, frame.size.width / 2, 38)
                                                                       delegate:self
                                                                          title:[titleArray objectAtIndex:5]
                                                                    placeHolder:MSG_INPUT
                                                                clearButtonMode:UITextFieldViewModeWhileEditing
                                                                            tag:5];
        //liucong begin
        if (TestModeEx) {
            [hospitalSocietyPayAmountView getField].text = @"100";
            [hospitalSocietyPayAmountView changeStatus:Detail_Right];
        }
        //liucong end
        [self addSubview:hospitalSocietyPayAmountView];
        //自费金额
        hospitalSelfAmountView = [[HospitalDetailCellView alloc] initWithFrame:CGRectMake(0, 44*3-6, frame.size.width / 2, 38)
                                                                       delegate:self
                                                                          title:[titleArray objectAtIndex:4]
                                                                    placeHolder:MSG_INPUT
                                                                clearButtonMode:UITextFieldViewModeWhileEditing
                                                                            tag:4];
        //liucong begin
        if (TestModeEx) {
            [hospitalSelfAmountView getField].text = @"0";
            [hospitalSelfAmountView changeStatus:Detail_Right];
        }
        //liucong end
        [self addSubview:hospitalSelfAmountView];
        //其他扣除
        hospitalOtherAmountView = [[HospitalDetailCellView alloc] initWithFrame:CGRectMake(frame.size.width / 2, 44*3-6, frame.size.width / 2, 38)
                                                                      delegate:self
                                                                         title:[titleArray objectAtIndex:6]
                                                                   placeHolder:MSG_INPUT
                                                               clearButtonMode:UITextFieldViewModeWhileEditing
                                                                           tag:6];
        //liucong begin
        if (TestModeEx) {
            [hospitalOtherAmountView getField].text = @"0";
            [hospitalOtherAmountView changeStatus:Detail_Right];
        }
        //liucong end
        [self addSubview:hospitalOtherAmountView];
        
        
        hospitalCountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"apply_button_wrong.png"]];
        hospitalCountImageView.frame = CGRectMake(0, 44*4-6, 21, 44);
        [self addSubview:hospitalCountImageView];
        //出院诊断
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 7 + 44*4-6, 100, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.text = [titleArray objectAtIndex:7];
        [self addSubview:label];
        [label release];

        //liucong begin
        if (TestModeEx) {
            [hospitalCountImageView setImage:[UIImage imageNamed:@"apply_button_right.png"]];
            UILabel *labeltest = [[UILabel alloc] initWithFrame:CGRectMake(220, 7 + 44*4-6, 300, 30)];
            labeltest.backgroundColor = [UIColor clearColor];
            labeltest.textAlignment = NSTextAlignmentRight;
            labeltest.font = [UIFont boldSystemFontOfSize:15];
            labeltest.textColor=[UIColor colorWithHexString:@"7b4001"];
            labeltest.text = @"急性上呼吸道感染";
            [self addSubview:labeltest];
            [labeltest release];
        }
        //liucong end
        
        // 删除住院信息
        deleteButton_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [deleteButton_ setFrame:CGRectMake(frame.size.width * 8.5 / 10.0+20, 0, 72, 43-6 )];
        [deleteButton_ setBackgroundImage:[UIImage imageNamed:@"apply_dele.png"] forState:UIControlStateNormal];
        deleteButton_.tag = row;
        if ([target_ respondsToSelector:@selector(deleteHospitalInfo:)]) {
            [deleteButton_ addTarget:target_ action:@selector(deleteHospitalInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self addSubview:deleteButton_];
        //增加
        addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"apply_caozuo.png"] forState:UIControlStateNormal];
        [addBtn setFrame:CGRectMake(572-40+10, 2 + 44 * 4+5-6, 60, 30)];
        [addBtn setTitle:@"增加" forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addIllness:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.tag = row;
        [self addSubview:addBtn];
        
        //liucong begin
        if (TestModeEx) {
            UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [removeBtn setBackgroundImage:[UIImage imageNamed:@"apply_caozuo.png"] forState:UIControlStateNormal];
            [removeBtn setFrame:CGRectMake(572-40+10, 2 + 44 * 5+5-6, 60, 30)];
            [addBtn setTitle:@"删除" forState:UIControlStateNormal];
            [removeBtn addTarget:self action:@selector(addIllness:) forControlEvents:UIControlEventTouchUpInside];
            removeBtn.tag = row;
            [self addSubview:removeBtn];
            
            UIButton *adBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [adBtn setBackgroundImage:[UIImage imageNamed:@"apply_caozuo.png"] forState:UIControlStateNormal];
            [adBtn setFrame:CGRectMake(572-40+10, 2 + 44 * 5+5-6, 60, 30)];
            [adBtn setTitle:@"增加" forState:UIControlStateNormal];
            [adBtn addTarget:self action:@selector(addIllness:) forControlEvents:UIControlEventTouchUpInside];
            adBtn.tag = row;
            [self addSubview:adBtn];
        }
        //liucong end
        
        illnessViews = [[NSMutableArray alloc] initWithCapacity:10];
    }

    return self;
}
-(void)bbb:(NSNotification *)notification
{
    NSMutableArray *aaa=[notification object];
    
    NSInteger illnessCount = [[aaa objectAtIndex:self.inter] integerValue];
    //backImgv.frame=CGRectMake(0, 0, 616, 220+illnessCount*44);
    NSLog(@"wocao%@",aaa);
    NSLog(@"fuck%d",self.superview.tag);
    
}

- (void)addIllness:(UIButton *)sender {

    [[NSNotificationCenter defaultCenter] postNotificationName:ILLNESS_DATA_SHOW_NOTIFICATION object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"3" object:nil];

}

- (void)deleteIllness:(UIButton *)sender {
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                    message:@"确认删除诊断信息?"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定", nil];
    alert.tag = sender.tag;
    [alert show];
    [alert release];
}

- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag != 5) {
    if (buttonIndex > 0) {
//        i--;
//        backImgv.frame=(CGRectMake(0, 0  , 616, 220+44*i));
        IllnessView *removeView = (IllnessView *)[self viewWithTag:alertView.tag];
        [removeView removeFromSuperview];
        [illnessViews removeObject:removeView];

        for (int i = alertView.tag - IllnessTag; i < [illnessViews count]; i++) {
            IllnessView *illness = (IllnessView *)[illnessViews objectAtIndex:i];
            CGRect frame = illness.frame;
            frame.origin.y -= 44.0f;
            [illness setFrame:frame];
            illness.tag -= 1;
            illness.delBtn.tag -= 1;

        }
        NSInteger tag = (self.frame.size.height -  44 * 5) / 44;
        [addBtn setFrame:CGRectMake(572-40+10, 2 + 44 * 4+5+44.0f * (tag-1)-6, 60, 30)];

        if ([delegate respondsToSelector:@selector(updateDetailCell:atIndex:)]) {
            [delegate updateDetailCell:NO atIndex:deleteButton_.tag];
        }
        
        if ([illnessViews count] == 0) {
            [hospitalCountImageView setImage:[UIImage imageNamed:@"apply_button_wrong.png"]];
        }
    }
    }
}

- (void)updateDeleteButton:(NSInteger)newTag {
    deleteButton_.tag = newTag;
}

- (void)dealloc {

    //wang begin

    [hospitalNameView release];
    [hospitalbeginDateView release];
    [hospitalendDateView release];
    [hospitalTotalAmountView release];
    [hospitalSelfAmountView release];
    [hospitalSocietyPayAmountView release];
    [hospitalOtherAmountView release];
    [payment release];
//wang end
    
    NSLog(@"hospital detail dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"aaa" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"uuu" object:nil];

    [illnessViews release];
    [hospitalCountImageView release];
    if (hospital_ != nil) {
        [hospital_ release];
    }
    [super dealloc];
   
}

#pragma mark -

- (void)resignFirst {
    if ([hospitalTotalAmountView isFirst]) {
        [hospitalTotalAmountView resignFirst];
    }
    if ([hospitalSelfAmountView isFirst]) {
        [hospitalSelfAmountView resignFirst];
    }
    if ([hospitalSocietyPayAmountView isFirst]) {
        [hospitalSocietyPayAmountView resignFirst];
    }
    if ([hospitalOtherAmountView isFirst]) {
        [hospitalOtherAmountView resignFirst];
    }
}

- (BOOL)canResignFirstResponder {
    if ([hospitalTotalAmountView isFirst] && [hospitalNameView getField].text.length > 0) {
        return [self validHospitalInfo:[hospitalNameView getField]];
    }else if ([hospitalSelfAmountView isFirst] && [hospitalNameView getField].text.length > 0) {
        return [self validHospitalInfo:[hospitalSelfAmountView getField]];
    }else if ([hospitalSocietyPayAmountView isFirst] && [hospitalNameView getField].text.length > 0) {
        return [self validHospitalInfo:[hospitalSocietyPayAmountView getField]];
    }else if ([hospitalOtherAmountView isFirst] && [hospitalNameView getField].text.length > 0) {
        return [self validHospitalInfo:[hospitalOtherAmountView getField]];
    }
    return YES;
}

extern NSString *accidentDate;
//开始编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    currentFieldTag = textField.tag;
    
    if (textField.tag == Hos_BeginDate || textField.tag == Hos_EndDate) {
        DatePickerViewController *datePickerViewController = [[[DatePickerViewController alloc] init] autorelease];
        if (textField.tag == Hos_BeginDate) {
            UIView *subView = [self viewWithTag:Hos_EndDate];
            if ([subView isKindOfClass:[UITextField class]]) {
                UITextField *endField = (UITextField *)subView;
                if (endField.text.length == 0) {
                    [datePickerViewController setMaxDate:[NSDate date]];
                }else {
                    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
                    formatter.dateFormat = @"yyyy-MM-dd";
                    NSDate *endDate = [NSDate dateWithTimeInterval:8 * 60 * 60 sinceDate:[formatter dateFromString:endField.text]];
                    [datePickerViewController setMaxDate:endDate];
                }
                NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
                formatter.dateFormat = @"yyyy-MM-dd";
                NSDate *accDate = [NSDate dateWithTimeInterval:8 * 60 * 60 sinceDate:[formatter dateFromString:accidentDate]];
                [datePickerViewController setminiDate:accDate];
            }
        }else {//end date
            UIView *subView = [self viewWithTag:Hos_BeginDate];
            if ([subView isKindOfClass:[UITextField class]]) {
                UITextField *beginField = (UITextField *)subView;
                NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
                formatter.dateFormat = @"yyyy-MM-dd";
                if (beginField.text != nil) {
                    NSDate *beginDate = [NSDate dateWithTimeInterval:8 * 60 * 60 sinceDate:[formatter dateFromString:beginField.text]];
                    [datePickerViewController setminiDate:beginDate];
                }else {
                    return NO;
                }
            }   
        }
        datePickerViewController.delegate = self;
            popover_ = [[UIPopoverController alloc] initWithContentViewController:datePickerViewController];
            popover_.delegate = self;
            [popover_ setValue:[NSNumber numberWithInt:1] forKey:@"popoverBackgroundStyle"];
                popover_.contentViewController = datePickerViewController;
        popover_.popoverContentSize = CGSizeMake(320, 220);
        [popover_ presentPopoverFromRect:textField.frame
                                  inView:textField
                permittedArrowDirections:UIPopoverArrowDirectionRight
                                animated:YES];
        return NO;
    }else if (textField.tag == Hos_Name) {
        HospitalSearchViewController *hospitalSearch = [[[HospitalSearchViewController alloc] init] autorelease];
//        hospitalSearch.view.backgroundColor=[UIColor redColor];
        hospitalSearch.delegate = self;
        


            popover_ = [[UIPopoverController alloc] initWithContentViewController:hospitalSearch];
            popover_.delegate = self;
            [popover_ setValue:[NSNumber numberWithInt:1] forKey:@"popoverBackgroundStyle"];
    
        popover_.popoverContentSize = CGSizeMake(320, 500);
        [popover_ presentPopoverFromRect:CGRectMake(textField.frame.origin.x-10, textField.frame.origin.y, textField.frame.size.width, textField.frame.size.height)
                                  inView:self
                permittedArrowDirections:UIPopoverArrowDirectionLeft
                                animated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"123" object:nil];
        return NO;

    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length == 0 || [self validHospitalInfo:textField]) {
        if ([hospitalTotalAmountView isFirst]) {
            [hospitalSelfAmountView becomeFirst];
        }else if ([hospitalSelfAmountView isFirst]) {
            [hospitalSocietyPayAmountView becomeFirst];
        }else if ([hospitalSocietyPayAmountView isFirst]) {
            [hospitalOtherAmountView becomeFirst];
        }else if ([hospitalOtherAmountView isFirst]) {
            [hospitalOtherAmountView resignFirst];
        }
        return YES;
    }
    return NO;

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    HospitalDetailCellView *hospitalView = (HospitalDetailCellView *)textField.superview;
    BOOL ret = NO;
    if (textField.text.length == 0) {
        [hospitalView changeStatus:Detail_Null];
        ret = YES;
    }else {
        ret = [self validHospitalInfo:textField];
        if (ret) {
            [hospitalView changeStatus:Detail_Right];
        }else {
            [hospitalView changeStatus:Detail_Wrong];
        }
    }
    return ret;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    UIView *view = self.superview;
    while (![view isKindOfClass:[UITableView class]]) {
        view = view.superview;
    }
    
    UIScrollView *scroll = (UIScrollView *)view.superview.superview;
    
    [scroll setContentSize:CGSizeMake(1024, 1100)];
    
    CGRect rect = [scroll convertRect:textField.frame fromView:textField.superview];
    if (rect.origin.y > 748 - 416 && scroll.contentOffset.y < rect.origin.y - 332) {
        offset_ = scroll.contentOffset.y;
        [scroll setContentOffset:CGPointMake(scroll.contentOffset.x, scroll.contentOffset.y + rect.origin.y - 748 + 416 + 80) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    UIView *view = self.superview;
    while (![view isKindOfClass:[UITableView class]]) {
        view = view.superview;
    }
    UIScrollView *scroll = (UIScrollView *)view.superview.superview;
    
    [scroll setContentSize:CGSizeMake(1024, 705)];
    
    if (offset_ > 0) {
        [scroll setContentOffset:CGPointMake(scroll.contentOffset.x, offset_) animated:YES];
        offset_ = 0.0f;
    }
}

#pragma mark -

- (void)changeDateWith:(NSString *)dateString {
    UIView *subView = [self viewWithTag:currentFieldTag];
    if ([subView isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)subView;
        textField.text = dateString;
        if (textField.text.length > 0) {
            HospitalDetailCellView *hospitalView = (HospitalDetailCellView *)textField.superview;
            [hospitalView changeStatus:Detail_Right];
        }
        if (textField.tag == Hos_BeginDate) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeAdmissionDate" object:self userInfo:@{@"value":textField.text}];

        }
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    if (popoverController==popover_) {
        [popover_ release];
    }
    
    if (currentFieldTag == Hos_BeginDate || currentFieldTag == Hos_EndDate) {
    UIView *beginView = [self viewWithTag:Hos_BeginDate];
    UIView *endView = [self viewWithTag:Hos_EndDate];
    NSDate *beginDate;
    NSDate *endDate;
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    formatter.dateFormat = @"yyyy-MM-dd";
    if ([beginView isKindOfClass:[UITextField class]]) {
        UITextField *beginField = (UITextField *)beginView;
        if (beginField.text.length == 0) {
            beginDate = nil;
            return;
        }else {
            beginDate = [NSDate dateWithTimeInterval:8 * 60 * 60 sinceDate:[formatter dateFromString:beginField.text]];
         }
    }
    
    if ([endView isKindOfClass:[UITextField class]]) {
        UITextField *endField = (UITextField *)endView;
        if (endField.text.length == 0) {
            endDate = nil;
            return;
        }else {
            endDate = [NSDate dateWithTimeInterval:8 * 60 * 60 sinceDate:[formatter dateFromString:endField.text]];
        }
    }
    
    if ([endDate isEqualToDate:beginDate]) {
        CustomAlertView *alert1 = [[CustomAlertView alloc]initWithTitle:@"提示"
                                                        message:@"入院日期与出院日期一致，请您确认是否正确"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        alert1.tag=5;
        [alert1 show];
        [alert1 release];
    }
    }
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"validTime" object:nil];
}

- (void)updateIllness:(Illness *)illness {
    NSInteger tag = (self.frame.size.height -  44 * 5) / 44;
    
    if ([delegate respondsToSelector:@selector(updateDetailCell:atIndex:)]) {
        [delegate updateDetailCell:YES atIndex:deleteButton_.tag];
    }

    IllnessView *illnessView = [[IllnessView alloc] initWithFrame:CGRectMake(0, 44.0f * (4 + tag)-6, self.frame.size.width, 44)
                                                          illness:illness
                                                        delTarget:self
                                                          viewTag:tag + IllnessTag];
    [self addSubview:illnessView];
    
    [illnessViews addObject:illnessView];
    [illnessView release];
    [addBtn setFrame:CGRectMake(572-40+10, 2 + 44 * 4+5+44.0f * (tag+1)-6, 60, 30)];

    if ([illnessViews count] > 0) {
        [hospitalCountImageView setImage:[UIImage imageNamed:@"apply_button_right.png"]];
    }
//    i++;
//    backImgv.frame=(CGRectMake(0, 0  , 616, 220+44*i));

}

- (void)updateHospital:(Hospital *)hospital {
    if (hospital_ != nil) {
        [hospital_ release];
    }
    hospital_ = [hospital retain];
    [hospitalNameView changeTextFieldText:hospital.name];
    [hospitalNameView changeStatus:Detail_Right];
    [popover_ dismissPopoverAnimated:YES];
    [popover_ release];
}

#pragma mark - 

- (BOOL)validHospitalInfo:(UITextField *)textField {
    if (textField.tag == Hos_InvoiceTotal || textField.tag == Hos_PlanAmount || textField.tag == Hos_OwnAmount  || textField.tag == Hos_OtherAmount) {
        if (textField.text.length > 0) {
            textField.text = [Utils handlePayment:textField.text];
            self.payment = [textField.text substringToIndex:textField.text.length - 2];
            //发票金额为大于0小于1000
            
            if (isyes==YES) {
                if(textField.tag == Hos_InvoiceTotal) {
                    if ([Utils validPayments:self.payment] != nil) {
                        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                                                message:[Utils validPayments:self.payment]
                                                                               delegate:nil
                                                                      cancelButtonTitle:@"确定"
                                                                      otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        return NO;
                    }
                    //其它金额为大于等于0小于1000
                } else {
                    if ([Utils validOtherPayments:self.payment withMod:textField.tag] != nil) {
                        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                                                message:[Utils validOtherPayments:self.payment withMod:textField.tag]
                                                                               delegate:nil
                                                                      cancelButtonTitle:@"确定"
                                                                      otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        return NO;
                    }
                    
                }

            }
            float total = 0.0;
            if ([hospitalSelfAmountView getField].text.length > 2) {
                total += [[[hospitalSelfAmountView getField].text substringToIndex:[hospitalSelfAmountView getField].text.length - 2] floatValue];
            }
            if ([hospitalSocietyPayAmountView getField].text.length > 2) {
                total += [[[hospitalSocietyPayAmountView getField].text substringToIndex:[hospitalSocietyPayAmountView getField].text.length - 2] floatValue];
            }
            if ([hospitalOtherAmountView getField].text.length > 2) {
                total += [[[hospitalOtherAmountView getField].text substringToIndex:[hospitalOtherAmountView getField].text.length - 2] floatValue];
            }
            if ([hospitalTotalAmountView getField].text.length > 0) {
                float  hos_total_amount = [[[hospitalTotalAmountView getField].text substringToIndex:[hospitalTotalAmountView getField].text.length - 2] floatValue];
                if (isyes==YES) {
                    if (total > hos_total_amount) {
                        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                                                message:[NSString stringWithFormat:MSG_MAX_INVOICE_AMOUNT_OTHER_AMOUNT, ACDAtA.HOSPITAL_TOTALCOUNT_LIMITED]
                                                                               delegate:nil
                                                                      cancelButtonTitle:@"确定"
                                                                      otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        return NO;
                    }

                }
                if ([delegate respondsToSelector:@selector(updateTotalAmount:atIndex:)]) {
                    BOOL ret = [delegate updateTotalAmount:[hospitalTotalAmountView getField].text atIndex:deleteButton_.tag];
                    return ret;
                }
            }
        }
    }
    switch (textField.tag) {
        case Hos_Name:
            if ([Utils validString:textField.text] < 0) {
                CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                                message:MSG_HOSPITAL_ERROR
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
                return NO;
            }
            break;
        case Hos_BeginDate:
            if ([Utils validString:textField.text] < 0) {
                CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                                message:MSG_HOSPITAL_IN_DATE_ERROR
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
                return NO;
            }else {
                UIView *subView = [self viewWithTag:Hos_EndDate];
                if ([subView isKindOfClass:[UITextField class]]) {
                    UITextField *endField = (UITextField *)subView;
                    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
                    formatter.dateFormat = @"yyyy-MM-dd";
                    NSDate *beginDate = [NSDate dateWithTimeInterval:8 * 60 * 60 sinceDate:[formatter dateFromString:textField.text]];
                    NSDate *endDate = [NSDate dateWithTimeInterval:8 * 60 * 60 sinceDate:[formatter dateFromString:endField.text]];
                    if ([endDate compare:beginDate] == NSOrderedAscending) {
                        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                                        message:MSG_HOSPITAL_DATE_COMPARE_ERROR
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        return NO;
                    }
                }
            }
            break;
        case Hos_EndDate:
            if ([Utils validString:textField.text] < 0) {
                CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                                message:MSG_HOSPITAL_OUT_DATE_ERROR
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                [alert release];
                return NO;
            }else {
                UIView *subView = [self viewWithTag:Hos_BeginDate];
                if ([subView isKindOfClass:[UITextField class]]) {
                    UITextField *beginField = (UITextField *)subView;
                    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
                    formatter.dateFormat = @"yyyy-MM-dd";
                    NSDate *beginDate = [NSDate dateWithTimeInterval:8 * 60 * 60 sinceDate:[formatter dateFromString:beginField.text]];
                    NSLog(@"开始时间：%@",beginDate);
                    NSDate *endDate = [NSDate dateWithTimeInterval:8 * 60 * 60 sinceDate:[formatter dateFromString:textField.text]];
                    NSLog(@"结束时间：%@",endDate);
                    if ([endDate compare:beginDate] == NSOrderedAscending) {
                        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                                        message:MSG_HOSPITAL_DATE_COMPARE_ERROR
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                        [alert show];
                        [alert release];
                        return NO;
                    }
                }
            }
            break;
        default:
            break;
    }
    return YES;
}

- (BOOL)validHospitalInfo {
    
    
    if (![self validHospitalInfo:[hospitalNameView getField]] || [hospitalNameView getField].text.length == 0) {
        return NO;
        
    }else if (![self validHospitalInfo:[hospitalbeginDateView getField]] || [hospitalbeginDateView getField].text.length == 0) {
        return NO;
    } else if (![self validHospitalInfo:[hospitalendDateView getField]] || [hospitalendDateView getField].text.length == 0) {
        return  NO;
    }else if (![self validHospitalInfo:[hospitalTotalAmountView getField]] || [hospitalTotalAmountView getField].text.length == 0) {
        
        if ([hospitalTotalAmountView getField].text.length == 0) {
            CustomAlertView *alter=[[CustomAlertView alloc]initWithTitle:@"提示" message:MSG_INVOICE_AMOUNT_NULL delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alter show];
            [alter release];
            return NO;
        }
        return   NO;
        
    }else if (![self validHospitalInfo:[hospitalSelfAmountView getField]] || [hospitalSelfAmountView getField].text.length == 0) {
        
        if ([hospitalSelfAmountView getField].text.length==0) {
            CustomAlertView *alter=[[CustomAlertView alloc]initWithTitle:@"提示" message:MSG_SELF_AMOUNT_NULL delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alter show];
            [alter release];
            return NO;

            
        }
        return   NO;
    }else if (![self validHospitalInfo:[hospitalSocietyPayAmountView getField]] || [hospitalSocietyPayAmountView getField].text.length == 0) {
        
        if ([hospitalSocietyPayAmountView getField].text.length==0) {
            CustomAlertView *alter=[[CustomAlertView alloc]initWithTitle:@"提示" message:MSG_SOCIETY_AMOUNT_NULL delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alter show];
            [alter release];
            return NO;

           
        }
         return   NO;
    }else  if (![self validHospitalInfo:[hospitalOtherAmountView getField]] || [hospitalOtherAmountView getField].text.length == 0) {
        
        if ([hospitalOtherAmountView getField].text.length==0) {
            CustomAlertView *alter=[[CustomAlertView alloc]initWithTitle:@"提示" message:MSG_OTHER_AMOUNT_NULL delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alter show];
            [alter release];
            return NO;

        }
        return   NO;
    }else  if ([illnessViews count] == 0) {
        //liucong begin
        if (!TestModeEx) {        
            CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"提示"
                                                        message:MSG_HOSPITAL_ACCIDENT_ERROR
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
            [alert show];
            [alert release];
            return NO;
	}
        //liucong end
    }


    
    
    
//    BOOL ret = YES;
//    for (int i = Hos_Name; i < Hos_Diagnose; i++) {
//        
//        
//        
//        switch (i) {
//            case Hos_Name:
//                if (![self validHospitalInfo:[hospitalNameView getField]] || [hospitalNameView getField].text.length == 0) {
//                    ret = NO;
//                }
//                break;
//            case Hos_BeginDate:
//                
//                if (![self validHospitalInfo:[hospitalbeginDateView getField]] || [hospitalbeginDateView getField].text.length == 0) {
//                    ret = NO;
//                }
//                
//                break;
//            case Hos_EndDate:
//                
//                if (![self validHospitalInfo:[hospitalendDateView getField]] || [hospitalendDateView getField].text.length == 0) {
//                    ret = NO;
//                }
//                break;
//            case Hos_InvoiceTotal:
//                if (![self validHospitalInfo:[hospitalTotalAmountView getField]] || [hospitalTotalAmountView getField].text.length == 0) {
//                    ret = NO;
//                    if ([hospitalTotalAmountView getField].text.length == 0) {
//                        CustomAlertView *alter=[[CustomAlertView alloc]initWithTitle:@"提示" message:MSG_INVOICE_AMOUNT_NULL delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                        [alter show];
//                        [alter release];
//                    }
//                }
//                break;
//            case Hos_OwnAmount:
//                if (![self validHospitalInfo:[hospitalSelfAmountView getField]] || [hospitalSelfAmountView getField].text.length == 0) {
//                    ret = NO;
//                    if ([hospitalSelfAmountView getField].text.length==0) {
//                        CustomAlertView *alter=[[CustomAlertView alloc]initWithTitle:@"提示" message:MSG_SELF_AMOUNT_NULL delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                        [alter show];
//                        [alter release];
//                    }
//                }
//                break;
//            case Hos_PlanAmount:
//                if (![self validHospitalInfo:[hospitalSocietyPayAmountView getField]] || [hospitalSocietyPayAmountView getField].text.length == 0) {
//                    ret = NO;
//                    if ([hospitalSocietyPayAmountView getField].text.length==0) {
//                        CustomAlertView *alter=[[CustomAlertView alloc]initWithTitle:@"提示" message:MSG_SOCIETY_AMOUNT_NULL delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                        [alter show];
//                        [alter release];
//                    }
//                }
//                break;
//            case Hos_OtherAmount:
//                if (![self validHospitalInfo:[hospitalOtherAmountView getField]] || [hospitalOtherAmountView getField].text.length == 0) {
//                    ret = NO;
//                    if ([hospitalOtherAmountView getField].text.length==0) {
//                        CustomAlertView *alter=[[CustomAlertView alloc]initWithTitle:@"提示" message:MSG_OTHER_AMOUNT_NULL delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                        [alter show];
//                        [alter release];
//                    }
//                }
//                break;
//            default:
//                break;
//        }
//    }
    return YES;
}

- (HospitalInfo *)getHospitalInfo {
    HospitalInfo *info = [[HospitalInfo alloc] init];
    info.identity = deleteButton_.tag;
    NSMutableArray *diagnoses = [NSMutableArray array];
    for (int i = 0; i < [illnessViews count]; i++) {
        IllnessView *illnessView = [illnessViews objectAtIndex:i];
        [diagnoses addObject:illnessView.illness];
    }
    info.hos_diagnoses = diagnoses;
    for (int i = Hos_Name; i < Hos_Diagnose; i++) {
        switch (i) {
            case Hos_Name:
                info.hospital = hospital_;
                break;
            case Hos_BeginDate:
                info.hos_beginDate = [hospitalbeginDateView getField].text;
                break;
            case Hos_EndDate:
                info.hos_endDate = [hospitalendDateView getField].text;
                break;
            case Hos_InvoiceTotal:
                info.hos_invoiceTotal = [hospitalTotalAmountView getField].text;
                break;
            case Hos_OwnAmount:
                info.hos_ownAmount = [hospitalSelfAmountView getField].text;
                break;
            case Hos_PlanAmount:
                info.hos_planAmount = [hospitalSocietyPayAmountView getField].text;
                break;            
            case Hos_OtherAmount:
                info.hos_otherAmount = [hospitalOtherAmountView getField].text;
                break;
            default:
                break;
        }
    }
    return [info autorelease];
}



@end
