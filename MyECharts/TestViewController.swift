//
//  ViewController.swift
//  learn_codable
//
//  Created by Can Lee on 2019/9/8.
//  Copyright © 2019 Can Lee. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let json = """
        {
            "Banana": {
                "points" : 200,
                "decription": "A banana grown in Ecuador."
            },
            "Orange": {
                "points": 100
            }
        }
        """.data(using: .utf8)!
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let store = GroceyStore(products: [
            .init(name: "Grapes", points: 230, description: "A Mixture of red and green grapes"),
            .init(name: "Lemons", points: 2300, description: "An extra sour lemon")
            ])
        
        print("The result of encoding a GroceryStore:")
        let encodedStore = try! encoder.encode(store)
        print(String(data: encodedStore, encoding: .utf8)!)
        
        
        let s = SerieTest(data: ["123",1.2,"33"], name: "test")
        let sDic = s.convertToDict() ?? [:]
        print(sDic)
        
        let sDic2 = s.asDictionary
        print(sDic2)
        
//        let sDicData = try encoder.encode(sDic2)
        
        do {
            let sDic2Data = try JSONSerialization.data(withJSONObject: sDic2, options: .prettyPrinted)
            print(String(data: sDic2Data, encoding: .utf8)!)
        } catch let error {
            print(error)
        }
        
        
        do {
            let data = try encoder.encode(s)
            let string = String(data: data, encoding: .utf8)!
            print(string)
        } catch let error {
            print(error)
        }
        /*
         {
         "Grapes" : {
         "points" : 230,
         "description" : "A Mixture of red and green grapes"
         },
         "Lemons" : {
         "points" : 2300,
         "description" : "An extra sour lemon"
         }
         }
         
         */
        
        let decoder = JSONDecoder()
        do {
            let decodedStore = try decoder.decode(GroceyStore.self, from: json)
            print(decodedStore)
        } catch let error {
            //            print(error.localizedDescription)
            print(error)
        }
    }
    
    
}

struct SerieTest: Codable {
    var data: [Any]?
    var name: String?
    
    var data1: [String]?
    
    init(data: [Any]?, name: String?) {
        self.data = data
        self.name = name
        self.data1 = data as? [String]
    }
    
    enum CodingKeys:String, CodingKey {
        case data
        case name
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: CodingKeys.name)
        try container.encode(data1, forKey: CodingKeys.data)
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent([String].self, forKey: .data)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    
    func convertToDict() -> Dictionary<String, Any>? {
        var dict: Dictionary<String, Any>? = nil
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
        } catch {
            print(error)
        }
        
        return dict
    }
    var asDictionary : [String:Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(uniqueKeysWithValues: mirror.children.lazy.map({ (label:String?,value:Any) -> (String,Any)? in
            guard label != nil else { return nil }
            return (label!,value)
        }).compactMap{ $0 })
        return dict
    }
}


//MARK:
struct GroceyStore {
    struct Product {
        let name: String
        let points: Int
        let description: String?
    }
    var products: [Product]
    init(products: [Product] = []) {
        self.products = products
    }
}

extension GroceyStore: Encodable {
    struct ProductKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int? {return nil}
        init?(intValue: Int) {
            return nil
        }
        static let points = ProductKey(stringValue: "points")!
        static let description = ProductKey(stringValue: "description")!
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductKey.self)
        for product in products {
            let nameKey = ProductKey(stringValue: product.name)!
            var productContainer = container.nestedContainer(keyedBy: ProductKey.self, forKey: nameKey)
            
            try productContainer.encode(product.points, forKey: .points)
            try productContainer.encode(product.description, forKey: .description)
        }
    }
}

extension GroceyStore: Decodable {
    init(from decoder: Decoder) throws {
        var products = [Product]()
        let container = try decoder.container(keyedBy: ProductKey.self)
        for key in container.allKeys {
            let productContainer = try container.nestedContainer(keyedBy: ProductKey.self, forKey: key)
            let points = try productContainer.decode(Int.self, forKey: .points)
            let description = try productContainer.decodeIfPresent(String.self, forKey: .description)
            
            let product = Product(name: key.stringValue, points: points, description: description)
            products.append(product)
        }
        self.init(products: products)
    }
}

