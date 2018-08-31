//
//  HZYPopoverBackgroundView.m
//  HZYToolBox
//
//  Created by hong  on 2018/8/31.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "HZYPopoverBackgroundView.h"


@interface HZYPopoverBackgroundView()
@property (nonatomic, strong) UIImageView *arrowImageView;
@end


@implementation HZYPopoverBackgroundView
#define kArrowBase 30.0f
#define kArrowHeight 30.0f
#define kBorderInset 8.0f
@synthesize arrowDirection  = _arrowDirection;
@synthesize arrowOffset     = _arrowOffset;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(51, 51, 57);
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.cornerRadius = 10;
        self.layer.shadowOpacity = 0.01;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    CGSize arrowSize = CGSizeMake([[self class] arrowBase], [[self class] arrowHeight]);
//    self.arrowImageView.image = [self drawArrowImage:arrowSize];
//      CGFloat arrowXCoordinate = floorf(((self.bounds.size.width / 2.0f) - (arrowSize.width / 2.0f)));
//    self.arrowImageView.frame = CGRectMake(arrowXCoordinate, 0.0f, arrowSize.width, arrowSize.height);
//
 
    
}

-(CGFloat)arrowOffset {
    return 0.0f;
}

-(UIPopoverArrowDirection)arrowDirection {
    return UIPopoverArrowDirectionUp;
}

-(void)setArrowDirection:(UIPopoverArrowDirection)arrowDirection {
    _arrowDirection = UIPopoverArrowDirectionUp;
}

+ (CGFloat)arrowBase
{
    return kArrowBase;
}

+ (CGFloat)arrowHeight{
    return kArrowHeight;
}

+ (UIEdgeInsets)contentViewInsets
{
    return UIEdgeInsetsMake(kBorderInset, kBorderInset,kBorderInset,kBorderInset);
}

- (UIImage *)drawArrowImage:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] setFill];
    CGContextFillRect(ctx, CGRectMake(0.0f, 0.0f, size.width, size.height));
    
    CGMutablePathRef arrowPath = CGPathCreateMutable();
    CGPathMoveToPoint(arrowPath, NULL, (size.width/2.0f), 0.0f); //Top Center
    CGPathAddLineToPoint(arrowPath, NULL, size.width, size.height); //Bottom Right
    CGPathAddLineToPoint(arrowPath, NULL, 0.0f, size.height); //Bottom Right
    CGPathCloseSubpath(arrowPath);
    CGContextAddPath(ctx, arrowPath);
    CGPathRelease(arrowPath);
    
    UIColor *fillColor = [UIColor yellowColor];
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
