//
//  UIView+HTView.m
//  Jihuigou-Native
//
//  Created by hong on 2019/11/12.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "UIView+HTView.h"

@implementation UIView (HTView)
- (void)setupUI {
    // 复写
}

- (void)setupLayout:(void(^)(void))layoutBlock {
    // 用到成员变量布局时复写
    [self addMemberSubViews];
    layoutBlock();
}

- (void)setupLayoutWithSuperView:(UIView *)superView layout:(void(^)(void))layoutBlock {
    [self addMemberSubViews:superView];
    layoutBlock();
}

// 添加成员变量视图到父视图上
- (void)addMemberSubViews {
    unsigned int outCount = 0;
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        NSString *name = [NSString stringWithFormat:@"%s",ivar_getName(ivar)];
        //        NSString *type = [NSString stringWithFormat:@"%s", ivar_getTypeEncoding(ivar)];
        
        id subViews = [self valueForKey:name];
        
        // 如果是视图，就把视图添加上去
        if ([subViews isKindOfClass:[UIView class]] && subViews) {
            [self addSubview:subViews];
        }
    }
    free(ivars);
}


- (void)addMemberSubViews:(UIView *)superView {
    unsigned int outCount = 0;
   Ivar * ivars = class_copyIvarList([self class], &outCount);
   for (unsigned int i = 0; i < outCount; i ++) {
       Ivar ivar = ivars[i];
       NSString *name = [NSString stringWithFormat:@"%s",ivar_getName(ivar)];
       //        NSString *type = [NSString stringWithFormat:@"%s", ivar_getTypeEncoding(ivar)];
       
       id subViews = [self valueForKey:name];
       
       // 如果是视图，就把视图添加上去
       if ([subViews isKindOfClass:[UIView class]] && subViews) {
           [superView addSubview:subViews];
       }
   }
   free(ivars);
}




+ (instancetype)viewWithColor:(UIColor *)color {
    UIView *view = [UIView p_view];
    view.backgroundColor = color;
    return view;
}


+ (instancetype)viewWithCornerRadius:(CGFloat)radius {
    UIView *view = [UIView p_view];
    view.backgroundColor = [UIColor whiteColor];
    [view settingCornerRadius:radius];
    return view;
}

+ (instancetype)viewWithColor:(UIColor *)color cornerRadius:(CGFloat)radius {
    UIView *view = [UIView p_view];
    view.backgroundColor = color;
    [view settingCornerRadius:radius];
    return view;
}

+ (instancetype)p_view {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColor.whiteColor;
    return view;
}

- (void)color:(UIColor *)color {
    self.backgroundColor = color;
}

- (void)whiteColor {
    self.backgroundColor = UIColor.whiteColor;
}

- (void)yellowColor {
    self.backgroundColor = UIColor.yellowColor;
}

- (void)redColor {
    self.backgroundColor = UIColor.redColor;
}

- (void)grayColor {
    self.backgroundColor = UIColor.grayColor;
}
@end
