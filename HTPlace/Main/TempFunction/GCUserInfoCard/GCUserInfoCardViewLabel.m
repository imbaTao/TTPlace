//
//  GCUserInfoCardViewLabel.m
//  HTPlace
//
//  Created by Mr.hong on 2020/9/14.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "GCUserInfoCardViewLabel.h"

@implementation GCUserInfoCardViewLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.mainLabel = [UILabel mediumFontWithSize:15 color:rgba(51, 51, 51, 1)];
        self.mainLabel.textAlignment = NSTextAlignmentCenter;
        
        self.subLabel = [UILabel regularFontWithSize:13 color:rgba(51, 51, 51, 1)];
        self.subLabel.textAlignment = NSTextAlignmentCenter;
        
        
        @weakify(self);
        [self setupLayout:^{
            @strongify(self);
                // layout
                [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.offset(0);
                    make.top.offset(0);
                }];
                
                [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mainLabel.mas_bottom).offset(ver(10));
                    make.left.right.offset(0);
                    make.bottom.offset(0);
                }];
        }];
        
    
    }
    return self;
}

@end
