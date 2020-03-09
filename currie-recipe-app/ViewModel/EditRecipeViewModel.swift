//
//  EditRecipeViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/9/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation

protocol UpdateRecipeViewModelDelegate {
    func didUpdateRecipe()
}

class EditRecipeViewModel {
    
    //MARK: properties
    let recipeService = RecipeService()
    var updateRecipeViewModelDelegate: UpdateRecipeViewModelDelegate?
    
    //MARK: handler
    func editRecipe(recipe: RecipeViewModel) {
        recipeService.update(recipeUpdate: recipe)
        updateRecipeViewModelDelegate?.didUpdateRecipe()
    }
}
