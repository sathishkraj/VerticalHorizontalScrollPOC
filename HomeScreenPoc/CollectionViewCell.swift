//
//  CollectionViewCell.swift
//  HomeScreenPoc
//
//  Created by Sathish on 8/23/16.
//  Copyright © 2016 Sathish. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var collectionView: UICollectionView!
  var observer: ((offset: CGPoint) -> Void)?
}

// MARK : CollectionView datasource and delegate

extension CollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let collectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("dummycell", forIndexPath: indexPath)
    return collectionViewCell
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let width = collectionView.frame.width - 20
    return CGSize(width: width, height: 200)
  }
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    observer?(offset: scrollView.contentOffset)
  }
  
}