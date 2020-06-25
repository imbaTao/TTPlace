//
//  HTDataCache.m
//  CloneFactoryApp
//
//  Created by liucai on 2017/9/4.
//  Copyright © 2017年 CSCHS. All rights reserved.
//

#import "HTDataCache.h"

@implementation HTDataCache

+ (BOOL)keyedArchiverWithData:(id)datas path:(NSString *)path {
    //拼接存储地址
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",path]];
    BOOL flag = [NSKeyedArchiver archiveRootObject:datas toFile:filePath];
    return flag;
}

+ (id)keyedUnArchiverWithPath:(NSString *)path {
    //拼接存储地址
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",path]];
    id data = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return data;
}

@end
