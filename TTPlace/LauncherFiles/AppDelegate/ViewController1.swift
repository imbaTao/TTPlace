//
//  ViewController1.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

//import UIKit
import Foundation
import RxSwift
import Alamofire
import SwiftyJSON
import Kingfisher
import RxCocoa

class ViewController: TTViewController {
    
}



//MARK: - 封装的UIControl
public class Controll: UIControl {
    
    convenience init(width: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        snp.makeConstraints { (make) in
            make.width.equalTo(width)
        }
    }
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        bindViewModel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        self.layer.masksToBounds = true
        updateUI()
    }
    
    func bindViewModel() {
        
    }
    func updateUI() {
        setNeedsDisplay()
    }
    
    func getCenter() -> CGPoint {
        return convert(center, from: superview)
    }
}



//MARK: - 根据约束自动管理size的view，添加视图时，请使用t_addSubViews
class TTAutoSizeView: View {
    // 里面只装container
    private let stackView = UIStackView()
    let containerView = UIView()
    
    // 内边距
    var padding = UIEdgeInsets.zero {
        didSet {
            stackView.snp.remakeConstraints { (make) in
                make.edges.equalTo(padding)
            }
        }
    }
    
    init(padding: UIEdgeInsets) {
        super.init(frame: .zero)
        self.padding = padding
        addSubview(stackView)
        stackView.addArrangedSubview(containerView)
        stackView.snp.makeConstraints { (make) in
            make.edges.equalTo(padding)
        }
    }
    
    // 添加子类
    func t_addSubViews(_ views: [UIView]) {
        containerView.addSubviews(views)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class TestCell : TTTableViewCell {
    override func makeUI() {
        super.makeUI()
        self.containerView.addSubviews([mainLabel])
        
        
        mainLabel.text = "12312312312"
        
        mainLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
            make.height.equalTo(30)
        }
    }
}

class ViewController1: TTTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.injected()
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tempView1 = UIView.fetchContainerViewWithRadius(radius: 8, color: .red,size: ttSize(246,49))
        let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! TestCell
        
        cell.containerView.addSubview(tempView1)
        tempView1.snp.makeConstraints { (make) in
//                        make.center.equalToSuperview()
            make.top.equalTo(cell.mainLabel.snp.bottom)
            make.left.equalToSuperview()
            make.height.equalTo(100)
//                        make.width.equalTo(300)
//                        make.bottom.equalToSuperview()
        }
        
        tableView.reloadRow(at: IndexPath.init(row: 0, section: 0), with: .none)
        
    }
    
    
    
    
    
    
    @objc func injected() {
        
        
        let tableView = TTTableView.init(frame: .zero)
        tableView.estimatedRowHeight = 88
        
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
            
        }
        
        
        tableView.register(cellWithClass: TestCell.self)

        
        
        Observable.just(["123123","123123","11232131231214"]).bind(to: tableView.rx.items) {(tableView,index,model) in
            let cell = tableView.dequeueReusableCell(withClass: TestCell.self)
            cell.mainLabel.text = model
            cell.backgroundColor = .random
            
            
            if index == 0 {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//
////                    self.view.addSubview(tempView1)
//
//
//
//
//                    tableView.reloadRow(at: IndexPath.init(row: index, section: 0), with: .none)
//                }
            }
         return cell
        }.disposed(by: rx.disposeBag)
        
//        view.removeSubviews()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        let container = UIView()
//        container.backgroundColor = .white
//        addSubview(container)
//
//        container.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.size.equalTo(ttSize(200, 64))
//        }
//
//        let titles = ["好评","中评","差评"]
//        var items = [TTButton]()
//        for index in 0..<3 {
//            let button = TTButton.init(text: titles[index], textColor: rgba(102, 102, 102, 1), font: .regular(12), iconImage: R.image.ttTest(), backGroundIconImage: nil, type: .iconOnTheTop, intervalBetweenIconAndText: 2, padding: .zero)
//
//            button.setImage(R.image.ttTest(), for: .normal)
////            button.setTitle("我是标题", for: <#T##UIControl.State#>)
//
//            button.setImage(R.image.ttTest1(), for: .selected)
//
//
//
//
//            container.addSubview(button)
//            button.backgroundColor = .white
//            items.append(button)
//        }
//
//        items.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 30, leadSpacing: 0, tailSpacing: 0)
//        // 反选设置
//        let selectedItem = Observable.from(items.map{ item in item.rx.controlEvent(.touchUpInside).map{item}}).merge()
//        for item in items {
//            selectedItem.map{$0 == item}.bind(to: item.rx.isSelected).disposed(by: rx.disposeBag)
//        }
//
//
////        button.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
////            print("点击了！！")
////        }).disposed(by: rx.disposeBag)
        
    }
}

extension TTButton {
  
}
