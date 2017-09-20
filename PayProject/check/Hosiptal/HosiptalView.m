//
//  HosiptalView.m
//  PayProject
//
//  Created by Taiping002 on 2017/9/12.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "HosiptalView.h"

@implementation HosiptalView
{

    NSInteger Count;
    CGRect rect;
    UIImageView* imagev;
    UILabel         *totallabel_;
    UITableView* tableview;

}

- (id)initWithFrame:(CGRect)frame itemCount:(NSInteger)hospitalCount

{
    
    if (self=[super initWithFrame:frame]) {
        Count=hospitalCount;
        rect=  frame;
        totalsArray = [[NSMutableArray alloc] initWithObjects:@"0.00", @"0.00", @"0.00", @"0.00", @"0.00", @"0.00", nil];
        hospitalInfoViews = [[NSMutableArray alloc] initWithCapacity:10];

        [self initUI];
    }
    
    return self;
    
}
-(void)initUI
{

    //背景
    imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, 12, self.frame.size.width, self.frame.size.height)];
    imagev.userInteractionEnabled=YES;
    imagev.image=[UIImage imageNamed:@"report_youbeijin.png"];
    [self addSubview:imagev];
    
    
    //tableView
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(20, 20, rect.size.width - 40, rect.size.height - 40) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundView = nil;
    [self addSubview:tableview];
    [self loaddata];

}
-(void)loaddata
{
    for (int i = 0; i < Count; i++) {
        
        
//        
//        if (TestModeEx) {
        
//            detail = [[HospitalDetailInfoView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 40, 44.0f * 7) target:self inRow:[hospitalInfoViews count] diagnosePopover:nil];
//            
////        } else {
//        
////            detail = [[HospitalDetailInfoView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 40, 44.0f * 6) target:self inRow:[hospitalInfoViews count] diagnosePopover:nil];
////        }
//        detail.delegate = self;
//        detail.tag = [hospitalInfoViews count];
//        [hospitalInfoViews addObject:detail];
//    
//        [illnessCountArray addObject:[NSNumber numberWithInteger:0]];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"aaa" object:illnessCountArray];
//        
    }

}
#pragma mark - UITableView Methods
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [hospitalInfoViews count] + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == [hospitalInfoViews count]) {
//        return 54;
//    }
//    NSInteger illnessCount = [[illnessCountArray objectAtIndex:indexPath.row] integerValue];
//    
//        return 44.0f * (6 + illnessCount);
    return 54;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50)] ;
    headerView.backgroundColor = [UIColor colorWithRed:225/255.0 green:241/255.0 blue:255/255.0 alpha:1];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 100, 35)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"住院信息";
    [headerView addSubview:titleLabel];
  
    
    UIImageView *imgv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width-45, 1)];
    imgv.image=[UIImage imageNamed:@"apply_line1.png"];
    [headerView addSubview:imgv];
   
    totallabel_ = [[UILabel alloc] initWithFrame:CGRectMake(580 * 4 / 5, 0, 660 / 5, 35)];
    totallabel_.backgroundColor = [UIColor clearColor];
    totallabel_.textAlignment = NSTextAlignmentRight;
    totallabel_.font = [UIFont boldSystemFontOfSize:18];
    totallabel_.textColor = [UIColor redColor];
    float total = 0.00f;
    for (int i = 0; i < [totalsArray count]; i++) {
        total += [[totalsArray objectAtIndex:i] floatValue];
    }
    totallabel_.text = [NSString stringWithFormat:@"总额:%.2f元", total];
    [headerView addSubview:totallabel_];
    return headerView;
}

@end
