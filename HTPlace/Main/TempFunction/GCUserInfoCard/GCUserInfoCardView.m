//
//  GCUserInfoCardView.m
//  HTPlace
//
//  Created by Mr.hong on 2020/9/14.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "GCUserInfoCardView.h"
#import "GCUserInfoCardViewLabel.h"


@interface GCUserInfoCardView()



/**
 是否动画中
 */
@property(nonatomic, readwrite, assign)BOOL animated;


@end

@implementation GCUserInfoCardView

#define TimeInterval 0.3
#define WhiteBoardHeight ver(362) + HTTabBarBottomHeight
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor  = rgba(0, 0, 0, 0.4);
        [self addTarget:self action:@selector(hidde) forControlEvents:UIControlEventTouchUpInside];
        
        [[UIApplication sharedApplication].windows.firstObject addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        self.whiteBoard = [[UIView alloc] init];
        self.whiteBoard.backgroundColor = [UIColor whiteColor];
        [self.whiteBoard settingCornerWithByRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:16];
        
        
        
        self.userIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
        [self.userIcon setBorderWithColor:[UIColor whiteColor] width:3];
        [self.userIcon settingCornerRadius:hor(34)];
        self.userIcon.contentMode = UIViewContentModeScaleAspectFill;
        
        self.reportButton = [UIButton title:@"举报" selector:@selector(reportAction) target:self iconName:@"GCUserInfoCardView_report"];
        [self.reportButton setTitleColor:rgba(51, 51, 51, 1) forState:UIControlStateNormal];
        [self.reportButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -8)];
        
        self.requIdNumber = [UILabel size:13 color:rgba(51, 51, 51, 1) textAlignment:NSTextAlignmentCenter placeholder:@"热趣号: 1231313131231"];
        
        self.tagBard = [[UIView alloc] init];
        
        self.textBoard = [[UIView alloc] init];
       
        
        self.sgLine = [[UIView alloc] init];
        self.sgLine.backgroundColor = rgba(238, 238, 238, 0.8);
        
         self.bottomButtonBoard = [[UIView alloc] init];
        
        
        
        [self addSubview:self.whiteBoard];
        [self addSubview:self.userIcon];
        [self.whiteBoard addSubview:self.reportButton];
        [self.whiteBoard addSubview:self.requIdNumber];
        
        [self.whiteBoard addSubview:self.tagBard];
        [self.whiteBoard addSubview:self.textBoard];
        [self.whiteBoard addSubview:self.sgLine];
        [self.whiteBoard addSubview:self.bottomButtonBoard];
        
        
        
        // 布局
        [self.whiteBoard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(WhiteBoardHeight);
            make.width.offset(SCREEN_W);
            make.height.offset(WhiteBoardHeight);
        }];
        
        // 用户icon
        [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.whiteBoard.mas_top);
            make.size.mas_equalTo(HTSIZE(68, 68));
            
        }];
        
        
        //  举报
        [self.reportButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-hor(15));
            make.top.offset(ver(12));
        }];
        
        
        [self.requIdNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(self.userIcon.mas_bottom).offset(ver(40));
        }];
        
        
        self.tagBard.backgroundColor = [UIColor redColor];
        [self.tagBard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.requIdNumber.mas_bottom).offset(ver(20));
            make.left.right.offset(0);
            make.height.offset(ver(20));
        }];
        
        
        self.textBoard.backgroundColor = [UIColor greenColor];
        [self.textBoard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(self.tagBard.mas_bottom).offset(17);
            make.centerX.equalTo(self);
            make.height.offset(ver(41));
        }];
        
        [self.sgLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(hor(18));
            make.right.offset(-hor(18));
            make.top.equalTo(self.textBoard.mas_bottom).offset(ver(20));
            make.height.offset(1);
        }];
        
        [self.bottomButtonBoard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.offset(ver(58));
            make.top.equalTo(self.sgLine.mas_bottom);
        }];
        
        [self layoutIfNeeded];
    }
    
        // 底部面板
    [self creatBottomButton];
    
    [self refreshInfo];
    return self;
}


