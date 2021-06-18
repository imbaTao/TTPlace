//
//  TTStaticRow.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/4/8.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

protocol TTStaticRowProtocol: AnyObject {
    // 子类写block
//    func update(_ config: (Self) -> ()) -> Self
    func asSelf() -> Self
}

extension TTStaticRowProtocol {
//    func update(_ config: (Self) -> ()) -> Self {
//        return self
//    }
    
    func asSelf() -> Self {
        return self
    }
}

class TTStaticRow: TTStackView ,TTStaticRowProtocol{
    
    // 变更行高
    var rowHeight: CGFloat = 44.0 {
        didSet {
            contentView.snp.remakeConstraints { (make) in
                make.width.equalTo(SCREEN_W)
                make.height.equalTo(rowHeight)
            }
        }
    }
 
    // 核心内容承载面板
    lazy var contentView: TTControll = {
        var contentView = TTControll()
        addArrangedSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_W)
            make.height.equalTo(44)
        }
        return contentView
    }()
    

    // 行的头部
    lazy var _header: TTStaticSectionHeader = {
        var header = TTStaticSectionHeader()
        insertArrangedSubview(header, at: 0)
        header.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_W)
            make.height.equalTo(12)
        }

        return header
    }()
    
    // 根据闭包设置header
    func header(_ headerConfig: ((TTStaticSectionHeader) -> Void)? = nil) -> Self {
        // 触发
        headerConfig?(_header)
        
        let _ = _header
        return self
    }
    
    // 行的尾部
    lazy var _footer: TTStaticSectionFooter = {
        var footer = TTStaticSectionFooter()
        addArrangedSubview(footer)
        footer.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_W)
            make.height.equalTo(12)
        }

        return footer
    }()
    
    // 根据闭包设置header
    func footer(_ footerConfig: (TTStaticSectionFooter) -> Void) -> Self {
        // 触发
        footerConfig(_footer)
        return self
    }
    
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()
    
    lazy var leftImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()

    lazy var mainLabel: UILabel = {
        let view = UILabel.regular(size: 15, textColor: .black, text: "主标题", alignment: .left)
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(12)
        }
        return view
    }()
    

    lazy var subLabel: UILabel = {
        let view = UILabel.regular(size: 15, textColor: .black, text: "副标题", alignment: .right)
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-12)
        }
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
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-12)
        }
        return view
    }()
    
    lazy var avatar: TTAvatar = {
        var avatar = TTAvatar()
        contentView.addSubview(avatar)
        avatar.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(12)
        }
        return avatar
    }()
    
    lazy var segementLine: UIView = {
        let view = UIView.color(rgba(223, 223, 223, 0.5))
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        return view
    }()
    
 
    
    
    //  核心内容，都用字符串去表示，取值时转换
    var value: String = "" {
        didSet {
           let _ = self.refreshUI?(self)
        }
    }
    
    // 更新UIBlock
    var refreshUI: ((TTStaticRow) -> Void)? = nil
    
    init(_ initializer: ((TTStaticRow) -> Void)? = nil) {
       super.init(frame: .zero)
        initializer?(self)
   }
   
   required init(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    
    override func makeUI() {
        super.makeUI()
        
    
        
        
        // config
        backgroundColor = .clear
        spacing = 0
        
    }
    
    
    override func updateUI() {
        super.updateUI()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI()
    }
    
    @discardableResult
    func selected(_ click: ((Self) -> ())?) -> Self {
        contentView.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self]  in guard let self = self else { return }
            click?(self)
        }).disposed(by: rx.disposeBag)
        return self
    }
    
    func configUI(_ block: ((TTStaticRow) -> ())?) -> Self {
         block?(self)
         return self
     }

}
