//
//  DetailRecipeViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/9/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation
import Resolver

class DetailRecipeViewModel {
    
    //MARK: properties
    @Injected var recipeService: RecipeServiceProtocol
    
    //MARK: handler
    func getDetailRecipe(name: String) -> RecipeViewModel? {
        for recipe in recipeService.read(filterType: nil){
            if recipe.name == name {
                return recipe
            }
        }
        return nil
    }
}