// 刷新面板显示数据
- (void)refreshInfo {
    // icon换
    
    
    // 号换
    
    // tag板重新生成
    
    
    // text板重新生成
    [self creatTextContent];
    

}


#pragma mark - 重新生成tag标签
- (void)creatTag {
    // 移除所有的
    for (UIView *subView in self.tagBard.subviews) {
        [subView removeFromSuperview];
    }
     NSMutableArray *items = [[NSMutableArray alloc] init];
     CGFloat interval = hor(60);
      [items mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:hor(34) leadSpacing:interval tailSpacing:interval];
      [items mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.bottom.equalTo(self.textBoard);
      }];
      
    [self layoutIfNeeded];
}

// 魅力值等内容
- (void)creatTextContent {
    for (UIView *item in self.textBoard.subviews) {
        [item removeFromSuperview];
    }
    
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        GCUserInfoCardViewLabel *label = [[GCUserInfoCardViewLabel alloc] init];
        
        switch (i) {
            case 0:{
                label.mainLabel.text = @"10";
                label.subLabel.text = @"订阅";
                
            }break;
            case 1:{
                label.mainLabel.text = @"1";
                label.subLabel.text = @"收到魅力";
            }break;
            case 2:{
                label.mainLabel.text = @"123131";
                label.subLabel.text = @"送出魅力";
            }break;
            default:break;
        }
        
        [self.textBoard addSubview:label];
        [items addObject:label];
    }
    
    CGFloat interval = hor(60);
    [items mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:hor(34) leadSpacing:interval tailSpacing:interval];
    [items mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.textBoard);
    }];
    
      [self layoutIfNeeded];
}



// 创建底部按钮
- (void)creatBottomButton {
    // 按钮标题
    NSArray *titles = @[@"@Ta",@"送礼物",@"撩一下"];
    

     NSMutableArray *items = [[NSMutableArray alloc] init];
    
    // 创建等同数量按钮
    for (int i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithTitle:titles[i] titleColor:rgba(51, 51, 51, 1) font:[UIFont fontSize:15]];
        if (i == 0) {
            [button setTitleColor:rgba(196, 92, 201, 1) forState:UIControlStateNormal];
        }
//        button.backgroundColor = [UIColor blackColor];
        [self.bottomButtonBoard addSubview:button];
        
        @weakify(self);
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self bottomButtonAction:x];
        }];
         [items addObject:button];
    }
    
    CGFloat interval = hor(18);
    [items mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:hor(54) leadSpacing:interval tailSpacing:interval];
    [items mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.bottomButtonBoard);
    }];
}



// 举报按钮事件
- (void)reportAction {
    
}


- (void)show {
    
    
    // 是否有视图
    //    BOOL hasInfoView = false;
    //    for (UIView *sub in [UIApplication sharedApplication].windows.firstObject.subviews) {
    //        hasInfoView
    //    }
    
    
    if (!self.animated) {
        self.animated = true;
        
        // 布局
         [self.whiteBoard mas_updateConstraints:^(MASConstraintMaker *make) {
             make.bottom.offset(100);
         }];
    
        // 隐藏，动画结束移除
        [UIView animateWithDuration:TimeInterval animations:^{
            [self layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.animated = false;
        }];
        
        
    }
    
    
}

- (void)hidde {
    if (!self.animated) {
        self.animated = true;
        
        // 布局
          [self.whiteBoard mas_updateConstraints:^(MASConstraintMaker *make) {
              make.bottom.offset(WhiteBoardHeight + hor(70));
          }];
        
        
//        [UIView animateWithDuration:TimeInterval delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionTransitionCurlDown animations:^{
//             [self layoutIfNeeded];
//        }  completion:^(BOOL finished) {
//           self.animated = false;
//                      [self removeFromSuperview];
//        }];
        
        // 隐藏，动画结束移除
        [UIView animateWithDuration:TimeInterval animations:^{
                [self layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.animated = false;
            [self removeFromSuperview];
        }];
        
        
    }
    
}
@end
