//
//  DetailsViewController.swift
//  UITableViewSIM1
//
//  Created by chekir walid on 5/10/2021.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    //let
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext//core data for big data
    //var
    var titleMovie:String?
    var descriptionMovie:String?
    var FavoriteMovies = [Favorites]()
    //outlet
    @IBOutlet weak var imageUI: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var btnAddFavorite: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLabel.text = titleMovie
        descriptionTxt.text = descriptionMovie
        imageUI.image = UIImage(named: titleMovie!)
        if self.verif(title: titleMovie!) == 1 {
            btnAddFavorite.isHidden = true
        }
        print(self.verif(title: titleMovie!) )
    }
    //ibAction
    @IBAction func AddToFavoretPressed(_ sender: UIButton) {
        //1
        let alert = UIAlertController(title: "\(titleMovie!)", message: "Add to you're favorite movies", preferredStyle: .alert)
        //2
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let action = UIAlertAction(title: "OK", style: .default) { UIAlertAction in
            let newItem = Favorites(context: self.context)
            newItem.title = self.titleMovie
            newItem.desc = self.descriptionMovie
            self.saveItems()
            self.navigationController?.popViewController(animated: true)
        }
        //3
        alert.addAction(action)
        alert.addAction(cancel)
        //4
        self.present(alert, animated: true, completion: nil)
    }
    //methods
    //Mark - save Items
    func saveItems() {
        if context.hasChanges {
            do {
                try self.context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error, \(nserror), \(nserror.userInfo)")
            }
        }
    }
    //MARK: -Verif existant of the Categories
    func verif(title:String) -> Int {
        let predicate = NSPredicate(format: "title == %@", title)//search
        let request: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        request.predicate = predicate
        do {
            let array = try self.context.fetch(request)
            return array.count
        } catch {
            print("Error fetching data from context \(error)")
            return 2
        }
    }
}
