//
//  ViewController.swift
//  HomeScreenPoc
//
//  Created by Sathish on 8/23/16.
//  Copyright © 2016 Sathish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var headerView: UIView!
  var observer: ((offset: CGPoint) -> Void)!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    headerView.translatesAutoresizingMaskIntoConstraints = true
    observeContentOffset()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 5, inSection: 0), atScrollPosition: .None, animated: true)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let collectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! CollectionViewCell
    collectionViewCell.collectionView.contentOffset.y = yPosition()
    collectionViewCell.collectionView.contentInset = UIEdgeInsets(top: contentInset, left: 0, bottom: 0, right: 0)
    collectionViewCell.observer = observer
    return collectionViewCell
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let width = collectionView.frame.width
    let height = collectionView.frame.height
    return CGSize(width: width, height: height)
  }
  
  func yPosition() -> CGFloat {
    let visibleCells = collectionView.visibleCells()
    if let lastItem = visibleCells.last as? CollectionViewCell {
      if lastItem.collectionView.contentOffset.y > -headerHeight {
        return -headerHeight
      } else {
        return lastItem.collectionView.contentOffset.y
      }
    }
    return -contentInset
  }
  
  func observeContentOffset() {
    observer = { offset in
      var headerFrame = self.headerView.frame
      if offset.y < -self.headerHeight {
        headerFrame.origin.y = -((offset.y) + self.headerHeight)
        self.headerView.frame = headerFrame
      } else {
        headerFrame.origin.y = 0
        self.headerView.frame = headerFrame
      }
    }
  }
  
}

extension ViewController {
  var contentInset: CGFloat {
    return topSpace + headerHeight
  }
  var headerHeight: CGFloat {
    return 60
  }
  var topSpace: CGFloat {
    return 200
  }
}

