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
- (void)relayout {
    // 间距
    self.interval = 4;
    
    // 抗压缩
//    [self.content setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
//    self.content.backgroundColor = [UIColor blueColor];
    // 抗拉伸
    [self.content setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
   // 抗压缩
    [self.icon setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
       
   // 抗拉伸
    [self.icon setContentHuggingPriority:UILayoutPriorityDragThatCanResizeScene forAxis:UILayoutConstraintAxisHorizontal];

      // layout
      [self.content mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.left.offset(0);
          make.centerY.equalTo(self);
          make.right.equalTo(self.icon.mas_left).offset(-self.interval);
      }];
      
      [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.right.mas_lessThanOrEqualTo(0);
          make.centerY.equalTo(self);
      }];
}

- (void)changeNewTitle:(NSString *)newValue {
    self.content.text = newValue;
}

@end
