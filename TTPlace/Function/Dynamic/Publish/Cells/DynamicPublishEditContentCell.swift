//
//  DynamicPublishEditContentCell.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/24.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class TTPublishPhotoView: TTAutoSizeView {
    
    
    override func makeUI() {
        super.makeUI()
        
    }
    
    
    
    
    
    func creat(with items: [TTPublishPhotoViewModel]) {
        let item = TTPublishPhotoItem()
        
    }
}


class TTPublishPhotoItem: View {
    var picView = UIImageView()
    override func makeUI() {
        super.makeUI()
        addSubviews([picView])
        
        picView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    init(_ imageUrlStr: String? = nil) {
        super.init(frame: .zero)
        if let url = URL.init(string: imageUrlStr) {
            picView.setImageWith(url, placeholder: UIImage.init(color: .gray, size: .init(width: 100, height: 100)))
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class TTPublishPhotoViewModel: NSObject {
    var image: UIImage?
    var imageUrl: String?
    var index: Int = 0
}

















class DynamicPublishEditContentCell: TTTableViewCell {
    
    let inputTextView = TTTextView.init { (config) in
        config.placeholderText = "填写标题会有更多赞哦~"
        config.textColor = .black
        config.placeholderColor = rgba(187, 187, 187, 1)
        config.caretColor = .mainStyleColor
        config.maxTextCount = 200
        config.showTextCountTips = true
    }
    
    let banner = TTAddPhotoBanner()
    
    override func makeUI() {
        super.makeUI()
        addSubviews([inputTextView,banner])
        inputTextView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(banner.snp.top).offset(-19)
        }
         
        inputTextView.textCountTips.snp.remakeConstraints { (make) in
            make.right.equalTo(-12)
            make.bottom.equalToSuperview()
        }
       
        banner.snp.makeConstraints { (make) in
            make.top.equalTo(inputTextView.snp.bottom).offset(19)
            make.left.right.equalToSuperview().inset(inset)
            make.bottom.equalTo(-54)
            make.height.greaterThanOrEqualTo(115)
        }
        
        backgroundColor = rgba(247, 247, 248, 1)
    }
    
    override func bind(to viewModel: TableViewCellViewModel) {
        super.bind(to: viewModel)
        guard let viewModel = viewModel as? DynamicPublishEditContentCellViewModel else {
            return
        }
        
        // 绑定内容关系
        viewModel.title.asDriver().drive(self.inputTextView.rx.text).disposed(by: cellDisposeBag)
        
        // 双向绑定
        self.inputTextView.rx.text.orEmpty.asDriver().drive(viewModel.title).disposed(by: cellDisposeBag)
    }
}
