//
//  TTTableViewCell.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit
class TableViewCell: UITableViewCell {

    var cellDisposeBag = DisposeBag()

    var isSelection = false
    var selectionColor: UIColor? {
        didSet {
            setSelected(isSelected, animated: true)
        }
    }

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
    
  
    
    lazy var leftImageView: UIImageView = {
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

    lazy var rightImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()
    
    lazy var avatar: TTAvatar = {
        var avatar = TTAvatar()
        return avatar
    }()
    
    lazy var segementLine: UIView = {
        let view = UIView.color(rgba(223, 223, 223, 0.5))
        return view
    }()


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        backgroundColor = selected ? selectionColor : .clear
    }

    func makeUI() {
        layer.masksToBounds = true
        selectionStyle = .none
        backgroundColor = .clear
        updateUI()
        bindViewModel()
        stackView.backgroundColor = .clear
    }
    
    
    func updateUI() {
        setNeedsDisplay()
    }
    
    func bindViewModel() {
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        makeUI()
//        self.contentView.removeFromSuperview()
//        stackView.addArrangedSubview(self.contentView)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    // 复用的时候释放所有监控
    override func prepareForReuse() {
            super.prepareForReuse()
            cellDisposeBag = DisposeBag()
    }
}



class TTTableViewCell: TableViewCell {
    
    // 如果需要自动计算高度，就把内容视图添加到这个stackView上,并设置tabview自动计算高度
    
    // 内间距
    var edges: UIEdgeInsets = .zero
    {
        willSet {
            // 设置边距后更新
            containerView.snp.remakeConstraints { (make) in
                make.edges.equalTo(newValue)
            }
        }
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
