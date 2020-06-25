//
//  HTNetworkingDomainModel.m
//  HTPlace
//
//  Created by hong on 2019/12/26.
//  Copyright © 2019 HZY. All rights reserved.
//

#import "HTNetworkingDomainModel.h"

@implementation HTNetworkingDomainModel

- (NSString *)localDomain {
    if (!_localDomain) {
        _localDomain = self.releaseDomain;
    }
    return _localDomain;
}


- (NSString *)testDomain {
    if (!_testDomain) {
        _testDomain = self.releaseDomain;
    }
    return _testDomain;
}

- (NSString *)releaseDomain {
    if (!_releaseDomain) {
        // 哥..正式环境地址必须要配
        NSParameterAssert(_releaseDomain);
    }
    return _releaseDomain;
}

@end
