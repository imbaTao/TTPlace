//
//  BaseCollectionview.h
//  HTToolBox
//
//  Created by hong  on 2018/6/29.
//  Copyright © 2018年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseCollectionview : UICollectionView <UICollectionViewDelegate,UICollectionViewDataSource>

/** dataArray */
@property(nonatomic,strong)NSMutableArray *dataArray;

/** ID */
@property(nonatomic,copy)NSString *cellID;

- (instancetype)initWithLayout:(UICollectionViewFlowLayout *)layout cellClass:(id)class identifier:(NSString *)identifier;

@end


//@interface BaseCollectionviewCell: UICollectionViewCell
//
///** contentLabel */
//@property(nonatomic,strong)UILabel *contentLabel;
//
//@end

