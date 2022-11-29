//
//  TTLabelExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation

extension UILabel {
    //MARK: - 常用regelar字号
    class func regular(
        size: CGFloat = 16, textColor: UIColor = .black, text: String = "",
        alignment: NSTextAlignment = .left
    ) -> UILabel {
        let label = UILabel.fetchLabel()
        label.textColor = textColor
        label.font = UIFont.regular(size)
        label.textAlignment = alignment
        label.text = text
        label.numberOfLines = 1
        return label
    }

    class func regular(
        size: CGFloat = 16, textColor: UIColor = .black, text: String = "",
        cornerRadius: CGFloat = 0, backgroundColor: UIColor = .clear,
        alignment: NSTextAlignment = .left, numberOfline: Int = 1
    ) -> UILabel {
        let label = UILabel.regular(
            size: size, textColor: textColor, text: text, alignment: alignment)
        label.numberOfLines = numberOfline
        label.backgroundColor = backgroundColor
        label.numberOfLines = numberOfline
        if cornerRadius > 0 {
            label.cornerRadius = cornerRadius
        }
        return label
    }

    //MARK: - 常用mediu字号
    class func medium(size: CGFloat = 16, textColor: UIColor = .black, text: String = "") -> UILabel
    {
        let label = UILabel.medium(
            size: size, textColor: textColor, text: text, backgroundColor: .clear, alignment: .left,
            numberOfline: 1)
        return label
    }

    class func medium(
        size: CGFloat = 16, textColor: UIColor = .black, text: String = "",
        backgroundColor: UIColor = .clear, alignment: NSTextAlignment = .left, numberOfline: Int = 1
    ) -> UILabel {
        let label = UILabel.fetchLabel()
        label.textColor = textColor
        label.font = UIFont.medium(size)
        label.textAlignment = alignment
        label.text = text
        label.numberOfLines = numberOfline
        label.backgroundColor = backgroundColor
        return label
    }

    //MARK: - 常用bold字号
    class func bold(
        size: CGFloat = 16, textColor: UIColor = .black, text: String = "",
        backgroundColor: UIColor = .clear, alignment: NSTextAlignment = .left, numberOfline: Int = 1
    ) -> UILabel {
        let label = UILabel.fetchLabel()
        label.textColor = textColor
        label.font = UIFont.bold(size)
        label.textAlignment = alignment
        label.text = text
        label.numberOfLines = numberOfline
        label.backgroundColor = backgroundColor
        return label
    }

    // 直接配置一个lable
    func config(
        font: UIFont = UIFont.regular(16), textColor: UIColor = .black, text: String = "",
        backgroundColor: UIColor = .clear, alignment: NSTextAlignment = .left, numberOfline: Int = 1
    ) {
        self.textColor = textColor
        self.font = font
        self.textAlignment = alignment
        self.numberOfLines = numberOfline
        self.backgroundColor = backgroundColor
        if text.isNotEmpty {
            self.text = text
        }
    }

    func config(font: UIFont = UIFont.regular(16), textColor: UIColor = .black) {
        self.config(font: font, textColor: textColor, text: "", alignment: .left, numberOfline: 1)
    }

    // 通用初始化方法
    class func fetchLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }
}

extension UILabel {
    // 添加左侧或者右侧的小图
    func addLeftAndRightImage(
        _ name: String = "", interval: CGFloat = 0, leftInterval: CGFloat = 0,
        rightInterval: CGFloat = 0, leftImageName: String = "", rightImageName: String = ""
    ) {
        for index in 0..<2 {

            if index == 0 {
                let imageView = UIImageView.name(leftImageName.count > 0 ? leftImageName : name)
                addSubview(imageView)
                imageView.snp.makeConstraints { (make) in
                    make.right.equalTo(self.snp.left).offset(
                        leftInterval > 0 ? -leftInterval : -interval)
                    make.centerY.equalToSuperview()
                }
            } else {
                let imageView = UIImageView.name(rightImageName.count > 0 ? rightImageName : name)
                addSubview(imageView)
                imageView.snp.makeConstraints { (make) in
                    make.left.equalTo(self.snp.right).offset(
                        rightInterval > 0 ? rightInterval : interval)
                    make.centerY.equalToSuperview()
                }
            }
        }
    }

