//
//  UINavigationBar+HTNavigationBar.h
//  HZYToolBox
//
//  Created by hong on 2019/11/18.
//  Copyright © 2019 HZY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (HTNavigationBar)
- (void)setBackgroundColor:(UIColor *)backgroundColor;
- (void)setElementsAlpha:(CGFloat)alpha;
- (void)setTranslationY:(CGFloat)translationY;
- (void)reset;
@end

NS_ASSUME_NONNULL_END
