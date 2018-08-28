//
//  HZYWaterFallCollectionView.m
//  HZYToolBox
//
//  Created by hong  on 2018/8/23.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "HZYWaterFallCollectionView.h"
@interface HZYWaterFallCollectionView()
/** 上一个模型的位置 */
@property(nonatomic,assign)MediaDirection lastDirection;
@end

#define CellInterVal 8
// 正常纵向宽
#define PortaitWidth (SCREEN_W - CellInterVal  * 4)/3
// 正常纵向高

#define PortaitHeight PortaitWidth /0.655

// 一半宽
#define HalfWidth (SCREEN_W - CellInterVal * 3 - PortaitWidth)

// 单个cell宽
#define OneCellWidth SCREEN_W - 16

// 单个cell高
#define OneCellHeight OneCellWidth / 1.7777 + 20

@implementation HZYWaterFallCollectionView
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    HZYWaterFallModel *lastModel;
//    HZYWaterFallModel *currentModel = self.dataArray[indexPath.row];
//    HZYWaterFallModel *nextModel;
//    
//    if (indexPath.row > 0 && indexPath.row <= self.dataArray.count - 2) {
//        lastModel = self.dataArray[indexPath.row - 1];
//        nextModel = self.dataArray[indexPath.row + 1];
//    }
//    
//    
//    if (lastModel && nextModel) {
//        switch (lastModel.direction) {
//            case Portait:{// 上个模型是纵向
//                switch (nextModel.direction) {
//                    case Portait:{// 下个模型是纵向
//                        switch (currentModel.direction) {
//                            case Portait:{
//                                nextModel.size = CGSizeMake(PortaitWidth, PortaitHeight);
//                            }break;
//                            case Landscape:{// 横向
//                                nextModel.size = CGSizeMake(PortaitWidth, HalfWidth);
//                            }break;
//                            default:break;
//                        }
//                    }break;
//                    case Landscape:{// 下个模型是横向
//                        nextModel.size = CGSizeMake((SCREEN_W - CellInterVal * 3 - CellWidth), CellHeight);
//                    }break;
//                    default:break;
//                }
//            }break;
//            case Landscape:{// 上个模型是横向
//                
//                switch (lastModel.direction) {
//                    case Portait:{// 下个模型是纵向
//                        switch (currentModel.direction) {
//                           
//                            }break;
//                            case Landscape:{
//                                return CGSizeMake((SCREEN_W - CellInterVal * 3 - CellWidth), CellHeight);
//                            }break;
//                            default:break;
//                        }
//                    }break;
//                    case Landscape:{
//                        
//                    }break;
//                    default:break;
//                }
//            }break;
//            default:break;
//        }
//    }
//    
//    
//    
//    
//    
//    
//    
//    // 拿到上一个模型和下一个模型，再计算尺寸
//    
//    
//    
//    
//    
//    switch (_lastDirection) {
//        case Portait:{
//            switch (waterFallModel.direction) {
//                case Portait:return CGSizeMake(CellWidth, CellHeight);break;
//                case Landscape:return CGSizeMake((SCREEN_W - CellInterVal * 3 - CellWidth), CellHeight);break;
//                default:return CGSizeMake(CellWidth, CellHeight);break;
//            }
//        }break;
//        case Landscape:{
//            switch (waterFallModel.direction) {
//                case Portait:return CGSizeMake(CellWidth, CellHeight);break;
//                case Landscape:return CGSizeMake((SCREEN_W - CellInterVal * 3 - CellWidth), CellHeight);break;
//                default:return CGSizeMake(CellWidth, CellHeight);break;
//            }
//        }break;
//        default:{
//            switch (waterFallModel.direction) {
//                case Portait:return CGSizeMake(CellWidth, CellHeight);break;
//                case Landscape:return CGSizeMake((SCREEN_W - CellInterVal * 3 - CellWidth), CellHeight);break;
//                default:return CGSizeMake(CellWidth, CellHeight);break;
//            }
//            self.lastDirection = waterFallModel.direction;
//        }break;
//    }
//    return  CGSizeMake(100, 100);
//}
//
////定义每个Section的四边间距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(8, 8, 8, 8);//分别为上、左、下、右
//}
//
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
//    cell.backgroundColor = RGB(arc4random()%255, arc4random()%255, arc4random()%255);
//    return cell;
//}
@end
