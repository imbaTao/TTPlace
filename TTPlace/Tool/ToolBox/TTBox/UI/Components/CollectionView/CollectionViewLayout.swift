////
////  CollectionViewLayout.swift
////  Yuhun
////
////  Created by Mr.hong on 2021/1/18.
////
//
//import Foundation
//
//// 横向layout
//class HorizontalLeftToRightPaddingCollectionLayout: UICollectionViewFlowLayout {
//    var columnCount = 4
//    var rowCount = 2
//
//
//    // 保存所有item
//    fileprivate var attributesArr: [UICollectionViewLayoutAttributes] = []
//
//    // MARK:- 重新布局
//    override func prepare() {
//        super.prepare()
//
////        let itemWH: CGFloat = itemSize.width
//
//        // item的宽度
//        let itemWidth: CGFloat = ((SCREEN_W - 12 * 2) - 12.0 * CGFloat(columnCount - 1)) / CGFloat(columnCount)
//        let itemHeight = itemWidth * 104.0 / 77
//        self.itemSize  = CGSize.init(width: itemWidth,height: itemHeight)
//
//        // 设置itemSize
//        scrollDirection = .horizontal
//
//        // 设置collectionView属性
//        collectionView?.isPagingEnabled = true
//        collectionView?.showsHorizontalScrollIndicator = false
//        collectionView?.showsVerticalScrollIndicator = false
//
//
//        var page = 0
//        let itemsCount = collectionView?.numberOfItems(inSection: 0) ?? 0
//        for itemIndex in 0..<itemsCount {
//            let indexPath = IndexPath(item: itemIndex, section: 0)
//            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//
//            page = itemIndex / (columnCount * rowCount)
//
//            // 通过一系列计算, 得到x, y值
//            let horizontalAllItemWidth = itemSize.width * CGFloat(itemIndex % Int(columnCount))
//            let everyPageWidth = (CGFloat(page) * (SCREEN_W - 6 * 2))
////            let everyPageInterval = (CGFloat(page) * 12.0)
//            let everyPageInterval = (CGFloat(page + 1) * 6.0) + (CGFloat(page) * 6.0)
//            let horizontalInterval =  12.0 * CGFloat(itemIndex % columnCount)
//
//            //  每页之间item的间隔， + 换页后的间隔
//            //  itemIndex % columnCount得到的是下标,如果不是开始index 0或者5
//
//
//            // 每个item的x
//            let x = horizontalAllItemWidth + everyPageWidth + horizontalInterval + everyPageInterval
//
//            let y = itemSize.height * CGFloat((itemIndex - page * rowCount * columnCount) / columnCount) + CGFloat((itemIndex - page * rowCount * columnCount) / columnCount * 12)
//
//            attributes.frame = CGRect(x: x, y: y, width: 100, height: itemSize.height)
//            // 把每一个新的属性保存起来
//            attributesArr.append(attributes)
//        }
//
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        var rectAttributes: [UICollectionViewLayoutAttributes] = []
//        _ = attributesArr.map({
//            if rect.contains($0.frame) {
//                rectAttributes.append($0)
//            }
//        })
//        return rectAttributes
//    }
//
//}




class HorizontalLeftToRightPaddingCollectionLayout: UICollectionViewFlowLayout {
    
    var kEmotionCellNumberOfOneRow = 8
    var kEmotionCellRow = 3
    
    // 保存所有item
    fileprivate var attributesArr: [UICollectionViewLayoutAttributes] = []

    // MARK:- 重新布局
    override func prepare() {
        super.prepare()

        let itemWH: CGFloat = SCREEN_W / CGFloat(kEmotionCellNumberOfOneRow)

        // 设置itemSize
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal

        // 设置collectionView属性
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = true
        let insertMargin = (collectionView!.bounds.height - 3 * itemWH) * 0.5
        collectionView?.contentInset = UIEdgeInsets(top: insertMargin, left: 0, bottom: insertMargin, right: 0)



        var page = 0
        let itemsCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        for itemIndex in 0..<itemsCount {
            let indexPath = IndexPath(item: itemIndex, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            page = itemIndex / (kEmotionCellNumberOfOneRow * kEmotionCellRow)
            // 通过一系列计算, 得到x, y值
            let x = itemSize.width * CGFloat(itemIndex % Int(kEmotionCellNumberOfOneRow)) + (CGFloat(page) * SCREEN_W)
            let y = itemSize.height * CGFloat((itemIndex - page * kEmotionCellRow * kEmotionCellNumberOfOneRow) / kEmotionCellNumberOfOneRow)

            attributes.frame = CGRect(x: x + 100, y: y, width: itemSize.width, height: itemSize.height)
            // 把每一个新的属性保存起来
            attributesArr.append(attributes)
        }

    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var rectAttributes: [UICollectionViewLayoutAttributes] = []
        _ = attributesArr.map({
            if rect.contains($0.frame) {
                rectAttributes.append($0)
            }
        })
        return rectAttributes
    }

}
