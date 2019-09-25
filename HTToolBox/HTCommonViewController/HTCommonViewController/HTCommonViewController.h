//
//  HTCommonViewController.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/27.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCommonViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonViewController : UIViewController

- (instancetype)initWithViewModel:(HTCommonViewModel *)vm;

@end

NS_ASSUME_NONNULL_END
