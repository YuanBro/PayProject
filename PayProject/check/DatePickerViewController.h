//
//  DatePickerViewController.h
//  TPL-AUTO-CLAIM-iPad
//
//  Created by concise on 12-11-8.
//  Copyright (c) 2012年 cisetech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewControllerDelagate <NSObject>

- (void)changeDateWith:(NSString *)dateString;

@end

@interface DatePickerViewController : UIViewController {
}

@property (nonatomic, assign) id<DatePickerViewControllerDelagate>    delegate;

- (void)setMaxDate:(NSDate *)maxDate;
- (void)setminiDate:(NSDate *)miniDate;

@end
