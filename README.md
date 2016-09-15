# Centipede ![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat) ![CocoaPods](https://img.shields.io/cocoapods/v/Centipede.svg?style=flat) ![CocoaPods](http://img.shields.io/cocoapods/p/Centipede.svg?style=flat) ![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)

一个 Swift 库，使用闭包实现 UIKit 等组件的 delegate 和 dataSource 方法

# 解决什么问题
在实现 delegate 的各个方法时：

- 方法遍布整个 ViewController，散乱。
- 具体的实现与成员变量被分开了，阅读时需要分开查看。
- 如果 ViewController 中实现多个 UITableViewDataSource 时，方法中需要判断组件来做出反应。如下：（这很丑）

```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableView == leftTableView ? leftDatas.count : rightDatas.count
}
```

这些情况让代码不易阅读和维护。

**希望：**

- 代码连续。组件的构造、样式设置和各 delegate 实现方法可写在一个位置。
- 独立。有多个 UITableView 时，tableViewA 和tableViewB 的 delegate 方法实现是独立的，互不干扰。

# 使用

Xcode 8, Swift 3.0, iOS 8+
所有方法名称以`ce_`开头

### 直接源码

将`Centipede`目录复制到您的项目中及可。

### CocoaPods

```
platform :ios, '8.0'
use_frameworks!

pod 'Centipede'
```

### 注意

使用闭包需要注意循环引用问题，Swift使用weak或unowned关键字解决循环引用问题

### UIKit `delegate` and `dataSource` method

```swift
import Centipede

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let kCellReuseIdentifier = "MYCELL"
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellReuseIdentifier)
            tableView.ce_numberOfSections_in { (tableView) -> Int in
                return 3
            }.ce_tableView_numberOfRowsInSection { (tableView, section) -> Int in
                return 5
            }.ce_tableView_cellForRowAt { (tableView, indexPath) -> UITableViewCell in
                return tableView.dequeueReusableCell(withIdentifier: kCellReuseIdentifier, for: indexPath)
            }.ce_tableView_willDisplay { (tableView, cell, indexPath) in
                cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
            }.ce_scrollViewDidScroll { (scrollView) in
                print(scrollView.contentOffset)
            }
        }
    }
    
}
```

- AVFoundation/AVAudioPlayer
- AVFoundation/AVAudioRecorder
- AVFoundation/AVSpeechSynthesizer
- CoreBluetooth/CBCentralManager
- CoreBluetooth/CBPeripheral
- CoreBluetooth/CBPeripheralManager
- CoreLocation/CLLocationManager
- ExternalAccessory/EAAccessory
- ExternalAccessory/EAWiFiUnconfiguredAccessoryBrowser
- Foundation/NSKeyedArchiver
- Foundation/NSKeyedUnarchiver
- Foundation/NSMetadataQuery
- Foundation/NSUserActivity
- Foundation/XMLParser
- GameKit/GKMatch
- GLKit/GLKView
- GLKit/GLKViewController
- iAd/ADBannerView
- iAd/ADInterstitialAd
- MapKit/MKMapView
- MediaPlayer/MPMediaPickerController
- MediaPlayer/MPPlayableContentManager
- MultipeerConnectivity/MCAdvertiserAssistant
- MultipeerConnectivity/MCBrowserViewController
- MultipeerConnectivity/MCNearbyServiceAdvertiser
- MultipeerConnectivity/MCNearbyServiceBrowser
- MultipeerConnectivity/MCSession
- PassKit/PKAddPassesViewController
- PassKit/PKPaymentAuthorizationViewController
- PushKit/PKPushRegistry
- QuartzCore/CAAnimation
- QuartzCore/CALayer
- QuickLook/QLPreviewController
- SceneKit/SCNProgram
- SpriteKit/SKScene
- StoreKit/SKProductsRequest
- StoreKit/SKRequest
- StoreKit/SKStoreProductViewController
- UIKit/NSLayoutManager
- UIKit/NSTextStorage
- UIKit/UIActionSheet
- UIKit/UIAlertView
- UIKit/UICollectionView
- UIKit/UIDocumentInteractionController
- UIKit/UIDocumentMenuViewController
- UIKit/UIDocumentPickerViewController
- UIKit/UIDynamicAnimator
- UIKit/UIGestureRecognizer
- UIKit/UIImagePickerController
- UIKit/UINavigationBar
- UIKit/UINavigationController
- UIKit/UIPageViewController
- UIKit/UIPickerView
- UIKit/UIPopoverController
- UIKit/UIPopoverPresentationController
- UIKit/UIPresentationController
- UIKit/UIPrinterPickerController
- UIKit/UIPrintInteractionController
- UIKit/UIScrollView
- UIKit/UISearchBar
- UIKit/UISearchController
- UIKit/UISplitViewController
- UIKit/UITabBar
- UIKit/UITabBarController
- UIKit/UITableView
- UIKit/UITextField
- UIKit/UITextView
- UIKit/UIToolbar
- UIKit/UIVideoEditorController
- UIKit/UIViewController
- UIKit/UIWebView

### Other add target action method

```swift
// UIControl
button.ce_addControlEvents(.touchDown) { (control, touches) in
    print("TouchDown")
}.ce_addControlEvents(.touchUpInside) { (control, touches) in
    print("TouchUpInside")
}
   
button.ce_removeControlEvents(.touchDown)
   
textField.ce_addControlEvents([.editingChanged, .editingDidBegin]) { (control, touches) in
    print("TextChanged")
}

// UIBarButtonItem
let barButtonItem = UIBarButtonItem()
barButtonItem.action { (barButtonItem) in
    print("UIBarButtonItem action")
}

// UIGestureRecognizer
let gestureRecognizer = UIPanGestureRecognizer { (gestureRecognizer) in
    print(gestureRecognizer.state.rawValue)
}
self.view.addGestureRecognizer(gestureRecognizer)
```

- UIControl
    - UIButton
    - UIDatePicker
    - UIPageControl
    - UIRefreshControl
    - UISegmentedControl
    - UISlider
    - UIStepper
    - UISwitch
    - UITextField
- UIBarButtonItem
- UIGestureRecognizer

# License

Centipede is released under the MIT license. See LICENSE for details.


