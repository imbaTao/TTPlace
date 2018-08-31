//
//  HZYBubbleVC.h
//  HZYToolBox
//
//  Created by hong  on 2018/8/28.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "BaseViewController.h"
//
//  HZYBubbleVC.h
//  TestApp
//
//  Created by hong  on 2018/8/3.
//  Copyright © 2018年 洪正烨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZYBubbleHeaderView.h"
@protocol ActivityBubbleDelegate <NSObject>
- (void)bubbleCellSelected:(NSInteger)row;
@end


@interface HZYBubbleVC : UIViewController

/** 功能列表 */
@property(nonatomic,strong)UITableView *functionTableView;

/** delegate */
@property(nonatomic,weak)id <ActivityBubbleDelegate> delegate;

/** haveHeader */
@property(nonatomic,assign)BOOL haveHeader;

/** appointView */
@property(nonatomic,weak)id appointView;

/** headerView */
@property(nonatomic,strong)HZYBubbleHeaderView *headerView;


- (instancetype)initWithTitleArr:(NSArray *)titleArr picNameArr:(NSArray *)picNameArr appointView:(id)appointView width:(CGFloat)width haveHeader:(BOOL)haveHeader;

- (void)showBubbleWithVC:(UIViewController *)vc;
@end
