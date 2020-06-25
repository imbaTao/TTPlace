//
//  DataCache.h
//  CloneFactoryApp
//
//  Created by liucai on 2017/9/4.
//  Copyright © 2017年 CSCHS. All rights reserved.
//


/**
 *  此工具类 主要用于数据的 归档/接档
 */

#import <Foundation/Foundation.h>

@interface HTDataCache : NSObject

/**
 *  归档
 *  @param datas 需要归档的数据
 *  @param path 归档路径
 */
+ (BOOL)keyedArchiverWithData:(id)datas path:(NSString *)path;

/**
 *  解档
 *  @param path 解档路径
 */
+ (id)keyedUnArchiverWithPath:(NSString *)path;

@end
