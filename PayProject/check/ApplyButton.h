//
//  ApplyButton.h
//  PayProject
//
//  Created by yuan on 2017/1/24.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyButton : UIButton

@property(nonatomic,strong)UILabel* infolabel;

-(id)initWithFrame:(CGRect)frame;


-(void)changetext:(NSString* )test tag:(int)i;




@end
