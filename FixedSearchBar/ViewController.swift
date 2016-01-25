//
//  ViewController.swift
//  FixedSearchBar
//
//  Created by Kemar Senior on 1/25/16.
//  Copyright © 2016 Kemar Senior. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {

    @IBOutlet weak var searchBarContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    var listArray: [String] = []
    var searchResultsArray:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureSearchController()
        
        listArray = ["Apple", "Banana", "Cherries", "Dates", "Egg Plant", "Figs", "Grapes", "Honey Dew"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table View
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active && searchController.searchBar.text != ""{
            return searchResultsArray.count

        }
        
        return listArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell")
        let word:String
        
        if searchController.active && searchController.searchBar.text != ""{
            word = searchResultsArray[indexPath.row];
        }else{
            word = listArray[indexPath.row]

        }
        
        cell!.textLabel!.text = word
        
        return cell!
    }
    
    
    // MARK: - Search Bar
    
    func configureSearchController(){
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self;
        searchController.searchBar.sizeToFit()
        searchBarContainerView.addSubview(searchController.searchBar)
        
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if searchController.searchBar.text?.characters.count > 0{
            searchResultsArray = listArray.filter({(word:String) -> Bool in
                
                return word.lowercaseString.containsString((searchController.searchBar.text?.lowercaseString)!)
                })
            
        }
        tableView.reloadData()

        
    }
    
    // Handling Rotation
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            // adjust searchbar width
            self.searchController.searchBar.frame.size.width = size.width
            
            }) { (UIViewControllerTransitionCoordinatorContext) -> Void in
                // Something after animation
        }
        
    }
    

    



}

