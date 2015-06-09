# Centipede
一个纯Swift实现的库，使用闭包实现UIKit组件的delegate和dataSource方法

### 解决什么问题
delegate很好的解决的自定义与耦合问题，但在实现delegate的各个方法时，方法遍布整个ViewController很散。
并且如果当前ViewController中有多个UITableView或其它实现delegate的组件时，在delegate实现方法中需要判断当前触发的组件是哪个。如：
```swift
@objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableView == leftTableView ? leftDatas.count : rightDatas.count
}
```
这让代码不易维护和阅读。

希望：
- 代码连续。组件的构造、样式设置和各delegate实现方法可写在一个位置。
- 独立。有多个UITableView时，tableViewA和tableViewB的delegate方法实现是独立的，互不干扰。

### 使用
- >= iOS 7
- 所有方法名称以`ce_`开头

`使用闭包需要注意循环引用问题，Swift使用weak或unowned关键字解决循环引用问题`

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
- UIActionSheet
- UIAlertView
- UICollectionView
- UIDocumentInteractionController
- UIDocumentMenuViewController
- UIDocumentPickerViewController
- UIDynamicAnimator
- UIGestureRecognizer
- UIImagePickerController
- UINavigationBar
- UINavigationController
- UIPageViewController
- UIPickerView
- UIPopoverController
- UIPopoverPresentationController
- UIPresentationController
- UIPrintInteractionController
- UIPrinterPickerController
- UIScrollView
- UISearchBar
- UISearchController
- UISearchDisplayController
- UISplitViewController
- UITabBar
- UITabBarController
- UITableView
- UITextField
- UITextView
- UIToolbar
- UIVideoEditorController
- UIViewController
- UIWebView

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

