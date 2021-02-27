//
//  TTStaticList.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/4.
//

import Foundation

//MARK: - 静态列表地
class TTStaticList: UIScrollView {
    var mainStackView = TTStackView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        // config
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.alignment = .center
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        showsVerticalScrollIndicator = false
    }
    
    
    // 添加items
    func appendItems(items: [TTStaticListSectionItem]) {
        mainStackView.addArrangedSubviews(items)
    }
    
    // 插入items
    func insertItem(item: TTStaticListSectionItem,index: Int) {
        mainStackView.insertArrangedSubview(item, at: index)
    }
    
    // 移除items
    func removeItems(items: [TTStaticListSectionItem]) {
        for item in items {
            mainStackView.removeArrangedSubview(item)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// 静态列表item
class TTStaticListSectionItem: UIControl {
    lazy var leftImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()


    lazy var mainLabel: UILabel = {
        let view = UILabel.regular()
        return view
    }()
    

    lazy var subLabel: UILabel = {
        
        let view = UILabel.regular()
//        view.font = view.font.withSize(12)
        
        
//        view.setPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
        return view
    }()

    lazy var secondSubLabel: UILabel = {
        let view = UILabel.regular()
        return view
    }()

    lazy var attributeLabel: YYLabel = {
        let view = YYLabel.regular(size: 16, text: "", textColor: .white, alignment: .left)
        return view
    }()

    lazy var rightImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()
    
    lazy var avatar: TTAvatar = {
        var avatar = TTAvatar()
        return avatar
    }()
    
    lazy var segementLine: UIView = {
        let view = UIView.color(rgba(223, 223, 223, 0.5))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        setupItem()
        
    }
    
    
    // 点击事件,记得weak self
    var itemclick: () ->() = {
        
    }
    
    func setupItem() {
//        self.isUserInteractionEnabled = false
        rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
            self?.itemclick()
        }).disposed(by: rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

