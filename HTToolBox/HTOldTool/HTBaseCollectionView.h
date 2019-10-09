//
//  HTBaseCollectionView.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/6/18.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTBaseCollectionView : UICollectionView <UICollectionViewDelegate,UICollectionViewDataSource>
/**
 cellID标识
 */
@property(nonatomic, readwrite, copy)NSString *cellID;

/**
 模型数据数组
 */
@property(nonatomic, readwrite, strong)NSMutableArray *data;




/**
 传入id标识 跟class的字符串
 */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout identifer:(NSString *)identifer cellClassString:(NSString *)classString;


@end

NS_ASSUME_NONNULL_END
