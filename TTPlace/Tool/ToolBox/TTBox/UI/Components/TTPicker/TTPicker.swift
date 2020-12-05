//
//  TTPicker.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/2.
//

import UIKit


class TTPickerToolBar: UIView {
    lazy var leftButton: UIButton = {
        var leftButton = UIButton.title(title: "取消", titleColor: .gray, font: .regular(18))
        addSubview(leftButton)
        leftButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(hor(12))
        }
        return leftButton
    }()
    
    lazy var rightButton: UIButton = {
        var rightButton = UIButton.title(title: "确定", titleColor: .red, font: .regular(18))
        addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(hor(-10))
        }
        return rightButton
    }()
    
    // 标题
    lazy var title: UILabel = {
        var title = UILabel.regular(size: 16, textColor: .black, text: "pickerView标题", alignment: .center)
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        
        }
        return title
    }()
}

class TTPicker: UIPickerView {

    // 标题行
    lazy var toolBar: UIView = {
        var toolBar = UIView()
        return toolBar
    }()
    
    private var segmentLineWidth = hor(260)
    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//
//    }

    convenience init(segmentLineWidth: CGFloat) {
        self.init(frame: .zero)
        self.segmentLineWidth = segmentLineWidth
    }

    
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for item in self.subviews {
            
            if  item.height < 60 {
                item.backgroundColor = .clear
                
                
                // 顶部线条
                let topLine = UIView.color(rgba(238, 235, 244, 1))
                item.addSubview(topLine)
                topLine.snp.makeConstraints { (make) in
                    make.top.equalTo(0)
                    make.width.equalTo(segmentLineWidth)
                    make.centerX.equalToSuperview()
                    make.height.equalTo(1)
                }
            
                
                // 地部线条
                let bottomLine = UIView.color(rgba(238, 235, 244, 1))
                item.addSubview(bottomLine)
                bottomLine.snp.makeConstraints { (make) in
                    make.bottom.equalTo(0)
                    make.width.equalTo(segmentLineWidth)
                    make.height.equalTo(1)
                    make.centerX.equalToSuperview()
                }
                
                break
            }
        }
    }

}
