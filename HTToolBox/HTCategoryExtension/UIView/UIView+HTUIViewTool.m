//
//  UIView+HTUIViewTool.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/6/18.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "UIView+HTUIViewTool.h"

@implementation UIView (HTUIViewTool)

- (void)setCornerWithByRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //绘制圆角 要设置的圆角 使用“|”来组合
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) byRoundingCorners: corners cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        
        //设置大小
        maskLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        //设置图形样子
        maskLayer.path = maskPath.CGPath;

        self.layer.mask = maskLayer;
    });
}


// 设置圆角，暂时不用，会导致文字花
- (void)settingCornerRadius:(CGFloat)radius maskToBounds:(BOOL)maskToBounds {
    self.layer.masksToBounds = maskToBounds;
    self.layer.cornerRadius = radius;
//    self.layer.shouldRasterize = true;
//    self.layer.rasterizationScale = self.layer.contentsScale;
}

- (void)settingCornerRadius:(CGFloat)radius {
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = radius;
}


// 设置阴影
- (void)settingShadowWithShadowRadius:(CGFloat)sr offset:(CGSize)offset color:(UIColor *)color opacity:(CGFloat)opacity {
    self.layer.shadowRadius = sr;
    self.layer.shadowOffset = offset;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
}


// 设置渐变色图层
- (CAGradientLayer *)settingGradientLayerWithRect:(CGRect)rect colors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = rect;
    
    NSMutableArray *colorArray = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorArray addObject:(id)color.CGColor];
    }
    gradient.colors = colorArray;
    gradient.startPoint = CGPointMake(1, 0);
    gradient.endPoint = CGPointMake(0, 1);
    gradient.cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    [self.layer insertSublayer:gradient atIndex:0];
    
    return gradient;
}

// 设置渐变色图层
- (CAGradientLayer *)settingGradientLayerWithRect:(CGRect)rect colors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = rect;
    
    NSMutableArray *colorArray = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorArray addObject:(id)color.CGColor];
    }
    gradient.colors = colorArray;
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    gradient.cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    [self.layer insertSublayer:gradient atIndex:0];
    
    return gradient;
}

// 设置渐变和阴影
- (CAGradientLayer *)settingGrandientAndShadowWithOffset:(CGSize)of shadowColor:(UIColor *)c opacity:(CGFloat)op rect:(CGRect)rect colors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius shadowRadius:(CGFloat)sr {
    [self settingShadowWithShadowRadius:sr offset:of color:c opacity:op];
    return [self settingGradientLayerWithRect:rect colors:colors cornerRadius:cornerRadius];
}

// 获取当前view的控制器
- (UINavigationController *)findBelongNavigationControllerForView:(UIView *)view{
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]) {
            UIViewController *vc = (UIViewController *)responder;
            return vc.navigationController;
        }
    return nil;
}

// 设置边框颜色和宽度
- (void)setBorderWithColor:(UIColor * )color width:(CGFloat)width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}


- (void)setCommonBoardRadiusAndShadow {    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    [self settingShadowWithShadowRadius:5 offset:CGSizeMake(3, 3) color:[UIColor blackColor] opacity:0.05];
}


@end
