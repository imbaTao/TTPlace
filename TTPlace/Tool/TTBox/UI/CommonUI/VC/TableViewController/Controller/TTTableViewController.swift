//
//  TTCommonTableViewController.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.


import UIKit


class TTTableViewController: TTViewController, UIScrollViewDelegate {
    lazy var tableView: TTTableView = {
        let view = TTTableView(frame: CGRect(), style: .plain)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func makeUI() {
        super.makeUI()
        stackView.spacing = 0
        stackView.insertArrangedSubview(tableView, at: 0)
    }


}


