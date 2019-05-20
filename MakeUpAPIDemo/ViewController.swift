//
//  ViewController.swift
//  MakeUpAPIDemo
//
//  Created by Joy on 2019/5/16.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {


    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    @IBOutlet weak var blueViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var blueViewLeading: NSLayoutConstraint!
    
    @IBOutlet weak var blueView: UIView!
    
    
    
    

//  該品牌所有商品
    var allString = "https://makeup-api.herokuapp.com/api/v1/products.json?brand=dior"
//  var searchString = "https://makeup-api.herokuapp.com/api/v1/products.json?brand=dior&product_type=foundation"
    
    var items = [Item]()
    var hamburgerMenuIsVisible = false
    var flag = 0            //ALL Product
    
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loading
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        
        activityIndicatorView.startAnimating()
        
        
        if let urlstring = allString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlstring) {
             let task = URLSession.shared.dataTask(with: url) { (data, reponse, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    
//                    decoder.dateDecodingStrategy = .iso8601   因為此ＡＰＩ非正規.iso8601，故直接當string
//                    do {
//                        let itemsResults = try decoder.decode([Item].self, from: data)
//                        print(itemsResults)
//                    }catch{
//                        print(error)
//                    }
//
                    
                    if let itemsResults = try? decoder.decode([Item].self, from: data) {
                        
                        self.items = itemsResults
                        self.results = self.items

                        DispatchQueue.main.async {
                            self.activityIndicatorView.removeFromSuperview()
                            self.MyCollectionView.reloadData()
//                            print("ok")
                        }
                    }else {
                        print("error")
                    }
                }else{
                    print("data not found")
                }
            }
            task.resume()
        }else {
            print("URL trans fail")
        }
        
    }
    
    
    //幾個區塊
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //區塊有幾個項目
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print("item count", items.count)
        return results.count
    }
    
    
    
     var results = [Item]()
    
    //顯示項目內容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        
        
        let item = results[indexPath.row]

        cell.itemLabel.text = item.name
        cell.itemprice.text = "$\(item.price)"
        
        let task = URLSession.shared.dataTask(with: item.image_link) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    cell.itemImageView.image = UIImage(data: data)
                }
            }
        }
        task.resume()
        
        blueViewLeading.constant = 0
        blueViewTrailing.constant = 0
        hamburgerMenuIsVisible = false
    return  cell
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = MyCollectionView.indexPathsForSelectedItems?.first
        let row = indexPath?.item //.seciton  、 .item(row)
        let controller = segue.destination as! MyLastViewController
        controller.item = results[row!]
    }
    
    

    
    @IBAction func clickhamburger(_ sender: Any) {
        
        //讓漢堡出現
        if !hamburgerMenuIsVisible {
            blueViewLeading.constant = 150
            blueViewTrailing.constant = -150
            hamburgerMenuIsVisible = true
        //讓漢堡消失
        }else {
            blueViewLeading.constant = 0
            blueViewTrailing.constant = 0
            hamburgerMenuIsVisible = false
        }
        UIView.animate(withDuration: 3, delay: 2, options: .curveEaseIn, animations: {
            self.blueView.layoutIfNeeded()
        }) { (true) in
            //..
        }
    }
    
    
    
    
    
    //foundation   nail_polish  eyebrow eyeliner mascara  eyeshadow  blush bronzer lipstick

    
    @IBAction func clickFoundation(_ sender: UIButton) {
        results = self.items.filter({ (item) -> Bool in
            return item.product_type == "foundation"
            
        })
            self.MyCollectionView.reloadData()

        
    }
    
    
    @IBAction func clickBlush(_ sender: UIButton) {
        results = self.items.filter({ (item) -> Bool in
                return item.product_type == "blush"
        })
            self.MyCollectionView.reloadData()

    }
    
    @IBAction func clickNailPolish(_ sender: UIButton) {
        results = self.items.filter({ (item) -> Bool in
            return item.product_type == "nail_polish"
            
        })
        self.MyCollectionView.reloadData()

    }
    
    @IBAction func clickEyeBrow(_ sender: UIButton) {
        results = self.items.filter({ (item) -> Bool in
            return item.product_type == "eyebrow"
            
        })
        self.MyCollectionView.reloadData()

    }
    
    
    @IBAction func clickEyeliner(_ sender: UIButton) {
        results = self.items.filter({ (item) -> Bool in
            return item.product_type == "eyeliner"
            
        })
        self.MyCollectionView.reloadData()

    }
    
    @IBAction func clickMascara(_ sender: UIButton) {
        results = self.items.filter({ (item) -> Bool in
            return item.product_type == "mascara"
            
        })
        self.MyCollectionView.reloadData()

    }
    
    @IBAction func clickEyeShadow(_ sender: UIButton) {
        results = self.items.filter({ (item) -> Bool in
            return item.product_type == "eyeshadow"
            
        })
        self.MyCollectionView.reloadData()

    }
    
    
    @IBAction func clickBronzer(_ sender: UIButton) {
        results = self.items.filter({ (item) -> Bool in
            return item.product_type == "bronzer"
            
        })
        self.MyCollectionView.reloadData()

    }
    
    
    @IBAction func clickLipStick(_ sender: UIButton) {
        results = self.items.filter({ (item) -> Bool in
            return item.product_type == "lipstick"
            
        })
        self.MyCollectionView.reloadData()

    }
    
}

