//
//  ViewController.swift
//  StormViewer
//
//  Created by Vadim Colcev on 11/17/20.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]() // declare and create array outside of viewDidLoad to preserve it
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Storm Viewer"
        let fm = FileManager.default // data type to work with fs
        let path = Bundle.main.resourcePath! // sets resource path
        let items = try! fm.contentsOfDirectory(atPath: path) // gets the array of items from the directory under path
        
        for item in items {
            if item.hasPrefix("nssl") { // method to find every line starting from nssl
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    
    
    // override default method that defines 0 rows with new method that defines rows in scope of picture count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // this method takes in a table view we use and indexPath and returns cell to use
    // first we dequeue a cell from table view and then return this cell but before we do we assign a text by name of picture for the cell in question. indexPath.row takes care of number to be used as position in array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.itemIndex = indexPath.row
            vc.totalItems = pictures.count
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}

