//
//  Recipe.swift
//  currie-recipe-app
//
//  Created by Currie on 3/2/20.
//  Copyright © 2020 Currie. All rights reserved.
//

class Recipe: Codable {
    var name: String = ""
    var imageLink: String = ""
    var ingredients: String = ""
    var steps: String = ""
    var type: String = ""
    
    init(name: String, imageLink: String, ingredients: String, steps: String, type: String) {
        self.name = name
        self.imageLink = imageLink
        self.ingredients = ingredients
        self.steps = steps
        self.type = type
    }
}
