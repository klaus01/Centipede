//
//  ViewController.swift
//  CentipedeExample
//
//  Created by kelei on 16/10/27.
//  Copyright © 2016年 kelei. All rights reserved.
//

import UIKit
import Centipede

class ViewController: UIViewController {

    private var leftTableView: UITableView!
    private var rightTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellReuseIdentifier = "CELL"
        
        leftTableView = UITableView()
        leftTableView.frame = CGRect(x: 0, y: 0, width: view.center.x, height: view.bounds.height)
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        leftTableView.ce_scrollViewDidScroll { [weak self] (scrollView) in
            self?.rightTableView.contentOffset = scrollView.contentOffset
        }.ce_numberOfSections_in { (tableView) -> Int in
            return 4
        }.ce_tableView_numberOfRowsInSection { (tableView, section) -> Int in
            return 8
        }.ce_tableView_cellForRowAt { (tableView, indexPath) -> UITableViewCell in
            return tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        }.ce_tableView_willDisplay { (tableView, cell, indexPath) in
            cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        }
        view.addSubview(leftTableView)
        
        rightTableView = UITableView()
        rightTableView.frame = leftTableView.frame
        rightTableView.frame.origin.x = view.center.x
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        rightTableView.ce_numberOfSections_in { (tableView) -> Int in
            return 8
        }.ce_tableView_numberOfRowsInSection { (tableView, section) -> Int in
            return 4
        }.ce_tableView_cellForRowAt { (tableView, indexPath) -> UITableViewCell in
            return tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        }.ce_tableView_willDisplay { (tableView, cell, indexPath) in
            cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        }.ce_scrollViewDidScroll { [weak self] (scrollView) in
            self?.leftTableView.contentOffset = scrollView.contentOffset
        }
        view.addSubview(rightTableView)
    }
    
}
