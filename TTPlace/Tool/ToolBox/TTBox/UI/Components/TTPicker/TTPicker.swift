//
//  TTPicker.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/2.
//

import UIKit

class TTPicker: UIPickerView {

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
                    make.width.equalTo(hor(260))
                    make.centerX.equalToSuperview()
                    make.height.equalTo(1)
                }
            
                
                // 地部线条
                let bottomLine = UIView.color(rgba(238, 235, 244, 1))
                item.addSubview(bottomLine)
                bottomLine.snp.makeConstraints { (make) in
                    make.bottom.equalTo(0)
                    make.width.equalTo(hor(260))
                    make.height.equalTo(1)
                    make.centerX.equalToSuperview()
                }
                
                break
            }
        }
    }

}
