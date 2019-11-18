//
//  UIView+HTView.h
//  Jihuigou-Native
//
//  Created by hong on 2019/11/12.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HTView)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign, readonly) CGFloat maxY;
@property (nonatomic, assign, readonly) CGFloat maxX;

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) UINavigationController *navigationController;

- (void)color:(UIColor *)color;
- (void)whiteColor;
- (void)grayColor;
- (void)redColor;
- (void)yellowColor;
@end

NS_ASSUME_NONNULL_END
