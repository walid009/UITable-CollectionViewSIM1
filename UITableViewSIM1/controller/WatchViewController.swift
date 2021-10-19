//
//  WatchViewController.swift
//  UITableViewSIM1
//
//  Created by chekir walid on 17/10/2021.
//

import UIKit

class WatchViewController: UIViewController {
    //var
    var titleMovie:String?
    var descriptionMovie:String?
    //outlet
    @IBOutlet weak var imageUI: UIImageView!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var descriptionTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageUI.image = UIImage(named: titleMovie!)
        titleLB.text = titleMovie!
    }

}
