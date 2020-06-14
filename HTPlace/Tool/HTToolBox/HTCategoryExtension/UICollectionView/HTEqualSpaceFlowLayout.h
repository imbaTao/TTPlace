//
//  HTEqualSpaceFlowLayout.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/6/24.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 这个Layout类是可以自动换行左对齐的
 */
NS_ASSUME_NONNULL_BEGIN

@protocol  HTEqualSpaceFlowLayoutDelegate<UICollectionViewDelegateFlowLayout>
@end

@interface HTEqualSpaceFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id<HTEqualSpaceFlowLayoutDelegate> delegate;

- (instancetype)initWith:(CGFloat)minimumLineSpacing minimumInteritemSpacing:(CGFloat)minimumInteritemSpacing sectionInset:(UIEdgeInsets)sectionInset;
@end

NS_ASSUME_NONNULL_END
