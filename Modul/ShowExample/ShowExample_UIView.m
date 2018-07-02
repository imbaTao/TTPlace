//
//  ShowExample_UIView.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "ShowExample_UIView.h"
@implementation ShowExample_UIView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.normalDemoView = [[UIView alloc] init];
    self.normalDemoView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.normalDemoView];
    [self.normalDemoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200 , 200));
    }];
    
    // 圆角
    self.normalDemoView.layer.cornerRadius = 8.0;
    self.normalDemoView.layer.masksToBounds = true;
    
    // ios 11出来的指定倒哪个圆角
    if(@available(iOS 11.0, *)) {
      self.normalDemoView.layer.maskedCorners =   kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
    }
    
    
//    // 阴影(倒圆角后无法显示)
//    self.normalDemoView.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.normalDemoView.layer.shadowRadius = 4.0f;
//
//    // 纵轴Y轴偏4个pt
//    self.normalDemoView.layer.shadowOffset = CGSizeMake(0, 4);
    
}


@end
