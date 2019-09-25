//
//  BaseViewController.h
//  HTToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"
#import "BaseCollectionview.h"
@interface BaseViewController : UIViewController <BaseTableViewCellDelegate>

- (void)hiddenLeftBtn;
- (void)layoutPageViews;
@end
