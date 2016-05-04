# Centipede ![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat) ![CocoaPods](https://img.shields.io/cocoapods/v/Centipede.svg?style=flat) ![CocoaPods](http://img.shields.io/cocoapods/p/Centipede.svg?style=flat) ![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)

一个Swift库，使用闭包实现UIKit组件的delegate和dataSource方法

### 解决什么问题
在实现delegate的各个方法时：

- 方法遍布整个ViewController，很散。
- 具体的实现与成员变量被分开了，阅读时需要分开查看。
- 如果当对象中实现多个UITableViewDataSource时，方法中需要判断组件来做出反应。如：（这很丑）

```swift
@objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableView == leftTableView ? leftDatas.count : rightDatas.count
}
```

这些情况让代码不易阅读和维护。

**希望：**

- 代码连续。组件的构造、样式设置和各delegate实现方法可写在一个位置。
- 独立。有多个UITableView时，tableViewA和tableViewB的delegate方法实现是独立的，互不干扰。

### 使用

- Xcode 7.3
- Swift 2.2
- iOS 8+
- 所有方法名称以`ce_`开头

#### 直接源码

将`Centipede`目录复制到您的项目中及可。

#### CocoaPods

```
platform :ios, '8.0'
use_frameworks!

pod 'Centipede'
```
code

```swift
import Centipede

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellReuseIdentifier = "MYCELL"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.ce_didScroll { (scrollView) in
            print(scrollView.contentOffset)
        }.ce_numberOfSectionsIn { (tableView) -> Int in
            return 3;
        }.ce_numberOfRowsInSection { (tableView, section) -> Int in
            return 20;
        }.ce_cellForRowAtIndexPath { (tableView, indexPath) -> UITableViewCell in
            return tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath)
        }.ce_willDisplayCell { (tableView, cell, indexPath) in
            cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        }
        
        button.ce_addControlEvents(UIControlEvents.TouchUpInside) { [weak self] (control, touches) in
            self?.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1), atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
        }
    }

}
```

### 注意

使用闭包需要注意循环引用问题，Swift使用weak或unowned关键字解决循环引用问题

##### UIKit `delegate` and `dataSource` method

```swift
collectionView
    .ce_NumberOfItemsInSection { [weak self] (collectionView, section) -> Int in
        return self!.friends.count
    }
    .ce_CellForItemAtIndexPath { [weak self] (collectionView, indexPath) -> UICollectionViewCell in
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MYCELL", forIndexPath: indexPath) as! UserCollectionViewCell
        cell.user = self!.friends[indexPath.item]
        return cell;
    }
    .ce_DidSelectItemAtIndexPath { [weak self] (collectionView, indexPath) -> Void in
        let friend = self!.friends[indexPath.item]
        self!.performSegueWithIdentifier("showMessage", sender: nil)
    }
```

- AVFoundation/AVAudioPlayer
- AVFoundation/AVAudioRecorder
- AVFoundation/AVSpeechSynthesizer
- CoreBluetooth/CBCentralManager
- CoreBluetooth/CBPeripheral
- CoreBluetooth/CBPeripheralManager
- CoreData/NSFetchedResultsController
- CoreLocation/CLLocationManager
- EventKitUI/EKCalendarChooser
- EventKitUI/EKEventViewController
- ExternalAccessory/EAAccessory
- ExternalAccessory/EAWiFiUnconfiguredAccessoryBrowser
- Foundation/NSCache
- Foundation/NSFileManager
- Foundation/NSKeyedArchiver
- Foundation/NSKeyedUnarchiver
- Foundation/NSMetadataQuery
- Foundation/NSNetService
- Foundation/NSNetServiceBrowser
- Foundation/NSStream
- Foundation/NSURLSession
- Foundation/NSUserActivity
- Foundation/NSXMLParser
- GLKit/GLKView
- GLKit/GLKViewController
- GameKit/GKMatch
- HomeKit/HMAccessory
- HomeKit/HMAccessoryBrowser
- HomeKit/HMHome
- HomeKit/HMHomeManager
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
- UIKit/UIPrintInteractionController
- UIKit/UIPrinterPickerController
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
- iAd/ADBannerView
- iAd/ADInterstitialAd

##### Other add target action method

```swift
button
    .ce_addControlEvents(UIControlEvents.TouchDown) { (control, touches) -> Void in
        println("TouchDown")
    }
    .ce_addControlEvents(UIControlEvents.TouchUpInside) { (control, touches) -> Void in
        println("TouchUpInside")
    }

button.ce_removeControlEvents(UIControlEvents.TouchDown)

textField.ce_addControlEvents(UIControlEvents.EditingChanged | UIControlEvents.EditingDidBegin) { (control, touches) -> Void in
    println("textChanged")
}
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

##### Notification center add observer

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    ce_addObserverForName("kNotificationA") { (notification) -> Void in
        println("kNotificationA action")
    }
    ce_addObserverForName("kNotificationB") { (notification) -> Void in
        println("kNotificationB action")
    }
}

deinit {
    ce_removeObserver()
}
```

### License

Centipede is released under the MIT license. See LICENSE for details.


