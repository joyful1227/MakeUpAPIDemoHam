//
//  Item.swift
//  MakeUpAPIDemo
//
//  Created by Joy on 2019/5/16.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation

struct Item: Codable {
    
    var name: String
    var product_link: URL
    var price: String
    var image_link: URL
    var product_type: String
    var description: String
    var updated_at: String //上架日期
}
