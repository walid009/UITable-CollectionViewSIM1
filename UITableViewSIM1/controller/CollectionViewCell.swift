//
//  CollectionViewCell.swift
//  UITableViewSIM1
//
//  Created by chekir walid on 12/10/2021.
//

import UIKit

class CollectionViewCell: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var movies = [ "El Camino", "Extraction", "Project Power", "Six Underground", "Spenser Confidential", "The Irishman" ]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mCell", for: indexPath)
        let contentView = cell.contentView
        //widgets
        let imageView = contentView.viewWithTag(1) as! UIImageView
        //bind
        imageView.image = UIImage(named: movies[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(movies[indexPath.row])
        self.performSegue(withIdentifier: "showDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            let indexPath = sender as! IndexPath
            if let vc = segue.destination as? DetailsViewController {
                let txt = movies[indexPath.row]
                vc.titleMovie = txt
                vc.descriptionMovie = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
            }
        }
    }
    
}
