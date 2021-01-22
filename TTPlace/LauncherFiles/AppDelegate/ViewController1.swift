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


class ViewController: TTViewController {
    
}

class ViewController1: BaseViewController,UINavigationControllerDelegate {
    
    
    var tableView = TTTableView.init(cellClassNames: ["TTTableViewCell"], style: .grouped)
    
    var tempView1 = UIImageView()
    
    var lable = UILabel.regular(size: 15, textColor: .black)

    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = .darkGray

    }
    
    @objc func injected() {

    }
}

