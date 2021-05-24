//
//  TTGridView.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/3/26.
//

import Foundation


class TTGridModel: HandyJSON {
    var content = ""
    var isSelected = false
    required init() {
    
    }
}


// 网格反选类都用这个类
class TTGridView: TTStackView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    // 网格对象
    var grid: TTCollectionView!
    
    
    var config = TTGridConfig()
    
    var cellClassTypes: [TTCollectionViewCell.Type]!
    
    // 当前选中的下标
    var currentIndex = 0
    private var firstSelected = false
    
    // 渲染cell的时候回调
    var renderCellBlock: ((_ cell: TTCollectionViewCell,_ indexPath: IndexPath) -> ())? {
        didSet {
            grid.reloadData()
        }
    }
    
    // 点击选中cell的回调
    var didSelectedCellBlock: ((_ cell: TTCollectionViewCell,_ indexPath: IndexPath) -> ())?
    
    
    // 数据模型，防止复用
    var data = [TTGridModel]()

    
    init(cellClassTypes: [TTCollectionViewCell.Type],_ configClosure: ((_ config: TTGridConfig) -> Void)?) {
        configClosure?(self.config)
        if let defaultSelectedIndex = self.config.defaultSelectedIndex {
            self.currentIndex = defaultSelectedIndex
        }
        for index in 0..<self.config.itemsCount {
            
            let model = TTGridModel()

            
            
            // 选中默认下标
            if index == self.config.defaultSelectedIndex {
                model.isSelected = true
            }
            
            // 添加数据源
            data.append(model)
        }
        
        self.cellClassTypes = cellClassTypes
        super.init(frame: .zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        super.makeUI()
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = config.rowInterval
        layout.minimumInteritemSpacing = config.columnInterval
        grid = TTCollectionView.init(classTypes: cellClassTypes!, flowLayout: layout)
        addArrangedSubview(grid)
        
        
        self.snp.makeConstraints { (make) in
            make.size.greaterThanOrEqualTo(0)
        }
        
        
        // config
        grid.dataSource = self
        grid.delegate = self
        grid.showsVerticalScrollIndicator = false
        grid.showsHorizontalScrollIndicator = false
        grid.isScrollEnabled = config.canScroll
        
        
    }
    
    // delegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: grid.cellClassTypes.first!, for: indexPath)
        cell.isSelected = false
        if config.defaultSelectedIndex != nil {
            if indexPath.row == config.defaultSelectedIndex! {
                cell.isSelected =  true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
                
                // 置空
                config.defaultSelectedIndex = nil
            }
        }
        
        renderCell(cell,indexPath)
        renderCellBlock?(cell,indexPath)
        return cell
    }
    
    func renderCell(_ outCell: UICollectionViewCell,_ indexPath: IndexPath) {
        if let cell = outCell as? TTCollectionViewCell {
            let model = data[indexPath.row]
            
            // 边框
            cell.borderColor = model.isSelected ? config.selectedBorderColor : config.unSelectedBorderColor
            cell.borderWidth = CGFloat(config.borderWidth)
            cell.backgroundColor = model.isSelected ? config.selectedBackGroundColor : config.unSelectedBackGroundColor
            
            
            
            if config.isEnabelSelectedColor {
                cell.mainLabel.textColor = model.isSelected ? config.selectedTitleColor : config.unselectedTitleColor
                cell.subLabel.textColor = model.isSelected ? config.selectedTitleColor : config.unselectedTitleColor
            }
            
            // 选中效果
            if model.isSelected {
                grid.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
            }
        }
    }
    
    // 返回网格数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return config.itemsCount
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TTCollectionViewCell {
            let model = data[indexPath.row]
            model.isSelected = true
            renderCell(cell, indexPath)
            currentIndex = indexPath.row
            didSelectedCellBlock?(cell,indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            let model = data[indexPath.row]
            model.isSelected = false
            renderCell(cell,indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return config.itemSize
    }
}





class TTGridConfig: NSObject {
    
    // 两种方式显示,1，用间距推算出itemSize,2,定好itemSize,算出interval
    
    // 行间距
    var rowInterval: CGFloat = 0
    
    // 列间距
    var columnInterval: CGFloat = 0
    
    // itemSize
    var itemSize = CGSize.zero
    
    // 网格一共几个元素
    var itemsCount = 0
    
//        // 一行最多几个
//        var rowMaxCount = 1
//
//        // 一列最多几个
//        var columnMaxCount = 1
    
    // 排列方式,默认横向排列换行
    var style = 0
    
    // 有默认选择就选中
    var defaultSelectedIndex: Int? = 0
    

    // 选中/未选择背景颜色
    var selectedBackGroundColor = UIColor.white
    var unSelectedBackGroundColor = UIColor.white
    
    // 选中/未选择内容标题颜色
    var selectedTitleColor = UIColor.black
    var unselectedTitleColor = rgba(153, 153, 153, 1)
    
    // 选中/未选择背景图
    var selectedBackGroundImage: UIImage?
    var unselectedBackGroundImage: UIImage?

    
    // 选中/未选择描边颜色
    var selectedBorderColor = UIColor.black
    var unSelectedBorderColor = UIColor.clear
    
    // 是否启用选中颜色
    var isEnabelSelectedColor = true
    
    // 描边宽度
    var borderWidth = 1.0
    
    // 是否可以滚动
    var canScroll = false
}


