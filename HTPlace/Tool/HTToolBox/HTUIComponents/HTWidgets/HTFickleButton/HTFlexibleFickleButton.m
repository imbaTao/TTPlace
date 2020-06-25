//
//  HTFlexibleFickleButton.m
//  Jihuigou-Native
//
//  Created by hong on 2020/5/9.
//  Copyright © 2020 xiongbenwan. All rights reserved.
//

#import "HTFlexibleFickleButton.h"

@implementation HTFlexibleFickleButton

// 子类复写
// 子类复写
- (void)relayoutWithPositon:(NSInteger)position {
    
    // 间距
    self.interval = 4;
    
    // 抗压缩
    //    [self.content setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    //    self.content.backgroundColor = [UIColor blueColor];
    
    
    
    
    //        [self.likeButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    // 抗拉伸
    [self.content setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    // 抗压缩
    [self.icon setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    // 抗拉伸
    [self.icon setContentHuggingPriority:UILayoutPriorityDragThatCanResizeScene forAxis:UILayoutConstraintAxisHorizontal];
    
    
    switch (position) {
        case 0:{
            // layout
            [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.centerY.equalTo(self);
                make.right.equalTo(self.content.mas_left).offset(-self.interval);
            }];
            
            [self.content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.icon.mas_right).offset(self.interval);
                make.centerY.equalTo(self);
                make.right.offset(0);
            }];
        }break;
        case 1:{
            [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_lessThanOrEqualTo(0);
                make.centerY.equalTo(self);
            }];
            // layout
            [self.content mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(0);
                make.centerY.equalTo(self);
                make.right.equalTo(self.icon.mas_left).offset(-self.interval);
            }];
        }break;
        default:break;
    }
}





- (void)changeNewTitle:(NSString *)newValue {
    self.content.text = newValue;
}

@end
