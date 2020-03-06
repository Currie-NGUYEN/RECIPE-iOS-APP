//
//  RecipeViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/5/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class RecipeViewModel {
    var name: String
    var image: String
    var type: String
    var ingredients: String
    var steps: String
    
    let recipeService = RecipeService()
    
    init(recipe:Recipe) {
        self.name = recipe.name
        self.image = recipe.imageLink
        self.type = recipe.type
        self.ingredients = recipe.ingredients
        self.steps = recipe.steps
    }
    
    static func convertToRecipe(recipeViewModel: RecipeViewModel) -> Recipe {
        return Recipe(name: recipeViewModel.name, imageLink: recipeViewModel.image, ingredients: recipeViewModel.ingredients, steps: recipeViewModel.steps, type: recipeViewModel.type)
    }
}
