//
//  RecipeViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/5/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation
import UIKit

class RecipeViewModel {
    var name: String
    var image: String
    var type: String
    var ingredients: String
    var steps: String
    
    init(recipe:Recipe) {
        self.name = recipe.name
        self.image = recipe.imageLink
        self.type = recipe.type
        self.ingredients = recipe.ingredients
        self.steps = recipe.steps
    }
}
