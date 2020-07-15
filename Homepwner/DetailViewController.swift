//
//  DetailViewController.swift
//  Homepwner
//
//  Created by USER on 15/07/2020.
//  Copyright © 2020 USER. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: Properties
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    var item: Item!
    
    
    //MARK: Instances
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
//        valueField.text = "\(item.valueInDollars)"
//        dateLabel.text = "\(item.dateCreated)"
        valueField.text = numberFormatter.string(from: item?.valueInDollars as! NSNumber)
        dateLabel.text = dateFormatter.string(from: item.dateCreated as Date)
        
    }


}
