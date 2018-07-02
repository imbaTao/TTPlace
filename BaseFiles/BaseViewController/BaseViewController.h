//
//  BaseViewController.h
//  HZYToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"
#import "BaseCollectionview.h"
#import "HZYTabbarController.h"
@interface BaseViewController : UIViewController <BaseTableViewCellDelegate>

- (void)hiddenLeftBtn;
- (void)layoutPageViews;
@end
