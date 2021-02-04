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

// 先封装轮播图
class ViewController1: TTTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseTabbar()?.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let ca = iCarousel()
    }
    
    @objc func injected() {
        
    }
}


/// 普通轮播图
//class TTNormalCarousel: TTc {
//
//}

class TTNormalCarouselConfig {
    
}
