//
//  TTCollectionViewCell.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/9.
//

import UIKit

class TTCollectionViewCell: UICollectionViewCell {
    var cellDisposeBag = DisposeBag()
    
    var edges = UIEdgeInsets.zero
    
    var isSelection = false
    
    lazy var containerView: View = {
        let containerView = View()
        containerView.backgroundColor = .clear
        stackView.addArrangedSubview(containerView)
        containerView.snp.makeConstraints({ (make) in
            make.size.lessThanOrEqualToSuperview()
        })
        return containerView
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView.empty()
        containerView.insertSubview(view, at: 0)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return view
    }()

    lazy var stackView: StackView = {
        let subviews: [UIView] = []
        let stackView = StackView(arrangedSubviews: subviews)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        
        

        
        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.size.lessThanOrEqualToSuperview()
        }
        return stackView
    }()
    
  
    
    lazy var avatar: TTAvatar = {
        var avatar = TTAvatar()
        return avatar
    }()
    

    lazy var leftImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()
    
    lazy var centerImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()
    
    lazy var rightImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()


    lazy var mainLabel: UILabel = {
        let view = UILabel.regular()
        return view
    }()
    

    lazy var subLabel: UILabel = {
        
        let view = UILabel.regular()
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

  
    lazy var segementLine: UIView = {
        let view = UIView.color(rgba(223, 223, 223, 0.5))
        return view
    }()
    
    

    func bind(to viewModel: TTCollectionViewCellViewModel) {
        
        // 赋值，没有值就隐藏
        viewModel.mainContent.asDriver().drive(mainLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.mainContent.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(mainLabel.rx.isHidden).disposed(by: rx.disposeBag)

        // 是子内容
        viewModel.subContent.asDriver().drive(subLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.subContent.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(subLabel.rx.isHidden).disposed(by: rx.disposeBag)

        //  第二条子内容
        viewModel.secondSubContent.asDriver().drive(secondSubLabel.rx.text).disposed(by: rx.disposeBag)
        viewModel.secondSubContent.asDriver().replaceNilWith("").map { $0.isEmpty }.drive(secondSubLabel.rx.isHidden).disposed(by: rx.disposeBag)

        

//        viewModel.hidesDisclosure.asDriver().drive(rightImageView.rx.isHidden).disposed(by: rx.disposeBag)

        // 头像
        viewModel.avatarImage.asDriver().filterNil()
            .drive(avatar.rx.image).disposed(by: rx.disposeBag)
        viewModel.avatarImageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
            .drive(avatar.rx.imageURL).disposed(by: rx.disposeBag)
        viewModel.avatarImageUrl.asDriver().filterNil()
            .drive(onNext: { [weak self] (url) in
                self?.avatar.hero.id = url
            }).disposed(by: rx.disposeBag)
        
        
        // 左侧图片
        viewModel.leftImage.asDriver().filterNil()
            .drive(leftImageView.rx.image).disposed(by: rx.disposeBag)
        viewModel.leftImageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
            .drive(leftImageView.rx.imageURL).disposed(by: rx.disposeBag)
        viewModel.leftImageUrl.asDriver().filterNil()
            .drive(onNext: { [weak self] (url) in
                self?.leftImageView.hero.id = url
            }).disposed(by: rx.disposeBag)
        
        
        // 中心图片
        viewModel.centerImage.asDriver().filterNil()
            .drive(centerImageView.rx.image).disposed(by: rx.disposeBag)
        viewModel.centerImageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
            .drive(centerImageView.rx.imageURL).disposed(by: rx.disposeBag)
        viewModel.centerImageUrl.asDriver().filterNil()
            .drive(onNext: { [weak self] (url) in
                self?.centerImageView.hero.id = url
            }).disposed(by: rx.disposeBag)
        
        
        // 右侧图片
        viewModel.rightImage.asDriver().filterNil()
            .drive(rightImageView.rx.image).disposed(by: rx.disposeBag)
        viewModel.rightImageUrl.map { $0?.url }.asDriver(onErrorJustReturn: nil).filterNil()
            .drive(rightImageView.rx.imageURL).disposed(by: rx.disposeBag)
        viewModel.rightImageUrl.asDriver().filterNil()
            .drive(onNext: { [weak self] (url) in
                self?.rightImageView.hero.id = url
            }).disposed(by: rx.disposeBag)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        
    }
    
    
    // 复用的时候释放所有监控
    override func prepareForReuse() {
            super.prepareForReuse()
            cellDisposeBag = DisposeBag()
    }
}

