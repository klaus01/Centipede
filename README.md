# Centipede
一个纯Swift实现的库，使用闭包实现UIKit组件的delegate和dataSource方法
### 使用
UIKit Delegate
```swift
collectionView
    .ce_NumberOfItemsInSection { \[weak self\] (collectionView, section) -> Int in
        return self!.friends.count
    }
    .ce_CellForItemAtIndexPath { \[weak self\] (collectionView, indexPath) -> UICollectionViewCell in
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MYCELL", forIndexPath: indexPath) as! UserCollectionViewCell
        cell.user = self!.friends[indexPath.item]
        return cell;
    }
    .ce_DidSelectItemAtIndexPath { \[weak self\] (collectionView, indexPath) -> Void in
        let friend = self!.friends[indexPath.item]
        self!.performSegueWithIdentifier("showMessage", sender: nil)
    }
```

UIControl Add Target For Control Events
```swift
btn.ce_addControlEvents(UIControlEvents.TouchDown) { (control, touches) -> Void in
    println("TouchDown")
}.ce_addControlEvents(UIControlEvents.TouchUpInside) { (control, touches) -> Void in
    println("TouchUpInside")
}

btn.ce_removeControlEvents(UIControlEvents.TouchDown)
```

Notification Center Add Observer
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

