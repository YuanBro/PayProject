//
//  ApplyTableViewCell.m
//  PayProject
//
//  Created by Taiping002 on 2017/4/14.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "ApplyTableViewCell.h"
#import "CellView.h"
@interface ApplyTableViewCell ()
@property (nonatomic,weak) CellView *settingView;
@end
@implementation ApplyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupFirst];
    }
    return self;
}
//添加子视图
-(void)setupFirst
{
    CellView *setting=[[CellView alloc]initWithFrame:self.bounds];
    
    [self.contentView addSubview:setting];
    self.settingView=setting;
}


@end
