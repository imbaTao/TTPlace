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



extension CGSize {
    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
}


// 根据宽高设置尺寸
func sdLandSize(_ width: CGFloat,_ height: CGFloat) -> CGSize {
    let muti = SCREEN_H / 375.0
    let heightValue = muti * height
    let widthValue = heightValue * width / height
    return CGSize.init(width: widthValue, height: heightValue)
}


class ViewController: TTViewController {
    
}

class ViewController1: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

     
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)
        configureView()
        

        
    }
    
    
    


    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
        view.removeAllSubviews()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = true
        

        
        let tempView1 = UIView.fetchContainerViewWithRadius(radius: 8, color: .red,size: ttSize(246,49))
        self.view.addSubview(tempView1)
        tempView1.frame = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        
        
        tempView1.hero.id = "centerVideoView"
        
        tempView1.rx.tap().subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            let testVC2 = TestVC2()
            testVC2.isHeroEnabled = true
//            self.navigationController?.pushViewController(testVC2)
            
//            self.navigationController?.pushViewController(testVC2)
            self.present(testVC2, animated: true, completion: nil)
        }).disposed(by: rx.disposeBag)
   }
    
    
}


class TestVC2: TTViewController {
    var bigRender = UIView()
    
    override func makeUI() {
        super.makeUI()
        bigRender.backgroundColor = .red
//        self.hero.isEnabled = true
        bigRender.hero.id = "centerVideoView"
        
        addSubview(bigRender)
//        bigRender.frame = CGRect.init(x: 300, y: 100, width: 500, height: 300)
        bigRender.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalTo(bigRender.snp.height).multipliedBy(667 / 375.0)
        }
        
//        contentView.hero.id = "centerVideoView"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.navigationController?.popViewController()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
//        bigRender.frame = view.bounds
    }
}


class SDBaseAlert: TTAlert {
    override func makeUI() {
        super.makeUI()
        
        
        contentView.borderColor = rgba(42, 47, 58, 1)
        contentView.borderWidth = 1
        contentView.settingCornerRadius(12, false)
        contentView.backgroundColor = rgba(27, 32, 44, 0.9)
        contentView.addShadow(ofColor: rgba(42, 47, 58, 1), radius: 0, offset: .zero, opacity: 1)
    }
    
    
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.showAnimateStyle = .center
        config.showAnimateInterval = 0.2
        config.dismissAnimateInterval = 0.2
        config.defalultMinSize = .init(width: 100, height: 100)
    }
}


class InviteAlert: SDBaseAlert {
    private let horizontalStatck = TTStackView.horizontalStack()
    let cancleButton = UIButton()
    
    
    override func makeUI() {
        super.makeUI()
        addAlertSubViews([title,horizontalStatck,cancleButton])
        creatItems()
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(24)
            make.top.equalTo(20)
            make.height.equalTo(22)
        }
        
        horizontalStatck.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalTo(cancleButton.snp.top).offset(-22)
        }
        
        cancleButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(42)
            make.bottom.equalTo(-22)
        }
        
        
        // config
        horizontalStatck.distribution = .equalSpacing
        title.config(font: .regular(16), textColor: rgba(197, 198, 201, 1))
        title.text = "请选择邀请方式"
        cancleButton.titleLabel?.font = .regular(16)
        cancleButton.setTitleColor(rgba(85, 89, 98, 1), for: .normal)
        cancleButton.title("取消")
    }
    
    func creatItems() {
        let titles = ["通讯录","复制邀请消息","短信"]
        let icons = [R.image.back1(),R.image.back1(),R.image.back1()]
        for index in 0..<titles.count {
            
            let title = titles[index]
            let iconImage = icons[index]
            
            let button = TTButton.init(text: title, textColor: rgba(158, 160, 165, 1), font: .regular(12), iconImage: iconImage, type: .iconOnTheTop, intervalBetweenIconAndText: 8, padding: .zero)
            
         
            let borderView = UIView()
            borderView.borderWidth = 1
            borderView.borderColor = rgba(73, 77, 87, 1)
            borderView.cornerRadius = 12
            button.insertSubview(borderView, at: 0)
            borderView.snp.makeConstraints { (make) in
                make.center.equalTo(button.icon)
                make.size.equalTo(56)
            }
            
            
    
            horizontalStatck.addArrangedSubview(button)
            
            button.icon.snp.makeConstraints { (make) in
                make.size.equalTo(40)
            }
            
            
            button.snp.makeConstraints { (make) in
                make.width.equalTo(56)
            }
            
            
            // 点击事件传出去
            button.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
                self.eventIndex(index + 1)
            }).disposed(by: rx.disposeBag)
            
            
            // layout后进行切换布局
//            button.rx.methodInvoked(#selector(layoutSubviews)).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
//
//            }).disposed(by: rx.disposeBag)
        }
    }
    
    
    override func setupConfig() {
        super.setupConfig()
        config.defalultMinSize = sdLandSize(320, 241)
        config.showAnimateStyle = .bottom
    }
}






class CoreView: UIScrollView, UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("进来了 -- coreView")
        
        return true
    }
}


class TestView2: View,UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("进来了 -- View")
//        if gestureRecognizer.isKind(of: UITapGestureRecognizer.self) {
//            print("执行了点击")
//
//            return true
//        }
////
////
//        print("没有响应")
//        print("没有响应")
//        print("没有响应")
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}



extension ViewController1: UIGestureRecognizerDelegate {
}




extension ViewController1: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 3
        case 3:
            return 4
        default:
            return 2
            break
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TTCollectionViewCell.self, for: indexPath)
        cell.backgroundColor = .random
        cell.addSubview(cell.mainLabel)
        cell.mainLabel.text = "\(indexPath.section) + \(indexPath.row)"
        cell.mainLabel.snp.remakeConstraints { (make) in
            make.center.equalToSuperview()
        }
        return cell
    }
    
//     尺寸
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//        let row = indexPath.row
//        let width = SCREEN_W > SCREEN_H ? SCREEN_W : SCREEN_H
//        let height = SCREEN_H < SCREEN_W ? SCREEN_H : SCREEN_W
//
//        //  画中画Viewmodel
//        if let _ = items.value[row] as? MeetingPIPCellViewModel {
//
//            return .init(width: width, height: height)
//        }else {
//            return .init(width: width / 2, height: 202)
//        }
//
//        return .init(width: 200, height: 200)
//    }
}

class TestView: View {
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        
    }
    
    var title = ""
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        print(event?.type.rawValue)
        print(title + "hitTest")
        print(Date().timeIntervalSince1970)
        self.layer.delegate = self
        return super.hitTest(point, with: event)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        print(event?.type.rawValue)
        print(Date().timeIntervalSince1970)
        print(title + "hitPoint")
        return super.point(inside: point, with: event)
    }
    
    override func display(_ layer: CALayer) {
        super.display(layer)
        //
    }
}


class TestButton: UIButton {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print(event?.type.rawValue)
        print(titleLabel!.text! + "hitTest")
        return super.hitTest(point, with: event)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print(titleLabel!.text! + "hitPoint")
        return super.point(inside: point, with: event)
    }
}

