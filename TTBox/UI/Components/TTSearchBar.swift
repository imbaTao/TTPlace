//
//  TTSearchBar.swift
//  TTNew
//
//  Created by Mr.hong on 2021/10/20.
//

import Foundation

class TTSearchBar: TTView {
    let searchIcon = UIImageView.init(image: R.image.ttTest())
    lazy var searchTextFiled: TTTextFiled = {
        let searchTextFiled = TTTextFiled.init(configure: self.config)

        //        init { (config) in
        //            config.textFont = .regular(12)
        //            config.maxTextCount = 30
        //            config.filterType = .apartEmoji
        //            config.placeholderText = "输入什么？"
        //        }
        return searchTextFiled
    }()

    private let config: TTTextFiledConfigure!
    init(searchIcon: UIImage? = nil, config: TTTextFiledConfigure) {
        self.config = config
        super.init(frame: .zero)

    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func makeUI() {
        super.makeUI()
        addSubviews([searchIcon, searchTextFiled])
        searchIcon.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(4)
            make.bottom.equalTo(-4)
            make.size.equalTo(24)
        }

        searchTextFiled.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(searchIcon.snp.right).offset(4)
            make.right.equalTo(-18)
        }

        // config
        backgroundColor = rgba(226, 227, 228, 1)
        cornerRadius = 8
    }

    // 变更搜索图片
    func changeSearchIcon(_ iconImage: UIImage) {
        searchIcon.image = iconImage
    }

}
