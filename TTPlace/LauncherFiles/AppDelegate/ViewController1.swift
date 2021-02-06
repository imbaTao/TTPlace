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
import TTThirdParityOC

class ViewController: TTViewController {

}

class MyCell: UITableViewCell {
    
    let autoSizeView = TTAutoSizeView.init(padding: .zero)
    let testView = UIView()
    let testView2 = UIView()
    let testView3 = UIView()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // 添加自适应撑大视图
        autoSizeView.backgroundColor = .random
        contentView.addSubview(autoSizeView)
        
        //  天机
        autoSizeView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }



        testView.backgroundColor = .red

      
        testView2.backgroundColor = .green

        
        
   
//                autoSizeView.t_addSubViews([testView])
//        testView.backgroundColor = .random
//                testView.snp.makeConstraints { (make) in
////                    make.edges.equalToSuperview()
////                    make.centerY.equalToSuperview()
//                    make.top.equalToSuperview()
//                    make.bottom.equalToSuperview()
//                    make.size.equalTo(ttSize(200))
//                    make.left.equalTo(30)
//                }
        

        autoSizeView.t_addSubViews([testView,testView2,testView3])

        testView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(30)
            make.bottom.equalTo(testView3.snp.top)
        }
        

        testView2.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-10)
            make.width.equalTo(10)
        }
        
        
        testView3.snp.makeConstraints { (make) in
            make.left.equalTo(110)
            make.top.equalTo(testView.snp.bottom)
            make.size.equalTo(120)
            make.bottom.equalToSuperview()
        }
        
        testView3.isHidden = true
        testView3.backgroundColor = .orange
    }
    

    


    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
           
           
}


// 先封装轮播图
class ViewController1: TTTableViewController, UITableViewDataSource, UITableViewDelegate {
//    let testButton =   TTButton.init(text: "洪1234", textColor: .black, font: .regular(17), type: .justText, intervalBetweenIconAndText: 10, padding: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        re()
        
      
        
//        testButton.backgroundColor = .orange
//        addSubview(testButton)
//        testButton.snp.makeConstraints { (make) in
////            make.size.equalTo(100)
//            make.center.equalToSuperview()
//        }
//
//        testButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
//            self!.testButton.titleLable.text = "123120398123908129038103890"
//        }).disposed(by: rx.disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
    }

    @objc func injected() {
      re()
        
    }
    
    func re() {
        self.view.removeAllSubviews()
        
        tableView = TTTableView.init(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellWithClass: MyCell.self)
        addSubview(tableView)
        tableView.estimatedRowHeight = 300
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        

    }
    

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MyCell.self)
        
        if indexPath.row == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                cell.testView3.isHidden = false
            }
        }
        cell.backgroundColor = .random
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
        
}


