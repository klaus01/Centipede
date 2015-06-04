# Centipede `第一版还在完善中`
一个纯Swift实现的库，使用闭包实现UIKit组件的delegate和dataSource方法

### 解决什么问题
delegate很好的解决的自定义与耦合问题，但在实现delegate的各个方法时，方法遍布整个ViewController很散。
并且如果当前ViewController中有多个UITableView或其它实现delegate的组件时，在delegate实现方法中需要判断当前触发的组件是哪个。如：
```swift
@objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableView == leftTableView ? leftDatas.count : rightDatas.count
}
```
这让代码很难看、不易读、不易维护。

我想做到：
- 代码连续。组件的构造、样式设置和各delegate实现方法可写在一个位置。
- 独立。如有多个UITableView时，tableViewA和tableViewB的delegate方法实现是独立的，互不干扰。

### 使用
所有方法名称以`cd_`开头

##### UIKit Delegate
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

##### UIControl Add Target For Control Events
```swift
btn.ce_addControlEvents(UIControlEvents.TouchDown) { (control, touches) -> Void in
    println("TouchDown")
}.ce_addControlEvents(UIControlEvents.TouchUpInside) { (control, touches) -> Void in
    println("TouchUpInside")
}

btn.ce_removeControlEvents(UIControlEvents.TouchDown)
```

##### Notification Center Add Observer
```swift
override func viewDidLoad() {
    super.viewDidLoad()

    ce_addObserverForName(kNotification_UpdatingFriends) { [weak self] (notification) -> Void in
        self!.refreshControl.beginRefreshing()
    }
    ce_addObserverForName(kNotification_UpdateFriendsComplete) { [weak self] (notification) -> Void in
        self!.friends = UserInfo.shared.whitelistFriends
        self!.collectionView.reloadData()
        self!.refreshControl.endRefreshing()
    }
}

deinit {
    ce_removeObserver()
}
```

