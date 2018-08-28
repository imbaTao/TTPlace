//
//  HZYWaterFallModel.h
//  HZYToolBox
//
//  Created by hong  on 2018/8/23.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger,MediaDirection) {
    Portait = 1,
    Landscape
};

@interface HZYWaterFallModel : NSObject

/** 视频比例 */
@property(nonatomic,assign)MediaDirection direction;

/** 尺寸 */
@property(nonatomic,assign)CGSize size;

@end
