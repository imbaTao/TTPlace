//
//  ShowExampleViewController.h
//  HZYToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_OPTIONS(NSInteger, DemoType) {
    DEMO_UIView = 0,
    DEMO_Button,
    DEMO_WifiTransfer,
    DEMO_Share,
    DEMO_WaterFall
};
@interface ShowExampleViewController : BaseViewController
/** type */
@property(nonatomic,assign)DemoType type;
- (instancetype)initWithType:(DemoType)type;
@end
