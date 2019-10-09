//
//  HTCycleViewManager.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/9/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCycleViewManager.h"
#import "HTCycleNormalView.h"

@implementation HTCycleViewManager

+ (HTCycleView *)creatCyleViewWithStyle:(HTCycleViewStyle)style size:(CGSize)size{
    HTCycleViewConfigModel *configModel;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout  alloc] init];
    HTCycleView *cyleView;
    switch (style) {
        case HTCycleViewStyleNormalStyle:{
            layout.minimumLineSpacing = 0;
            layout.minimumInteritemSpacing = 0;
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.itemSize = size;
            configModel= [[HTCycleViewConfigModel alloc] initWithFlowLayout:layout cellClassName:@"HTCycleViewNormalStyleCell"];
            configModel.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            cyleView = [[HTCycleNormalView alloc] initWithConfigModel:configModel];
        }break;
        case HTCycleViewStyleVerticalStyle: {
            
        }break;
    }
    return cyleView;
}




@end
