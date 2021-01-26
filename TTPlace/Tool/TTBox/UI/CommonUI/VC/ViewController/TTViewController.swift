//
//  ViewController.swift
//  NewSwiftProjectModul
//
//  Created by Mr.hong on 2020/11/3.
//

import UIKit
class TTViewController: UIViewController,UIGestureRecognizerDelegate{
    
    // 默认的viewModel
    var viewModel: ViewModel?
     
    let isLoading = BehaviorRelay(value: false)
    let error = PublishSubject<Error>()
    
    
    let emptyDataSetButtonTap = PublishSubject<Void>()
    var emptyDataSetTitle = "空页面标题"
    var emptyDataSetDescription = "空页面描述"
    var emptyDataSetImage = UIImage.testImage()
    var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)
    
    
    // 间距规范
    var inset: CGFloat {
        return 12
    }
    
    lazy var contentView: View = {
        let view = View()
        //        view.hero.id = "CententView"
        self.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                // Fallback on earlier versions
                make.edges.equalToSuperview()
            }
        }
        return view
    }()

    lazy var stackView: StackView = {
        let subviews: [UIView] = []
        let view = StackView(arrangedSubviews: subviews)
        view.spacing = inset
        view.axis = .vertical
        view.distribution = .fill
        self.contentView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        return view
    }()

    
    var backGroundImageView = UIImageView.empty()
    
    
    init(_ viewModel: ViewModel? = nil ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarDefaultConfig()
        tabbarShowOrHiddenSignal.onNext(self.isTabbarChildrenVC)
        
        // 是否可以手势返回
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backGroundImageView.backgroundColor = .clear
        view.addSubview(backGroundImageView)
        backGroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        defaultConfig()
        navigationBarDefaultConfig()
        makeUI()
        bindViewModel()
    }
    

    // 默认设置
    func defaultConfig() {
        self.view.backgroundColor = .white
        
        // 设置导航栏字体
        configNavigationBar(barColor: .white, titleColr: rgba(51, 51, 51, 1), font: .medium(18))
        
        // 去掉导航栏横线
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // 设置默认返回
        configLeftItem(iconName: "NavigationBarBack") { [weak self] in
            self?.backAction()
        }
    }
    
    func makeUI() {
        hero.isEnabled = true
        
        updateUI()
    }
    
    func updateUI() {

    }
    
    func bindViewModel() {
//        isLoading.subscribe(onNext: { isLoading in
//            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
//        }).disposed(by: rx.disposeBag)
    }
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    // 默认是不隐藏导航栏的
    func navigationBarDefaultConfig() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    // 隐藏导航栏
    func hiddenNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = true
    }
    

    // 侧滑手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("触发侧滑了!!!")
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return self.navigationController!.viewControllers.count > 1
        }
        return true
    }
    

}




