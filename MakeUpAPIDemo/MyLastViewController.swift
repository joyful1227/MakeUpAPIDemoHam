//
//  MyLastViewController.swift
//  MakeUpAPIDemo
//
//  Created by Joy on 2019/5/17.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit
import Foundation

class MyLastViewController: UIViewController {

    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var myPriceLabel: UILabel!
    @IBOutlet weak var myDesLabel: UILabel!
    
    var item: Item?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = item {
            self.title  = item.product_type.uppercased()
            self.myNameLabel.text = "Name: \(item.name)"
            self.myPriceLabel.text = "Price: $\(item.price)"
            self.myDesLabel.text = "DesCription:\n\(item.description)"
            let task = URLSession.shared.dataTask(with: item.image_link) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.bigImageView.image = UIImage(data: data)
                    }
                }else {
                    print("data not found")
                }
            }
            task.resume()
        }else {
            print("item not found")
        }
        
        
    }
    



}
