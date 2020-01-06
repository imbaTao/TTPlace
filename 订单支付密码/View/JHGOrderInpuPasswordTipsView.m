//
//  JHGOrderInpuPasswordTipsView.m
//  HTPlace
//
//  Created by hong on 2019/12/3.
//  Copyright © 2019 HZY. All rights reserved.
//

#import "JHGOrderInpuPasswordTipsView.h"

@interface JHGOrderInpuPasswordTipsView()


/**
 inputTitle
 */
@property(nonatomic, readwrite, strong)UILabel *inputTitle;

/**
 tips
 */
@property(nonatomic, readwrite, strong)UILabel *tips;

@end

@implementation JHGOrderInpuPasswordTipsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self settingCornerRadius:5];
        
        // 创建
        self.closeButton = [UIButton iconName:@"JHGOrderself.1"];
        self.inputTitle = [UILabel font:[UIFont boldFontSize:16] color:rgba(51, 51, 51, 1) textAlignment:NSTextAlignmentCenter placeholder:@"请输入支付密码"];
        self.tips = [UILabel size:13 color:rgba(51, 51, 51, 1) textAlignment:NSTextAlignmentCenter placeholder:@"您还未设置支付密码，请先去设置"];
        self.settingButton = [UIButton buttonWithTitle:@"设置支付密码" titleColor:rgba(255, 255, 255, 1) font:[UIFont mediumFontSize:16] backGroundColor:rgba(222, 49, 33, 1) cornerRadius:5];
        
        
        
        // layout
        @weakify(self);
        [self setupLayout:^{
            @strongify(self);
            [self.closeButton top:10 right:10];
            [self.inputTitle top:33 sideEdge:0];
            [self.tips left:0 right:0 baseLineTop:29.5 referView:self.inputTitle];
            [self.settingButton bottom:20 left:20 right:20 height:40];
        }];
    }
    return self;
}


@end
