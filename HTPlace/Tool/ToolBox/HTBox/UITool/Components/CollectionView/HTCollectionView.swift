//
//  HTCollectionView.swift
//  HTPlace
//
//  Created by Mr.hong on 2020/10/29.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation


class HTCollectionView: UICollectionView {
    // 代理必须牵到控制器上去,由控制器vm管理数据源
    var flowLayout: UICollectionViewFlowLayout!
    
    
    // 传类名，和layout
    init(classNames:[String],flowLayout: UICollectionViewFlowLayout) {
        self.flowLayout = flowLayout
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        self.backgroundColor = .white
        _registCell(classNames: classNames)
    }
    
    
    init(lineSpacing: CGFloat,interitemSpacing: CGFloat,classNames:[String])  {
        flowLayout = UICollectionViewFlowLayout.init()
        // 滚动方向相同的间距为minimumLineSpacing  垂直的minimumInteritemSpacing
        flowLayout.minimumLineSpacing = lineSpacing
        flowLayout.minimumInteritemSpacing = interitemSpacing
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        
        _registCell(classNames: classNames)
    }
    
    // 注册所需的cell
    func _registCell(classNames: [String]) {
        let _ = classNames.map {
            let cellClass = HTClassFromString(classNames: $0) as! UICollectionViewCell.Type
            self.register(cellClass, forCellWithReuseIdentifier: $0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// 底层通用Cell类
class HTCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
    }
}
