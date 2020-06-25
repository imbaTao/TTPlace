//
//  HTMaskBoard.m
//  HTPlace
//
//  Created by hong on 2019/12/3.
//  Copyright © 2019 HZY. All rights reserved.
//

#import "HTMaskBoard.h"
@interface HTMaskBoard()

/**
 动画时间
 */
@property(nonatomic, readwrite, assign)CGFloat animateInterval;

/**
 是否能点击隐藏
 */
@property(nonatomic, readwrite, assign)BOOL touchHide;


/**
 父视图
 */
@property(nonatomic,weak)UIView *fatherView;


@end

@implementation HTMaskBoard
//- (instancetype)initWithSubiew:(UIView *)subView maskColor:(nullable UIColor *)maskColor touchHide:(BOOL)touchHide animateInterval:(CGFloat)animateInterval subviewLayout:(void(^)(UIView *subView))layoutBlock{

// 传入一个子试图,用block把子视图传回去然后布局
- (instancetype)initWithSubiew:(UIView *)subView fatherView:(nullable UIView *)fatherView maskColor:(nullable UIColor *)maskColor touchHide:(BOOL)touchHide animateInterval:(CGFloat)animateInterval {
    self = [super init];
    if (self) {
        self.coreSubView = subView;
        if (!maskColor) {
            maskColor = rgba(0, 0, 0, 0.5);
        }
        self.backgroundColor = maskColor;
        self.animateInterval = animateInterval;
        
        // 是否可以点击隐藏
        self.touchHide = touchHide;
        
        // 如果可以点击隐藏
        if (self.touchHide) {
            @weakify(self);
            [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self);
                
                // 点击隐藏自身
                [self hideMask];
            }];
        }
        [self addSubview:subView];
        if (!fatherView) {
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }else {
            [fatherView addSubview:self];
        }
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)changeCoreSubView:(UIView *)coreSubView {
    if (self.coreSubView) {
        [self.coreSubView removeFromSuperview];
    }
    [self addSubview:coreSubView];
    self.coreSubView = coreSubView;
}


- (void)showMask{
    if (self.animateInterval > 0) {
         self.userInteractionEnabled = false;
        [UIView animateWithDuration:self.animateInterval animations:^{
            self.alpha = 1;
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = true;
            self.showed = true;
        }];
    }else {
        // 没有执行动画，直接显示
        self.showed = true;
        self.alpha = 1;
    }
}

// 隐藏和展示
- (void)hideMask {
    if (self.animateInterval > 0) {
        self.userInteractionEnabled = false;
        [UIView animateWithDuration:self.animateInterval animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            self.userInteractionEnabled = true;
            self.showed = false;
        }];
    }else {
        // 没有执行动画，直接隐藏
        self.alpha = 0;
        self.showed = false;
    }
    [self endEditing:true];
}

- (void)destroyMask {
    if (self.coreSubView) {
        [self.coreSubView removeFromSuperview];
    }
    [self removeFromSuperview];
}
@end
