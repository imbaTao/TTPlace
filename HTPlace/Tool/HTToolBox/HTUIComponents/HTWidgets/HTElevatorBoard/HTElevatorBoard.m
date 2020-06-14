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
@property(nonatomic, readwrite, strong)UIControl *masking;


/**
 是否加在window上
 */
@property(nonatomic, readwrite, assign)BOOL onWindow;

/**
 原始高度
 */
@property(nonatomic, readwrite, assign)CGSize sourceSize;

/**
 距离顶部高度
 */
@property(nonatomic, readwrite, assign)CGFloat topInterval;


@end

@implementation HTElevatorBoard

// 默认是在控制器View上
- (instancetype)initWithSize:(CGSize)size vClass:(Class)vClass {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.sourceSize = size;
        self.layer.masksToBounds = true;
        self.backgroundColor = [UIColor clearColor];
        self.masking = [[UIControl alloc] init];
        self.masking.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        //            self.masking.userInteractionEnabled = false;
        [self addSubview:self.masking];
        [self.masking mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        
        // 创建内容对象
        if (vClass) {
            NSLog(@"我进来了");
            self.v = [[[vClass class] alloc] initWithFrame:CGRectZero];
            self.v.backgroundColor = [UIColor whiteColor];
            [self addSubview:self.v];
            [self.v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.offset(0);
                make.height.offset(size.height);
                switch (self.type) {
                    case HTElevatorBoardTypeTop:{
                        make.top.offset(-self.sourceSize.height);
                    };break;
                    case HTElevatorBoardTypeBottom:make.bottom.offset(0);break;
                    default:break;
                }
            }];
        }
        
        // 添加点击隐藏事件
        [self.masking addTarget:self action:@selector(maskClickhiddenBoad) forControlEvents:UIControlEventTouchUpInside];
        
        // 先布局一下,不然初次动画异常
        [self.superview layoutIfNeeded];
        
        // 刚进去这个面板是隐藏的
        self.hidden = true;
    }
    return self;
}

// 直接传进去一个子试图
- (instancetype)initWithSize:(CGSize)size subView:(UIView *)subview {
    self = [self initWithSize:size vClass:nil];
    [self addSubview:subview];
    [subview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(size.height);
        switch (self.type) {
            case HTElevatorBoardTypeTop:{
                make.top.offset(-self.sourceSize.height);
            };break;
            case HTElevatorBoardTypeBottom:make.bottom.offset(0);break;
            default:break;
        }
    }];
    self.v = subview;
    
    // 先布局一下,不然初次动画异常
    [self layoutIfNeeded];
    return self;
}

// 是否在window上
- (instancetype)initWithSize:(CGSize)size vClass:(Class)vClass onWindow:(BOOL)onWindow topInterval:(CGFloat)topInterval {
    self = [self initWithSize:size vClass:vClass];
    self.onWindow = onWindow;
    self.topInterval = topInterval;
    
    if (onWindow) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(self.topInterval);
            make.left.right.bottom.offset(0);
        }];
        [self layoutIfNeeded];
    }
    return self;
}

- (void)showBoard:(nullable void (^)(void))complete {
    // 延迟0秒展示面板,不然动画会异常
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 重新展现
        self.hidden = false;
        
        // 显示位设置为ture
        self.isShowing = true;
        
        // 如果是在window上显示的,重新加上
        if (self.onWindow && !self.superview) {
            [[UIApplication sharedApplication].keyWindow addSubview:self];
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(self.topInterval);
                make.left.right.bottom.offset(0);
            }];
            [self layoutIfNeeded];
        }
        
        // 展示时先显示蒙版
        self.masking.hidden = false;
        
        // 展示内容板移动动画
        [UIView animateWithDuration:self.duration animations:^{
            // 内容板子执行位移
            [self.v mas_updateConstraints:^(MASConstraintMaker *make) {
                // 高度收为0
                make.top.offset(0);
            }];
            [self.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (complete) {
                complete();
            }
            
        }];
    });
}



- (void)maskClickhiddenBoad {
    [self hiddenBoard:nil];
}


- (void)hiddenBoard:(void (^)(void))complete {
    self.masking.hidden = true;
    
    // 显示位设置为false
    self.isShowing = false;
    [UIView animateWithDuration:self.duration animations:^{
        // 内容板子执行位移
        [self.v mas_updateConstraints:^(MASConstraintMaker *make) {
            // 更改距离顶部位置
            make.top.offset(-self.sourceSize.height);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        // 设置隐藏,不然会遮挡按钮
        self.hidden = true;
        
        // 如果是在window上显示,从window上移除，防止循环引用
        if (self.onWindow) {
            [self removeFromSuperview];
        }
        
        if (complete) {
            complete();
        }
    }];
}

- (void)changeSubViewHeight:(CGFloat)height {
    self.sourceSize = CGSizeMake(self.sourceSize.width, height);
    [self.v mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(height);
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
