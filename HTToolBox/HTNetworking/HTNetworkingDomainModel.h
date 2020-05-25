//
//  HTNetworkingDomainModel.h
//  HTPlace
//
//  Created by hong on 2019/12/26.
//  Copyright © 2019 HZY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTNetworkingDomainModel : NSObject

/**
 本地地址
 */
@property(nonatomic, readwrite, copy)NSString *localDomain;

/**
 测试地址
 */
@property(nonatomic, readwrite, copy)NSString *testDomain;

/**
 正式地址
 */
@property(nonatomic, readwrite, copy)NSString *releaseDomain;

@end

NS_ASSUME_NONNULL_END
