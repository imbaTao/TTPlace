//
//  HomeView.h
//  TTPlace
//
//  Created by hong on 2020/5/18.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Home.h"

NS_ASSUME_NONNULL_BEGIN
@protocol HomeViewDelegate <NSObject>

/**
 test1
 */
@property(nonatomic, readwrite, strong)UIView *test1;


@end

@interface HomeView : UIView
/**
 delegate
 */
@property(nonatomic,weak)id <HomeViewDelegate> test1Delegate;


/**
 
 */
@property(nonatomic, readwrite, copy)NSString *title;


- (void)test;
//- (void)otherTest;

@end

NS_ASSUME_NONNULL_END
