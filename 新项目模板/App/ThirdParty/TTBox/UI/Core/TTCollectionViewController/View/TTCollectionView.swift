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
    var refreshFinish = ReplaySubject<(TTAutoRefreshState)>.create(bufferSize: 1)
    //  头部刷新结束事件
    var headerEndRefreshEvent =  PublishSubject<()>()
    
    //  尾部刷新结束事件
    var footerEndRefreshEvent = PublishSubject<()>()
    
    var refreshState: TTAutoRefreshState = .neitherHeaderFooter  {
        willSet {
            refreshHeaderOrFooterState(newValue,self.refreshState)
        }
    }
    
    // 代理必须牵到控制器上去,由控制器vm管理数据源
    var flowLayout: UICollectionViewFlowLayout!
    
    // 储存注册过的cell的类型
    var cellClassTypes = [TTCollectionViewCell.Type]()
    
    init() {
        super.init(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        makeUI()
    }
    
    func makeUI() {
        self.layer.masksToBounds = true
        self.backgroundColor = .clear
    }
    
    
    func updateUI() {
        setNeedsDisplay()
    }
    
    // 传类名，和layout
    init(classTypes:[TTCollectionViewCell.Type],flowLayout: UICollectionViewFlowLayout) {
        self.flowLayout = flowLayout
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        self.backgroundColor = .white
        
        // 基类默认不带刷新头\尾
        self.refreshHeaderOrFooterState(.neitherHeaderFooter, .neitherHeaderFooter)
        _registCell(classTypes)
        makeUI()
    }
    
    init(lineSpacing: CGFloat,interitemSpacing: CGFloat,classTypes:[TTCollectionViewCell.Type],derection: UICollectionView.ScrollDirection)  {
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
        makeUI()
    }
    
    // 注册所需的cell
    func _registCell(_ classNames: [TTCollectionViewCell.Type]) {
        let _ = classNames.map {
            register($0.self, forCellWithReuseIdentifier: String(describing: $0))
        }
        self.cellClassTypes = classNames
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


