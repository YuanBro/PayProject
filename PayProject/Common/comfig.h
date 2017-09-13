//
//  comfig.h
//  PayProject
//
//  Created by yuan on 2017/1/11.
//  Copyright © 2017年 yuan. All rights reserved.
//

#ifndef comfig_h
#define comfig_h

#define ACDATA  [Acdata sharedInstance]
#define Width  [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#define PersonIdType            @"身份证,军人证,护照,出生证,异常身份证,回乡证,士兵证,警官证,户口簿,其它"  //id number = index + 1
#define ID_TYPE_TITLES          @"身份证", @"军人证", @"护照", @"出生证", @"异常身份证", @"回乡证", @"士兵证", @"警官证",@"户口簿", @"其它", nil
#define PolicyListMenuTitle     @"保单号,投保人姓名,被保人姓名,是否暂停"
#define PolicyDetailTitle       @"险种序列号,险种代码,险种名称,险种当前责任状态,保险金额,险种生效日期,下次缴费日期"

#define MOVEACCEPTBACKGROUND [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:1]
#define IndexMenuListTitles @"@"免审核案件审理,状态查询,说明,关于""

#define is_iOS8  (([[[UIDevice currentDevice ] systemVersion] floatValue] >= 8.0) ? YES: NO)
#endif /* comfig_h */
