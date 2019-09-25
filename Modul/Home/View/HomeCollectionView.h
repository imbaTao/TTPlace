//
//  HomeCollectionView.h
//  HTToolBox
//
//  Created by hong  on 2018/6/29.
//  Copyright © 2018年 HT. All rights reserved.
//

#import "BaseCollectionview.h"
@protocol HomeCollectionViewDelegate <NSObject>
- (void)homeCollectionViewCellSelected:(NSIndexPath *)indexPath;
@end

typedef NS_OPTIONS(NSInteger, ComposingType) {
    Row = 0,
    Col
};
@interface HomeCollectionView : BaseCollectionview
/** cellDelegate */
@property(nonatomic,weak)id <HomeCollectionViewDelegate> cellDelegate;
/** rowOrCloum */
@property(nonatomic,assign)ComposingType rowOrCol;
@end



















@interface HomeCollectionViewCell: UICollectionViewCell

/** titleLB */
@property(nonatomic,strong)UILabel *titleLB;

/** backGroundImgView */
@property(nonatomic,strong)UIImageView *backGroundImgView;

/** iconImgView */
@property(nonatomic,strong)UIImageView *iconImgView;

/** <#??#> */
@property(nonatomic,assign)BOOL isSelected;

@end;
