//
//  RecipeService.swift
//  currie-recipe-app
//
//  Created by Currie on 3/5/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation
import UIKit

class RecipeService {
    
    //MARK: properties
    let defaults = UserDefaults.standard
    let jsonDecoder = JSONDecoder()
    let jsonEncoder = JSONEncoder()
    
    //MARK: handler
    func read() -> [Recipe] {
        let data = defaults.object(forKey: "recipes")
        if(data != nil){
            do{
                let value = try jsonDecoder.decode([Recipe].self, from: data as! Data)
                return value
            } catch let e{
                print(e)
            }
        }
        return []
    }
    
    func save(recipes: [Recipe]) {
        do{
            let value = try jsonEncoder.encode(recipes)
            defaults.set(value, forKey: "recipes")
        } catch let e{
            print(e)
        }
    }
}
