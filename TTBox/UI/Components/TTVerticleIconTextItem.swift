//
//  TTVerticleIconTextItem.swift
//  TTNew
//
//  Created by Mr.hong on 2021/10/17.
//

import Foundation

class TTVerticleIconTextItem: TTAutoSizeView {
    let icon = UIImageView.init()
    let contentLabel = UILabel.regular(
        size: 12, textColor:.black, text: "", alignment: .center)

    init(
        iconImage: UIImage?, content: String, spaceBetwenIconText: CGFloat,
        iconTopOffSet: CGFloat = 0.0, iconSize: CGSize
    ) {
        super.init()
        t_addSubViews([icon, contentLabel])

        icon.image = iconImage
        contentLabel.text = content

        icon.snp.makeConstraints { (make) in
            make.top.equalTo(iconTopOffSet)
            make.centerX.equalToSuperview()
            make.size.equalTo(iconSize).priority(.required)
        }

        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(spaceBetwenIconText)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.greaterThanOrEqualTo(icon).priority(.required)
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
