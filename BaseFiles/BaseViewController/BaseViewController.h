//
//  BaseViewController.h
//  HZYToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController



/** backButton */
@property(nonatomic,strong)UIButton *backButton;


- (instancetype)initWithHaveNavi:(BOOL)haveNavibar;
@end
