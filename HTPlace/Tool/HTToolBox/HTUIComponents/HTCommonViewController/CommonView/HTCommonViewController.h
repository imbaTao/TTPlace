//
//  HTCommonViewController.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/27.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCommonViewModel.h"

// 这个控制器需要外部自己创建一个，用来桥接继承你自己的BaseViewContller
//#import "BridgeBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonViewController : UIViewController

- (instancetype)initWithViewModel:(HTCommonViewModel *)vm;

@end

NS_ASSUME_NONNULL_END
