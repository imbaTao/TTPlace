//
//  BaseTabbarView.h
//  HTToolBox
//
//  Created by hong  on 2018/6/29.
//  Copyright © 2018年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BaseTabbarViewDelegate <NSObject>
- (void)changeBarIndexWithIndex:(NSInteger)index;
@end


@interface BaseTabbarView : UIView
/** delegate */
@property(nonatomic,weak)id <BaseTabbarViewDelegate> delegate;
@end
