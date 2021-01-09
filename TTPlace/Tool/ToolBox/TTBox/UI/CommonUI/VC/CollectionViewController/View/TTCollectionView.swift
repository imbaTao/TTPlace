//
//  TTCollectionView.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/15.
//

import Foundation


class TTCollectionView: UICollectionView {
    
    // 代理必须牵到控制器上去,由控制器vm管理数据源
    var flowLayout: UICollectionViewFlowLayout!
    
    // 类名
    var classNames = [String]()
    
    init() {
        super.init(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        makeUI()
    }
    
    func makeUI() {
        self.layer.masksToBounds = true
        self.backgroundColor = .clear
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
    
    // 传类名，和layout
    init(classNames:[String],flowLayout: UICollectionViewFlowLayout) {
        self.flowLayout = flowLayout
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        self.backgroundColor = .white
        
        _registCell(classNames: classNames)
    }
    
    
    init(lineSpacing: CGFloat,interitemSpacing: CGFloat,classNames:[String],derection: UICollectionView.ScrollDirection)  {
        flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = derection
        // 滚动方向相同的间距为minimumLineSpacing  垂直的minimumInteritemSpacing
        flowLayout.minimumLineSpacing = lineSpacing
        flowLayout.minimumInteritemSpacing = interitemSpacing
        flowLayout.itemSize = CGSize.init(width: SCREEN_W, height: SCREEN_H)
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        _registCell(classNames: classNames)
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        };
    }
    
    // 注册所需的cell
    func _registCell(classNames: [String]) {
        var classNamesArray = classNames
        
        if !classNamesArray.contains("TTCollectionViewCell") {
            classNamesArray.append("TTCollectionViewCell")
        }
        let _ = classNamesArray.map {
            let cellClass = TTClassFromString(classNames: $0) as! UICollectionViewCell.Type
            self.register(cellClass, forCellWithReuseIdentifier: $0)
        }
        
        // 赋值Cell类名数组
        self.classNames =  classNamesArray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




class CollectionReusableView: UICollectionReusableView {
    var reuseDisposeBag = DisposeBag()
    
    
    override func prepareForReuse() {
            super.prepareForReuse()
            reuseDisposeBag = DisposeBag()
    }
}


