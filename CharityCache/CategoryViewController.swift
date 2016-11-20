//
//  CategoryViewController.swift
//  CharityCache
//
//  Created by Aditya Koukuntla on 11/19/16.
//  Copyright © 2016 CharityCache. All rights reserved.
//

import UIKit

protocol ScrollerDelegate {
    func willScrollToItem(item: Int)
}

class CategoryViewController: UIViewController,ScrollerDelegate {
    
    @IBOutlet weak var categoryTypeLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var selectedItem = 0
    
    let images = [#imageLiteral(resourceName: "electronics.jpg"),#imageLiteral(resourceName: "drinks.jpg"),#imageLiteral(resourceName: "spa.jpg"),#imageLiteral(resourceName: "travel.jpg"),#imageLiteral(resourceName: "automobile.png"),#imageLiteral(resourceName: "fitness.jpg"),#imageLiteral(resourceName: "apparel.jpg"),#imageLiteral(resourceName: "electronics.jpg"),#imageLiteral(resourceName: "drinks.jpg"),#imageLiteral(resourceName: "spa.jpg"),#imageLiteral(resourceName: "travel.jpg"),#imageLiteral(resourceName: "automobile.png"),#imageLiteral(resourceName: "fitness.jpg"),#imageLiteral(resourceName: "apparel.jpg")]
    let categoryNames = ["Electronics", "Drinks" , "Spa", "Travel", "Automobile" ,"Fitness", "Apparel","Electronics", "Drinks" , "Spa", "Travel", "Automobile" ,"Fitness", "Apparel"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection view data source
    
    func numberOfSectionsInCollectionView(_ collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath as IndexPath) as! CategoryCollectionViewCell
        if let
            flowLayout = self.categoryCollectionView.collectionViewLayout as? CollectionViewFlowLayout {
            flowLayout.delegate = self
        }
        collectionViewCell.categoryImageView.image = self.images[indexPath.item]
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        let leftInset = self.categoryCollectionView.frame.size.width/2 - 50
        let rightInset = self.categoryCollectionView.frame.size.width/2 - 50
        let sectionInsets = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectedItem = indexPath.item
        self.performSegue(withIdentifier: "toMapView", sender: self)
    }
    
    func willScrollToItem(item: Int) {
        self.categoryTypeLabel.text = self.categoryNames[item]
    }
    
    @IBAction func backClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let
            mapController = segue.destination as? MapViewController {
            mapController.title = self.categoryNames[self.selectedItem]
        }
    }
    
    
}
