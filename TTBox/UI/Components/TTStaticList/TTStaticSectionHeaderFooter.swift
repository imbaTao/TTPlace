//
//  TTStaticSectionHeaderFooter.swift
//  EatWhat
//
//  Created by Mr.hong on 2021/4/12.
//

import Foundation

class TTStaticSectionHeader: TTView {

    lazy var mainLabel: UILabel = {
        var mainLabel = UILabel.regular(size: 12, textColor: .black, text: "组标题", alignment: .left)
        addSubview(mainLabel)
        mainLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview()
        }
        return mainLabel
    }()
    
    func changeLableInset(_ inset: CGFloat) {
        mainLabel.snp.remakeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.left.right.equalTo(safeAreaLayoutGuide).inset(inset)
            } else {
                make.left.right.equalTo(inset)
            }
            make.top.bottom.equalToSuperview()
        }
    }

    init(headerHeight: CGFloat,content: String = "",lableInset: CGFloat = 12) {
        super.init(frame: .zero)
        self.headerHeight = headerHeight
        self.mainLabel.text = content
        
        
        changeLableInset(lableInset)
        changeHeaderHeight(headerHeight)
    }
    
    func changeHeaderHeight(_ height: CGFloat) {
        snp.remakeConstraints { (make) in
            make.height.equalTo(headerHeight)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        super.makeUI()
        self.backgroundColor = .clear
    }

    var headerHeight: CGFloat = 12 {
        didSet {
            self.changeHeaderHeight(headerHeight)
        }
    }
}

class TTStaticSectionFooter: TTView {
    lazy var mainLabel: UILabel = {
        var mainLabel = UILabel.regular(size: 12, textColor: .black, text: "组标题", alignment: .left)
        addSubview(mainLabel)
        mainLabel.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.left.right.equalTo(self.safeAreaLayoutGuide).offset(12)
            } else {
                make.left.right.equalToSuperview().inset(12)
            }
            make.top.bottom.equalToSuperview()
        }
        return mainLabel
    }()
    
    override func makeUI() {
        super.makeUI()
        self.backgroundColor = .clear
    }

    var footerHeight: CGFloat = 10.0 {
        didSet {
            self.snp.remakeConstraints { (make) in
                make.width.equalTo(SCREEN_W)
                make.height.equalTo(footerHeight)
            }
        }
    }
    
    func changeLableInset(_ inset: CGFloat) {
        mainLabel.snp.remakeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.left.right.equalTo(self.safeAreaLayoutGuide).inset(inset)
            } else {
                make.left.right.equalToSuperview().inset(inset)
            }
            make.top.bottom.equalToSuperview()
        }
    }

}
