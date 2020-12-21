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


// 底层通用Cell类
class TTCollectionViewCell: UICollectionViewCell {
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



// 第二层默认基类
class DefaultCollectionViewCell: CollectionViewCell {
    
}



class CollectionViewCell: UICollectionViewCell {
    
    var edges = UIEdgeInsets.zero
    
    lazy var containerView: UIView = {
        var containerView = UIView()
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(edges)
        }
        return containerView
    }()
    
    var cellDisposeBag = DisposeBag()
    
    func makeUI() {
        self.layer.masksToBounds = true
        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }
    
    func bind(to viewModel: CollectionViewCellViewModel) {

    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}


class DefaultCollectionViewCellViewModel: CollectionViewCellViewModel {
    let title = BehaviorRelay<String?>(value: nil)
    let detail = BehaviorRelay<String?>(value: nil)
    let secondDetail = BehaviorRelay<String?>(value: nil)
    let attributedDetail = BehaviorRelay<NSAttributedString?>(value: nil)
    let image = BehaviorRelay<UIImage?>(value: nil)
    let imageUrl = BehaviorRelay<String?>(value: nil)
    let badge = BehaviorRelay<UIImage?>(value: nil)
    let badgeColor = BehaviorRelay<UIColor?>(value: nil)
    let hidesDisclosure = BehaviorRelay<Bool>(value: false)
}


class CollectionViewCellViewModel: NSObject {

}

