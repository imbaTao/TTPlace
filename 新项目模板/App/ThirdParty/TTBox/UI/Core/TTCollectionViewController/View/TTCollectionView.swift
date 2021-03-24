//
//  TTCollectionView.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/15.
//

import Foundation

class TTCollectionView: UICollectionView,TTAutoRefreshProtocol  {
    var headerRefreshEvent = PublishSubject<Int>()
    var footerRefreshEvent = PublishSubject<Int>()
    var state: TTAutoRefreshState = .neitherHeaderFooter  {
        didSet {
            refreshHeaderOrFooterState(self.state)
        }
    }
    
    // 代理必须牵到控制器上去,由控制器vm管理数据源
    var flowLayout: UICollectionViewFlowLayout!
    
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
    init(classTypes:[UICollectionViewCell.Type],flowLayout: UICollectionViewFlowLayout) {
        self.flowLayout = flowLayout
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        self.backgroundColor = .white
        self.refreshHeaderOrFooterState(.neitherHeaderFooter)
        _registCell(classTypes)
    }
    
    init(lineSpacing: CGFloat,interitemSpacing: CGFloat,classTypes:[UICollectionViewCell.Type],derection: UICollectionView.ScrollDirection)  {
        flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = derection
        // 滚动方向相同的间距为minimumLineSpacing  垂直的minimumInteritemSpacing
        flowLayout.minimumLineSpacing = lineSpacing
        flowLayout.minimumInteritemSpacing = interitemSpacing
        flowLayout.itemSize = CGSize.init(width: SCREEN_W, height: SCREEN_H)
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        _registCell(classTypes)
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        };
    }
    
    // 注册所需的cell
    func _registCell(_ classNames: [UICollectionViewCell.Type]) {
        let _ = classNames.map {
            register($0.self, forCellWithReuseIdentifier: String(describing: $0))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// collection组头
class CollectionReusableView: UICollectionReusableView {
    var reuseDisposeBag = DisposeBag()
    override func prepareForReuse() {
            super.prepareForReuse()
            reuseDisposeBag = DisposeBag()
    }
}


