//
//  TTCommonTableViewController.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.


import UIKit


class TTTableViewController: TTViewController,UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate {
  
    
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


extension TTTableViewController {
    // dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
