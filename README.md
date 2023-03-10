# WWCheckBox

[![Swift-5.7](https://img.shields.io/badge/Swift-5.7-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-13.0](https://img.shields.io/badge/iOS-13.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![](https://img.shields.io/github/v/tag/William-Weng/WWCheckBox) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

HTML-like CheckBox function.
仿HTML的CheckBox功能.

![](./Example.gif)

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)
```
dependencies: [
    .package(url: "https://github.com/William-Weng/WWCheckBox.git", .upToNextMajor(from: "1.0.0"))
]
```

### Example
![](./IBDesignable.png)

```swift
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
```