//
//  SSUsearchResultTableViewController.swift
//  SSUMobile
//
//  Created by DANIEL THOMPSON on 5/9/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import UIKit

class SSUsearchResultTableViewController: UITableViewController {
    
    var _classes: [SSUCourse]?
  //  var classes: [[SSUCourse]]?
//    private var sects: [Sections]?
//    
//    private struct Sections {
//        var title: String
//        var courses = [SSUCourse]()
//        var count = 0
//        init(title: String, course: SSUCourse) {
//            self.title = title
//            addOrIgnore(course)
//            
//        }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title = "Search Results"
        let image = UIImage(named: "table_background_image")
        let backgroundImageView = UIImageView(image: image)
        self.tableView.backgroundView = backgroundImageView
        
        //If no results are found
        if _classes!.count == 0 {
            let noResults = UILabel()
            noResults.text = "NO RESULTS TO DISPLAY"
            noResults.textColor = UIColor.white
            view.addSubview(noResults)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if((_classes?.count)! > 1){
            return (_classes!.count) / 2 //This was added to avoid an issue with classes being repeated exactly twice.
        }
        return (_classes!.count)
    }
    
    func passResults(classes: [SSUCourse]){
        _classes = classes
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _classes!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseViewCell", for: indexPath)
        if let theCell = cell as? SSUCourseViewCell{
            theCell.transferClassInfo(course: (_classes![indexPath.row]))
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColorFromHex(rgbValue: 0x215EA8)
        header.textLabel?.textColor = UIColorFromHex(rgbValue: 0x5a86b9)
        header.textLabel?.textAlignment = .center
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "courseToDetails"{
            let cell = sender as! SSUCourseViewCell
            if let indexPath = tableView.indexPath(for: cell), let oldClass = _classes?[(indexPath.row)] {
                let detailsVC = segue.destination as! SSUCourseDetailViewController
                detailsVC.passClassData(oldClass)
            }
            
                
        }
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

