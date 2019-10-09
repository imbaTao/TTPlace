//
//  HTCyleViewManager.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/9/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTCycleView.h"


NS_ASSUME_NONNULL_BEGIN


typedef NS_OPTIONS(NSInteger, HTCycleViewStyle) {
    HTCycleViewStyleNormalStyle,// 普通轮播图单页单张横向图片样式
    HTCycleViewStyleVerticalStyle,//纵向滚动默认单页隐藏pageContoll
};

@interface HTCycleViewManager : NSObject

/**
 根据风格创建轮播图
 */
+ (HTCycleView *)creatCyleViewWithStyle:(HTCycleViewStyle)style size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
