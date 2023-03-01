//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2022/12/15.
//  ~/Library/Caches/org.swift.swiftpm/
//  file:///Users/william/Desktop/@WWCheckBox

import UIKit
import WWPrint
import WWCheckBox

@IBDesignable class MyCheckBox: WWCheckBox {}

final class ViewController: UIViewController {
    
    @IBOutlet weak var myCheckBox1: MyCheckBox!
    @IBOutlet weak var myCheckBox2: MyCheckBox!
    @IBOutlet weak var myCheckBox3: MyCheckBox!

    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        myCheckBox2.selected(true, isUsedAnimation: false)
    }
}

// MARK: - WWCheckboxDelegate
extension ViewController: WWCheckboxDelegate {
    
    func didTouched(_ checkbox: WWCheckBox, indexPath: IndexPath, isSelected: Bool) {
        wwPrint("\(checkbox.indexPath) => \(isSelected)")
    }
}

// MARK: - 小工具
private extension ViewController {
    
    func initSetting() {
        
        myCheckBox1.delegate = self
        myCheckBox2.delegate = self
        myCheckBox3.delegate = self
        
        myCheckBox1.indexPath = IndexPath(row: 1, section: 0)
        myCheckBox2.indexPath = IndexPath(row: 2, section: 0)
        myCheckBox3.indexPath = IndexPath(row: 3, section: 0)
    }
}
