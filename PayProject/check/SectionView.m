//
//  SectionView.m
//  PayProject
//
//  Created by Taiping002 on 2017/4/14.
//  Copyright © 2017年 yuan. All rights reserved.
//

#import "SectionView.h"

#define SW         self.frame.size.width
#define SH         self.frame.size.height


@implementation SectionView
{

    BOOL sure;
}
-(id)initWithFrame:(CGRect)frame and:(NSInteger)Section  CheckModel:(CheckModel*)model  ;

{

    if (self =[super initWithFrame:frame]) {
       
        _Section=Section;

       _model=model;

        
        [self addsublabel];
        
    }
    
    
    return self;

}
-(void)addsublabel
{
   CGFloat w=(SW-3)/6;
    if (self.Section==0) {

    for (int i=0; i<4; i++) {
        UILabel* label=[[UILabel alloc]init];
        label.textColor=[UIColor whiteColor];
        label.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"kalan_case.png"]];
        label.font=[UIFont systemFontOfSize:18];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        switch (i) {
            case 0:
            {
                label.frame=CGRectMake(0, 0, 2*w, SH);
                label.text=self.model.PersonNum;
            }
                break;
            case 1:
            {
                label.frame=CGRectMake(2*w+1, 0,w, SH);
                label.text=self.model.ApplyName;
            }
                break;
            case 2:
            {
                label.frame=CGRectMake(2*w+1+w+1, 0, w-1, SH);
                label.text=self.model.BenifitName;
            }
                break;
            case 3:
            {
                label.frame=CGRectMake(2*w+1+w+1+w+1, 0, 2*w, SH);
                label.text=@"是否暂停";
            }
                break;
                
            default:
                break;
        }
        
        [self addSubview:label];
        
    }
    }
    else
    {
    
        for (int i=0; i<4; i++) {
            UILabel* label=[[UILabel alloc]init];
            label.textColor=[UIColor whiteColor];
            label.backgroundColor=[UIColor clearColor];
            label.font=[UIFont systemFontOfSize:18];
            label.textAlignment=NSTextAlignmentCenter;
            label.textColor=[UIColor colorWithRed:110/255.0 green:36/255.0 blue:0/255.0 alpha:1];
            UIView* line=[UIView new];
            line.backgroundColor=MOVEACCEPTBACKGROUND;
            switch (i) {
                case 0:
                {
                    label.frame=CGRectMake(0, 0, 2*w, SH);
                    line.frame=CGRectMake(2*w, 0, 1, SH);
                    
                    label.text=self.model.PersonNum;
                }
                    break;
                case 1:
                {
                    label.frame=CGRectMake(2*w+1, 0,w, SH);
                    label.text=self.model.ApplyName;
                     line.frame=CGRectMake(2*w+w+1, 0, 1, SH);
                }
                    break;
                case 2:
                {
                    label.frame=CGRectMake(2*w+1+w+1, 0, w-1, SH);
                    label.text=self.model.BenifitName;
                       line.frame=CGRectMake(2*w+w+1+w+1, 0, 1, SH);
                }
                    break;
                case 3:
                {
                    label.frame=CGRectMake(2*w+1+w+1+w+1, 0, 2*w, SH);
                    switch (self.model.Status.intValue) {
                        case 0:
                             label.text=@"否";
                            break;
                        case 1:
                            label.text=@"是";
                            break;
                            
                        default:
                            break;
                    }
                  
                    
                }
                    break;
                    
                default:
                    break;
            }
//            self. imgView=[UIImageView new];
//            [ self. imgView setFrame:CGRectMake(2, 8, 29, 29)];
//            self. imgView1=[UIImageView new];
//            [ self. imgView1 setFrame:CGRectMake(2, 8, 29, 29)];
            // self. imgView.tag = self.Section;
            
            //self.imgView1.hidden=YES;
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(10, 49, 990-10, 0.5)];
            view.backgroundColor=[UIColor colorWithRed:173/255.0 green:207/255.0 blue:237/255.0 alpha:1];
            [self addSubview:view];

            [self addSubview:line];
            [self addSubview:label];
            
        }

    
    
    }
  

}
//- (void)setStatusByImage:(BOOL)isExtend {
////    UIImageView *imgView = (UIImageView *)[self viewWithTag:self.Section];
////    NSLog(@"%ld",(long)self.Section);
////    //    [img removeFromSuperview];
////    //    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 41, 41)];
////    //    imgView.tag = -999;
////    //    [self addSubview:imgView];
////    //    [imgView release];
////    if (isExtend) {
////      self.imgView.image = [UIImage imageNamed:@"report_jiantou1.png"];
////        //        NSLog(@"img apply_button02");
////    }else {
////       self.imgView.image = [UIImage imageNamed:@"report_jiantou.png"];
////        //        NSLog(@"img apply_button01");
////    }
//    if (isExtend) {
//        self.imgView.hidden=YES;
//        self.imgView1.hidden=NO;
//    }
//    else
//    {
//    
//        NSLog(@"kjabfka");
//    }
//
//}
-(void)layoutSubviews
{

        [super layoutSubviews];

}
@end
