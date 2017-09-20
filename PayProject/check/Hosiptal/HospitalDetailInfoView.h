//
//  HospitalDetailInfoView.h
//  TPL-AUTO-CLAIM-iPad
//
//  Created by concise on 12-11-9.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HospitalInfo.h"
#import "DatePickerViewController.h"
#import "DiagnoseViewController.h"
#import "HospitalSearchViewController.h"

#import "Hospital.h"
#import "HospitalInfo.h"

typedef enum {
    Hos_Name = 0,
    Hos_BeginDate,
    Hos_EndDate,
    Hos_InvoiceTotal,
    Hos_OwnAmount,
    Hos_PlanAmount,
    Hos_OtherAmount,
    Hos_Diagnose
} HospitalFieldTag;


@class HospitalDetailInfoView;
@protocol HospitalDetailInfoDelegate <NSObject>

- (void)updateDetailCell:(BOOL)isAdd atIndex:(NSInteger)index;
- (BOOL)updateTotalAmount:(NSString *)total atIndex:(NSInteger)index;

@end

@class HospitalDetailCellView;

@interface HospitalDetailInfoView : UIView <UITextFieldDelegate, UIPopoverControllerDelegate, DatePickerViewControllerDelagate, DiagnoseDelegate, HospitalSearchDelegate, UIAlertViewDelegate> {
    
    id<HospitalDetailInfoDelegate>  delegate;
    
    UIButton                        *deleteButton_;
    HospitalFieldTag                currentFieldTag;
        
    UIPopoverController             *popover_;
    
    NSMutableArray                  *illnessViews;
    
    Hospital                        *hospital_;
    
    HospitalDetailCellView          *hospitalNameView;//入住医院
    HospitalDetailCellView          *hospitalbeginDateView;//入院日期
    HospitalDetailCellView          *hospitalendDateView;//出院日期
    HospitalDetailCellView          *hospitalTotalAmountView;//发票总金额
    HospitalDetailCellView          *hospitalSelfAmountView;//
    HospitalDetailCellView          *hospitalSocietyPayAmountView;
    HospitalDetailCellView          *hospitalOtherAmountView;
    
    UIImageView                     *hospitalCountImageView;
    UIButton *addBtn;
    BOOL isyes;
}


@property (nonatomic, assign) id<HospitalDetailInfoDelegate>  delegate;
@property (nonatomic,assign)int inter;
@property (nonatomic,retain)NSString *payment;
//@property (nonatomic, retain) Hospital                        *hospital_;

- (id)initWithFrame:(CGRect)frame target:(id)target_ inRow:(NSInteger)row diagnosePopover:(UIPopoverController *)popover;
- (void)updateDeleteButton:(NSInteger)newTag;
- (HospitalInfo *)getHospitalInfo;

- (BOOL)validHospitalInfo;
- (void)resignFirst;
@end
