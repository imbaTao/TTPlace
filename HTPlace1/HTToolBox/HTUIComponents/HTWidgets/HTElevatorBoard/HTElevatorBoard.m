//
//  HTElevatorBoard.m
//  Jihuigou-Native
//
//  Created by hong on 2019/11/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTElevatorBoard.h"


@interface HTElevatorBoard <__covariant T: UIView *>()

/**
 背景蒙版，默认黑色
 点击收起的时候，遮罩优先消失，内容面板后消失
 */
@property(nonatomic, readwrite, strong)UIView *masking;

/**
 是否加在window上
 */
@property(nonatomic, readwrite, assign)BOOL onWindow;

/**
 原始高度
 */
@property(nonatomic, readwrite, assign)CGSize sourceSize;

@end

@implementation HTElevatorBoard

// 默认是在控制器View上
- (instancetype)initWithSize:(CGSize)size vClass:(Class)vClass {
      self = [super initWithFrame:CGRectZero];
        if (self) {
            self.sourceSize = size;
            self.backgroundColor = [UIColor clearColor];
            self.masking = [[UIView alloc] init];
            self.masking.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
            [self addSubview:self.masking];
            [self.masking mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
            }];
            
            // 创建内容对象
            self.v = [[[vClass class] alloc] initWithFrame:CGRectZero];
            self.v.layer.masksToBounds = true;
            [self addSubview:self.v];
            [self.v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.offset(0);
                make.height.offset(0);
            }];
            
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBoard:)];
            [self addGestureRecognizer:tap];
            
            [self.superview layoutIfNeeded];
        }
      return self;
}


// 从外面传入一个内容板
- (instancetype)initWithContentView:(UIView *)view onWindow:(BOOL)onWindow size:(CGSize)size{
    self = [self initWithContentView:view size:size];
    self.onWindow = onWindow;
    return self;
}
//
//- (instancetype)initWithBackGroundColor:(UIColor *)color contentView:(UIView *)view onWindow:(BOOL)onWindow size:(CGSize)size{
//    self = [self initWithContentView:view onWindow:onWindow size:size];
//    self.masking.backgroundColor = color;
//    return self;
//}

- (void)showBoard {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         // 如果是在window上显示的,重新加上
          if (self.onWindow) {
              [[UIApplication sharedApplication].windows.firstObject addSubview:self];
          }
           
           // 展示时先显示蒙版
           self.masking.hidden = false;
           
           // 展示内容板移动动画
           [UIView animateWithDuration:self.duration animations:^{
               // 内容板子执行位移
               [self.v mas_updateConstraints:^(MASConstraintMaker *make) {
                   // 高度收为0
                   make.height.offset(self.sourceSize.height);
               }];
               [self.superview layoutIfNeeded];
           } completion:^(BOOL finished) {}];
    });
}

- (void)hiddenBoard:(UITapGestureRecognizer *)sender {
    self.masking.hidden = true;
    [UIView animateWithDuration:self.duration animations:^{
        // 内容板子执行位移
        [self.v mas_updateConstraints:^(MASConstraintMaker *make) {
            // 高度收为0
            make.height.offset(0);
        }];
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        // 如果是在window上显示,从window上移除，防止循环引用
         if (self.onWindow) {
             [self removeFromSuperview];
         }
    }];
}


#pragma mark - Setter && Getter
- (CGFloat)duration {
    if (!_duration) {
        _duration = 0.4;
    }
    return _duration;
}

@end
