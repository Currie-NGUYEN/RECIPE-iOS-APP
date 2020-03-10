//
//  AddRecipeViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/9/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation
import Resolver

protocol  AddRecipeViewModelDelegate{
    func didAddRecipe()
}

class AddRecipeViewModel {
    
    //MARK: properties
    @Injected var recipeService: RecipeServiceProtocol
    var addRecipeViewModelDelegate:AddRecipeViewModelDelegate?
    
    //MARK: handler
    func addRecipe(recipe: RecipeViewModel) {
        recipeService.save(recipe: recipe)
        addRecipeViewModelDelegate?.didAddRecipe()
    }
}
