//
//  ViewController.swift
//  NewSwiftProjectModul
//
//  Created by Mr.hong on 2020/11/3.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate{
    
    // 默认的viewModel
    var viewModel: ViewModel?
     
    let isLoading = BehaviorRelay(value: false)
    let error = PublishSubject<Error>()
    
    
    let emptyDataSetButtonTap = PublishSubject<Void>()
    var emptyDataSetTitle = "空页面标题"
    var emptyDataSetDescription = "空页面描述"
    var emptyDataSetImage = UIImage.testImage()
    var emptyDataSetImageTintColor = BehaviorRelay<UIColor?>(value: nil)
    
    
    lazy var contentView: UIView = {
        let view = UIView()
        //        view.hero.id = "CententView"
        self.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.edges.equalTo(UIEdgeInsets.zero)
                // Fallback on earlier versions
            }
        }
        return view
    }()

    lazy var stackView: UIStackView = {
        let subviews: [UIView] = []
        let view = UIStackView(arrangedSubviews: subviews)
        view.spacing = 0
        self.contentView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        return view
    }()
    
    var backGroundImageView = UIImageView.empty()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarDefaultConfig()
        tabbarShowOrHiddenSignal.onNext(self.isTabbarChildrenVC)
        
        // 是否可以手势返回
//        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true;
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
    }
    

    // 默认设置
    func defaultConfig() {
        self.view.backgroundColor = .white
        
        
        // 设置导航栏字体
        configNavigationBar(barColor: .white, titleColr: mainTextColor, font: .medium(18))
        
        // 去掉导航栏横线
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // 设置默认返回
        configLeftItem(iconName: "NavigationBarBack") { [weak self] in
            self?.backAction()
        }
    }
    
    func makeUI() {
        
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
    
    func bindViewModel() {
//        viewModel?.loading.asObservable().bind(to: isLoading).disposed(by: rx.disposeBag)
//        viewModel?.parsedError.asObservable().bind(to: error).disposed(by: rx.disposeBag)

//        languageChanged.subscribe(onNext: { [weak self] () in
//            self?.emptyDataSetTitle = R.string.localizable.commonNoResults.key.localized()
//        }).disposed(by: rx.disposeBag)
//
//        isLoading.subscribe(onNext: { isLoading in
//            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
//        }).disposed(by: rx.disposeBag)
    }
}


extension ViewController: DZNEmptyDataSetSource {

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetTitle)
    }

    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetDescription)
    }

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return emptyDataSetImage
    }

    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return emptyDataSetImageTintColor.value
    }

    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -60
    }
}

extension ViewController: DZNEmptyDataSetDelegate {

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !isLoading.value
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        emptyDataSetButtonTap.onNext(())
    }
}
