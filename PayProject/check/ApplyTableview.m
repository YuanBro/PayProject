//
//  ApplyTableview.m
//  PayProject
//
//  Created by Taiping002 on 2017/4/14.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "ApplyTableview.h"
#import "SectionView.h"
#import "CheckModel.h"
#import "ApplyBigView.h"
@interface ApplyTableview() <UITableViewDelegate, UITableViewDataSource>

@end
@implementation ApplyTableview
{

    NSMutableArray *datas;
    NSMutableArray *modelData;
    NSMutableArray *needLoadArr;// 保存旋转状态(展开/折叠)
    NSIndexPath *_indexPath; // 保存当前选中的单元格
    BOOL scrollToToping;
    SectionView*view;
    UIImageView* imgview;
   

}
@synthesize array;
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        datas = [[NSMutableArray alloc] init];
       needLoadArr = [[NSMutableArray alloc] init];
        modelData = [[NSMutableArray alloc] init];
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"kalanBackground.png"]];

        [self loadData];
        [self reloadData];
    }
    return self;
}
-(void)loadData
{
    // 读取本地plist文件的内容
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"plist"];
    datas=[NSMutableArray arrayWithContentsOfFile:filePath];
  
    NSLog(@"%@",datas);
    for (NSDictionary*dict in datas) {
        CheckModel* model=[CheckModel new];
        model.PersonNum=dict[@"PersonNum"];
        model.ApplyName=dict[@"ApplyName"];
        model.BenifitName=dict[@"BenifitName"];
        model.Status=dict[@"Status"];
        [modelData addObject:model];
        
        if (needLoadArr == nil) {
                            needLoadArr = [[NSMutableArray alloc]init];
                        }
                        [needLoadArr addObject:@NO];
    }
    CheckModel* dic=[CheckModel new];
    dic.PersonNum=@"保单号";
    dic.ApplyName=@"投保人姓名";
    dic.BenifitName=@"被保人姓名";
    dic.Status=[NSNumber numberWithInteger:2];
    array=[NSMutableArray array];
    [array addObject:dic];
    for (CheckModel* modell in modelData) {
        [array addObject:modell];
    }
    NSLog(@"数量%lu",(unsigned long)array.count);
//    // 回到主线程更新界面
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

view=[[SectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 50) and:section CheckModel:array[section] ];
   
    [view addTarget:self action:@selector(comfirm:) forControlEvents:UIControlEventTouchUpInside];
   
    if (section>0) {
        view.tag=section;
        imgview=[[UIImageView alloc]initWithFrame:CGRectMake(2, 8, 29, 29)];
        imgview.image=[UIImage imageNamed:@"report_jiantou.png"];
        CGFloat rota;
        if ([needLoadArr[section-1] boolValue] == NO) {
            rota = 0;
        } else {
            rota = M_PI_2; //π/2
        }
        imgview.transform = CGAffineTransformMakeRotation(rota);//箭头偏移π/2
        [view addSubview:imgview];
    }
   
    return view;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 50;
}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//
// 
//
//
//}

-(void)comfirm:(SectionView*)sender
{

    if ([needLoadArr[sender.tag-1] boolValue] == NO) {
        [needLoadArr replaceObjectAtIndex:sender.tag-1 withObject:@YES];
    } else {
        [needLoadArr replaceObjectAtIndex:sender.tag-1 withObject:@NO];
    }
    [self reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%ld",(long)view.tag);
    
}

@end
