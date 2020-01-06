//
//  JHGOrderInpuPasswordModel.h
//  HTPlace
//
//  Created by hong on 2019/12/5.
//  Copyright © 2019 HZY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHGOrderInpuPasswordModel : NSObject

/**
 下标
 */
@property(nonatomic, readwrite, assign)NSInteger index;

/**
 是否有值了
 */
@property(nonatomic, readwrite, assign)BOOL hasValue;


@end

NS_ASSUME_NONNULL_END
