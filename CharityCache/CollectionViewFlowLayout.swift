//
//  CollectionViewFlowLayout.swift
//  LoadingView
//
//  Created by Aditya Koukuntla on 7/28/15.
//  Copyright (c) 2015 Aditya Koukuntla. All rights reserved.
//

import UIKit
import Foundation

let   ZOOM_FACTOR_D =  0.5

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var delegate: ScrollerDelegate?
    
    override func prepare() {
        super.prepare()
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superArray = super.layoutAttributesForElements(in: rect) else { return nil }
        // copy items
        guard let attributes = NSArray(array: superArray, copyItems: true) as? [UICollectionViewLayoutAttributes] else { return nil }
        
        var visibleRect = CGRect()
            if let collectionView = self.collectionView {
                visibleRect.origin = collectionView.contentOffset
                visibleRect.size = collectionView.bounds.size
                let collectionViewHalfFrame = collectionView.frame.size.width/2
                for lAttributes in attributes {
                    let iuAttributes =  lAttributes
                    if (iuAttributes.frame.intersects(rect)) {
                        let distance =  visibleRect.midX - iuAttributes.center.x
                        let normalizedDistance = distance / collectionViewHalfFrame
                        if (fabs(distance) < collectionViewHalfFrame) {
                            let zoom = 1 + CGFloat(ZOOM_FACTOR_D)  * (1 - fabs(normalizedDistance))
                            var rotationTransform = CATransform3DIdentity
                            rotationTransform = CATransform3DMakeRotation(normalizedDistance * CGFloat(M_PI_2) * 0.8, 0.0, 0.0, 0.0)
                            let zoomTransform =  CATransform3DMakeScale(zoom, zoom, 1)
                            iuAttributes.transform3D = CATransform3DConcat(zoomTransform,rotationTransform)
                            iuAttributes.transform3D = CATransform3DConcat(zoomTransform, rotationTransform)
                            iuAttributes.zIndex = Int(fabs(normalizedDistance)*10)
                        }
                    }
                }
            }
            return attributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment:Float  = MAXFLOAT
        let horizontalCenter: CGFloat  = proposedContentOffset.x + (self.collectionView!.bounds.width) / 2.0
        let floathorizontalCenter = Float(horizontalCenter)
        let proposedRect: CGRect  = CGRect(x:proposedContentOffset.x,y: 0.0,width: self.collectionView!.bounds.size.width,height: self.collectionView!.bounds.size.height)
        
        let array:NSArray = self.layoutAttributesForElements(in: proposedRect)! as NSArray
        // This loop will find the closest cell to proposed center of the collection view
        for individualLayoutAttributes in array {
            let layoutAttributes:UICollectionViewLayoutAttributes = individualLayoutAttributes as! UICollectionViewLayoutAttributes
            // skip supplementary views
            if layoutAttributes.representedElementCategory != UICollectionElementCategory.cell {
                continue
            }
            // Determine if this layout attribute's cell is closer than the closest we have so far
            let itemHorizontalCenter:CGFloat  = layoutAttributes.center.x
            let floatitemHorizontalCenter = Float(itemHorizontalCenter)
            if fabsf(floatitemHorizontalCenter - floathorizontalCenter) < fabsf(offsetAdjustment){
                offsetAdjustment = floatitemHorizontalCenter - floathorizontalCenter
                if let delegate = self.delegate {
                    delegate.willScrollToItem(item: layoutAttributes.indexPath.item)
                }
            }
        }
        return CGPoint(x:proposedContentOffset.x + CGFloat(offsetAdjustment),y:proposedContentOffset.y)
    }
    
}
