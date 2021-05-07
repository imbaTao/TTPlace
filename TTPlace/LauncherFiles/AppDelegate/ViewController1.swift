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
import HandyJSON
import SwiftyJSON


class ViewController: TTViewController {
    
}

class TTButton1: UIButton {
    
}



class ViewController1: ViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)
    }
    
    
    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    
   @objc func configureView()  {
        view.removeAllSubviews()
    
       let alert = TTAlert2.init(customView: TTContentView()) { (view) in
            // 点击事件在这里写
            
        } click: { (index) in
            
        }
    


//        let alert =(cu) { (main) in
            
          
            
            // 点击了某个按钮事件
//            main.button.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
//                main.click(0)
//            }).disposed(by: rx.disposeBag)
//        } click: { (index) in
//            // 所有的点击事件
//            switch index {
//                case 0:
//                    break
//            default:
//                break
//            }
//        }
//    }
}


class TTContentView: View {
    
}


// 思想是灵活，多种样式，方便自定义UI
class TTAlert2<T: View>: View {
    // 背板视图
    var backgroudView = UIView()
    
    // 内容主视图,默认装一个UITextView
    var contentView = TTAutoSizeView.init(padding: .zero)
    var customView: T!
    
    // 标题
    lazy var titleLable: UILabel = {
        var titleLable = UILabel.regular(size: 15, textColor: .black)
        contentView.t_addSubViews([titleLable])
        return titleLable
    }()
    
    // 关闭按钮
    lazy var closeButton: UIButton = {
        var  closeButton = UIButton.iconImage(UIImage.init(color: .red, size: .init(width: 30, height: 30)))
        contentView.t_addSubViews([closeButton])
        closeButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            
            // close默认就是隐藏事件,想监听就在-1控制流里写
            self.click(-2)
            self.dissMiss()
        }).disposed(by: rx.disposeBag)
        return closeButton
    }()
    
    // 主按钮
    lazy var mainButton: UIButton = {
        var  mainButton = UIButton.iconImage(UIImage.init(color: .red, size: .init(width: 30, height: 30)))
        contentView.t_addSubViews([mainButton])
        return mainButton
    }()
    
    
    
    // 默认最小尺寸
    var defalultMinSize = ttSize(260, 130)
    
    // 默认最大尺寸
    var defalultMaxSize = ttSize(260, 359)
        
    
    override func makeUI() {
        super.makeUI()
        addSubviews([backgroudView,contentView])
        backgroudView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.size.equalTo(defalultMinSize)
            make.center.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        self.mainContentTextView.setContentOffset(.zero, animated: false)
        
       
    }
    
    
    init(_ parrentView: UIWindow? = UIApplication.shared.keyWindow,customView: T,_ configUIBlock:(_ configView: T) -> (),click:@escaping (_ index: Int)->()) {
        super.init(frame: .zero)
        self.customView = customView
        self.click = click
        self.isHidden = true
        // 外部设置UI
        configUIBlock(self.customView)
    

        
        // 默认直接show
        show()
    }
    
    
    var click: ((_ index: Int) -> ())!
        
    
    
    /// MARK: - 显示
    func show() {
        isHidden = false
        removeFromSuperview()
    }
    
    /// MARK: - 隐藏
    func dissMiss() {
        isHidden = true
        removeFromSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //  创建时传入标题，内容，标题
//    @discardableResult
//    class func show(_ parrentView: UIWindow?,click:@escaping (_ index: Int)->()) -> TTAlert2 {
//        let alert = TTAlert2()
//
//        return alert
//    }
    
    // 隐藏操作
    class func hiddenAction(alert: TTAlert) {
        alert.isHidden = true
        alert.removeAllSubviews()
        alert.removeFromSuperview()
    }
    
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        
        let lableSize  = self.titleLable
        print("尺寸为\(lableSize)")
        
        return super.sizeThatFits(size)
    }
}




extension UIView {
    
    var inset: CGFloat {
        return 12
    }
    
}

extension UIColor {
    // 性别颜色， 男1，女2
    class func genderColor(_ gender: Int = 1) -> UIColor {
        if gender == 1 {
            return rgba(124, 200, 255, 1)
        }else {
            return rgba(255, 127, 182, 1)
        }
    }
    
    // 主要文本颜色
    static var mainStyleColor: UIColor {
        return #colorLiteral(red: 0.5607843137, green: 0.2509803922, blue: 0.9647058824, alpha: 1)
    }
    
    // 主要文本颜色
    static var mainTextColor: UIColor {
        return rgba(51, 51, 51, 1)
    }
    
    // 主要文本颜色2
    static var mainTextColor2: UIColor {
        return rgba(102, 102, 102, 1)
    }
    
    
}
