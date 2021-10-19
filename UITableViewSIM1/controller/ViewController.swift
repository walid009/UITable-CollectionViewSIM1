//
//  ViewController.swift
//  UITableViewSIM1
//
//  Created by chekir walid on 5/10/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    //let
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext//core data for big data
    //var
    var FavoriteMovies = [Favorites]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LoadFavoriteMovies()
    }
    
    //cette method est definie par defaut a retourner 1
    //hedi wa9et yabda 3andi deux type de cell garcon et fille ou dans le cas
    //de plusieurs cell wa9tha n9ol 9adeh 3andi men type
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell")
        let contentView = cell?.contentView
        //widgets
        let imageView = contentView?.viewWithTag(1) as! UIImageView
        let label = contentView?.viewWithTag(2) as! UILabel
        //bind
        label.text = FavoriteMovies[indexPath.row].title
        imageView.image = UIImage(named: FavoriteMovies[indexPath.row].title!)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showWatch", sender: indexPath)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DeleteFavoriteMovie(at: indexPath)
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWatch"{
            let indexPath = sender as! IndexPath
            if let vc = segue.destination as? WatchViewController {
                vc.titleMovie = FavoriteMovies[indexPath.row].title
                vc.descriptionMovie = FavoriteMovies[indexPath.row].desc
            }
        }
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
    //MARK: -load favorite movie
    func LoadFavoriteMovies(with request: NSFetchRequest<Favorites> = Favorites.fetchRequest()) {//with when we call method and request used in the method value if no data passed to the method is Favorites.fetchRequest()
        do {
            FavoriteMovies = try self.context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    //MARK: -Delete favorite movie
    func DeleteFavoriteMovie(at indexPath: IndexPath){
        self.context.delete(self.FavoriteMovies[indexPath.row])
        self.FavoriteMovies.remove(at: indexPath.row)
        self.saveItems()
    }
    //MARK: -Code atelier
    
}

