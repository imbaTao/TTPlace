//
//  TTStaticSectionHeaderFooter.swift
//  EatWhat
//
//  Created by Mr.hong on 2021/4/12.
//

import Foundation

class TTStaticSectionHeader: View {
    
    
    lazy var mainLabel: UILabel = {
        var mainLabel = UILabel.regular(size: 12, textColor: .black, text: "组标题", alignment: .left)
        addSubview(mainLabel)
        mainLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview()
        }
        return mainLabel
    }()
    
    override func makeUI() {
        super.makeUI()
        self.backgroundColor = .clear
    }
    
    
    var headerHeight: CGFloat = 10.0 {
        didSet {
            self.snp.remakeConstraints { (make) in
                make.width.equalTo(SCREEN_W)
                make.height.equalTo(headerHeight)
            }
        }
    }
}





class TTStaticSectionFooter: View {
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
}
