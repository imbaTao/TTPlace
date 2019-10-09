//
//  HTPageControl.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/9/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTPageControl.h"

@implementation HTPageControl

- (void)setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 2;
        size.width = 8;
        subview.layer.cornerRadius = 1;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
    }
}

@end
