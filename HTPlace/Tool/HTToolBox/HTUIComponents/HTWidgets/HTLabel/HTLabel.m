//
//  HTLabel.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/6/17.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTLabel.h"

@interface HTLabel()
@end



@implementation HTLabel

// 下面三个方法用来初始化edgeInsets
- (instancetype)initWithEdges:(UIEdgeInsets)edges font:(UIFont *)font textColor:(UIColor *)textColor backGroundColor:(UIColor *)backGroundColor text:(NSString *)text
{
    if(self = [super init])
    {
        self.edgeInsets = edges;
        self.font = font;
        self.textColor = textColor;
        self.backgroundColor = backGroundColor;
        self.textAlignment = NSTextAlignmentCenter;
        self.text = text;
        @weakify(self);
        [RACObserve(self, text) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            // 如果有边距,那么改变尺寸
            if (self.edgeInsets.top || self.edgeInsets.left || self.edgeInsets.bottom || self.edgeInsets.right) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.text.length) {
                        CGSize contentSize = self.intrinsicContentSize;
                        contentSize = CGSizeMake(contentSize.width + self.edgeInsets.left + self.edgeInsets.right, contentSize.height + self.edgeInsets.top + self.edgeInsets.bottom);

                        
                        
                        [self mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.size.mas_equalTo(contentSize);
                        }];
                    }else {
                        self.size = CGSizeMake(0, 0);
                    }

                   
                });
            }
            
             [self changeSize];
        }];
    }
    return self;
}


- (void)changeSize{
    
}
@end
