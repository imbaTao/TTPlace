//
//  TTTableViewCell.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit

class TTTableViewCell: UITableViewCell {
    
    
    // 如果需要自动计算高度，就把内容视图添加到这个stackView上,并设置tabview自动计算高度
    lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    // 内间距
    var edges: UIEdgeInsets = .zero
    {
        willSet {
            // 设置边距后更新
            stackView.snp.updateConstraints { (make) in
                make.edges.equalTo(newValue)
            }
        }
    }
    

    lazy var leftImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()


    lazy var titleLabel: UILabel = {
        let view = UILabel.regular()
        return view
    }()
    

    lazy var detailLabel: UILabel = {
        
        let view = UILabel.regular()
//        view.font = view.font.withSize(12)
        
        
//        view.setPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
        return view
    }()

    lazy var secondDetailLabel: UILabel = {
        let view = UILabel.regular()
        return view
    }()

    lazy var attributedDetailLabel: YYLabel = {
        let view = YYLabel.regular(size: 16, text: "", textColor: .white, alignment: .left)
        return view
    }()

    lazy var rightImageView: UIImageView = {
        let view = UIImageView.empty()
        return view
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.removeFromSuperview()
        
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(self.contentView)
        setupCell()
    }
    
    func setupCell() {
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
