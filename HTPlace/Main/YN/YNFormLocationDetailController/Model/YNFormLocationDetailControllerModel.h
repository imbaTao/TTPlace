//
//  YNFormLocationDetailControllerModel.h
//  HTPlace
//
//  Created by Mr.hong on 2020/6/27.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNFormLocationDetailControllerModel : NSObject

/**
 标题
 */
@property(nonatomic, readwrite, copy)NSString *title;

/**
 城市数组
 */
@property(nonatomic, readwrite, copy)NSArray<NSString *> *lists;


@end

NS_ASSUME_NONNULL_END
