//
//  HTDiscoverViewController.m
//  HTToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HT. All rights reserved.
//

#import "DiscoverViewController.h"
@interface DiscoverViewController ()
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)creatProperty {
    NSArray *propertyArray = @[
                               @"    ID    ",
                               @"    MarketingID    ",
                               @"    ProductID    ",
                               @"    ImgPath    ",
                               @"    ProductName    ",
                               @"    Price    ",
                               @"    ProdItemPrice    ",
                               @"    ShowStatus    ",
                               @"    RequireUserNum    ",
                               @"    CreateGroupNum    ",
                               @"    Tip_Stock    ",
                               @"    Tip_Time    ",
                               @"    StartTime    ",
                               @"    EndTime    ",
                               ];
    
    NSArray *discributionArray = @[
                                   @"    拼团活动ID    ",
                                   @"    促销活动ID    ",
                                   @"    商品ID    ",
                                   @"    商品图片    ",
                                   @"    商品名称    ",
                                   @"    拼团价    ",
                                   @"    商品原价    ",
                                   @"    拼团活动的状态    ",
                                   @"    成团人数（几人团）    ",
                                   @"    已开团数量    ",
                                   @"    提醒库存    ",
                                   @"    提醒时间（分钟）    ",
                                   @"    开始时间    ",
                                   @"    结束时间    ",
                                   ];
    
//    
//    [HomeViewController propertyWithArray:propertyArray b:discributionArray];
}

+ (void)propertyWithArray:(NSArray *)a  b:(NSArray *)b
{
    NSString *str = @"";
    if (a.count != b.count) {
        NSLog(@"数量不等");
    }
    
    for (int i = 0; i < a.count; i++) {
        NSString *prorperty = a[i];
        NSString *tips =  b[i];
        tips = [tips stringByReplacingOccurrencesOfString:@" " withString:@""];
        prorperty =  [prorperty stringByReplacingOccurrencesOfString:@" " withString:@""];
        str =  [NSString stringWithFormat:@"%@\n/** \n%@\n */\n@property(nonatomic, readwrite, copy)NSString *%@;\n",str,tips,prorperty];
        
    }
    
    NSLog(@"%@",str);
}

@end
