//
//  YNFormLocationDetailControllerViewModel.h
//  HTPlace
//
//  Created by Mr.hong on 2020/6/27.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTCommonTableViewModel.h"
#import "YNFormLocationDetailControllerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YNFormLocationDetailControllerViewModel : HTCommonTableViewModel
/**
 定位到的城市
 */
@property(nonatomic, readwrite, copy)NSString *locationCityName;

@end

NS_ASSUME_NONNULL_END
