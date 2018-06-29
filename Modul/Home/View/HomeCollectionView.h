//
//  HomeCollectionView.h
//  HZYToolBox
//
//  Created by hong  on 2018/6/29.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "BaseCollectionview.h"
@protocol HomeCollectionViewDelegate <NSObject>
- (void)homeCollectionViewCellSelected:(NSIndexPath *)indexPath;
@end


@interface HomeCollectionView : BaseCollectionview
/** cellDelegate */
@property(nonatomic,weak)id <HomeCollectionViewDelegate> cellDelegate;
@end


@interface HomeCollectionViewCell: UICollectionViewCell
/** backGroundImgView */
@property(nonatomic,strong)UIImageView *backGroundImgView;

/** iconImgView */
@property(nonatomic,strong)UIImageView *iconImgView;

@end;