    // 添加左侧的小图
    func addLeftImage(image: UIImage, interval: CGFloat = 0.0) {
        let imageView = UIImageView.init(image: image)
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.left).offset(-interval)
            make.centerY.equalToSuperview()
        }
    }

    // 添加,垂直居中的横线,inteval居中偏移量
    func addCenterYLine(
        color: UIColor, width: CGFloat = hor(92), height: CGFloat = 1, inteval: CGFloat = hor(5)
    ) {

        //        self.clipsToBounds = false
        //        self.layer.masksToBounds = false

        var leftAndRightEdge: CGFloat = 0
        if self.text?.count ?? 0 > 0 {

            let attText = NSMutableAttributedString.init(string: self.text ?? "")
            //            attText.font = self.font

            //            if let textWidth = YYTextLayout.init(container: YYTextContainer.init(size: ttSize(SCREEN_W, 300)), text: NSAttributedString.init(string: self.text ?? ""))?.textBoundingSize.width  {
            //
            //                debugPrint(textWidth)
            //                 leftAndRightEdge = (SCREEN_W - textWidth - width * 2 - inteval * 2 ) / 2
            //            }
        }

        for index in 0..<2 {
            let lineView = UIView.init()
            lineView.backgroundColor = color
            self.addSubview(lineView)

            if index == 0 {
                lineView.snp.makeConstraints { (make) in
                    make.centerY.equalTo(self)
                    make.width.equalTo(width)
                    make.left.equalTo(leftAndRightEdge)
                    make.height.equalTo(height)
                }
            } else {
                lineView.snp.makeConstraints { (make) in
                    make.centerY.equalTo(self)
                    make.width.equalTo(width)
                    make.right.equalTo(-leftAndRightEdge)
                    make.height.equalTo(height)
                }
            }
        }
    }
    //    // 添加,垂直居中的横线,inteval居中偏移量
    //    func addCenterYLine(color: UIColor,width: CGFloat = hor(92),height: CGFloat = 1,inteval: CGFloat = hor(5)) {
    //
    ////        self.clipsToBounds = false
    ////        self.layer.masksToBounds = false
    //
    //
    //
    //        var leftAndRightEdge: CGFloat = 0
    //        if self.text?.count ?? 0 > 0 {
    //
    //            let attText = NSMutableAttributedString.init(string: self.text ?? "")
    ////            attText.font = self.font
    //
    ////            if let textWidth = YYTextLayout.init(container: YYTextContainer.init(size: ttSize(SCREEN_W, 300)), text: NSAttributedString.init(string: self.text ?? ""))?.textBoundingSize.width  {
    ////
    ////                debugPrint(textWidth)
    ////                 leftAndRightEdge = (SCREEN_W - textWidth - width * 2 - inteval * 2 ) / 2
    ////            }
    //        }
    //
    //        for index in 0..<2 {
    //            let lineView = UIView.init()
    //            lineView.backgroundColor = color
    //            self.addSubview(lineView)
    //
    //            if index == 0 {
    //                lineView.snp.makeConstraints { (make) in
    //                    make.centerY.equalTo(self)
    //                    make.width.equalTo(width)
    //                    make.left.equalTo(leftAndRightEdge)
    //                    make.height.equalTo(height)
    //                }
    //            }else {
    //                lineView.snp.makeConstraints { (make) in
    //                    make.centerY.equalTo(self)
    //                    make.width.equalTo(width)
    //                    make.right.equalTo(-leftAndRightEdge)
    //                    make.height.equalTo(height)
    //                }
    //            }
    //        }
    //    }

}
extension UILabel {
    func changeRowText(_ text: String, maxWidth: CGFloat) {
        var sumWidth: CGFloat = 0
        let chars = text.map { (char) -> Character in
            let charWidth = "\(char)".textWidth(font: font, height: 999)
            if charWidth + sumWidth < maxWidth {
                sumWidth += charWidth
                return char
            } else {
                // 重置长度
                sumWidth = 0
                return .init("\n")
            }
        }
        self.text = .init(chars)
    }
}
