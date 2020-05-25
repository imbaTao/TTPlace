//
//  HTHudManager.h
//  Jihuigou-Native
//
//  Created by hong on 2020/1/3.
//  Copyright © 2020 xiongbenwan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTHudManager : NSObject
singleH();



/**
 隐藏时间,默认1.2秒
 */
@property(nonatomic, readwrite, assign)NSTimeInterval hiddenTimeInterval;

@end

NS_ASSUME_NONNULL_END
