//
//  SSUDetailedSearchViewController.swift
//  SSUMobile
//
//  Created by DANIEL THOMPSON on 5/9/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import UIKit
class SSUDetailedSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var instructorSearch: UISearchBar!
    @IBOutlet weak var departmentSearch: UISearchBar!
    @IBOutlet weak var classNumSearch: UISearchBar!
    @IBOutlet weak var startTimeSearch: UISearchBar!
    @IBOutlet weak var endTimeSearch: UISearchBar!
    @IBOutlet weak var unitSearch: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    var lastName: String = ""
    var minUnits: String = ""
    var startTime: String = ""
    var endTime: String = ""
    var classType: String = ""
    var classNumber: String = ""
    var section: Int = 0
    var department: String = ""
    var subject: String = ""
    var catalog: String = ""
    
    var _classes: [SSUCourse]?
    var results: [SSUCourse] = []
    var temp: [SSUCourse] = [] //Extra redundancy. Had issues with the results array. Added this just in case.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "table_background_image")?.draw(in: self.view.bounds)
        
        if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        }
        
        instructorSearch.delegate = self
        departmentSearch.delegate = self
        classNumSearch.delegate = self
        startTimeSearch.delegate = self
        endTimeSearch.delegate = self
        unitSearch.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if searchBar.placeholder == "Instructor's last name" {
            lastName = "" //Resetting the value to default
            lastName = searchBar.text!
        }
        
        if searchBar.placeholder == "Department" {
            department = ""
            department = searchBar.text!
        }
        
        if searchBar.placeholder == "Class Number" {
            classNumber = ""
            classNumber = searchBar.text!
            
        }
        
        if searchBar.placeholder == "Start Time" {
            startTime = ""
            startTime = searchBar.text!
        }
        
        if searchBar.placeholder == "End Time" {
            endTime = ""
            endTime = searchBar.text!
        }
        
        
        if searchBar.placeholder == "Units" {
            minUnits = ""
            minUnits = searchBar.text!
        }
        
        //Reset defaults
        if !temp.isEmpty {
            temp = []
        }
        if !results.isEmpty {
            results = []
        }
        
        //Filter search results. Includes checking strings disregarding case-sensitivity.
        for _class in _classes! {
            if ((lastName == "" || _class.last_name == lastName ||
                (_class.last_name?.lowercased().range(of: lastName) != nil) ||
                (_class.last_name?.range(of: lastName) != nil)) &&
                
                (department == "" || _class.department == department ||
                    (_class.department?.lowercased().range(of: department) != nil) ||
                    (_class.department?.range(of: department) != nil)) &&
                
                (classNumber == "" || _class.catalog == classNumber) &&
                
                (startTime == "" || _class.start_time == startTime ||
                    (_class.start_time?.lowercased().range(of: startTime) != nil) ||
                    (_class.start_time?.range(of: startTime) != nil)) &&
                
                (endTime == "" || _class.end_time == endTime ||
                    (_class.end_time?.lowercased().range(of: endTime) != nil) ||
                    (_class.end_time?.range(of: endTime) != nil)) &&
                
                (minUnits == "" || _class.min_units == minUnits)) {
                    
                temp.append(_class)
            }
        }
        
        results = temp
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResults"{
            let searchVc = segue.destination as! SSUsearchResultTableViewController
            searchVc.passResults(classes: results)
        }
    }
    
    
    func passClassData(classes: [SSUCourse]){
        _classes = classes
    }
    
    
}
