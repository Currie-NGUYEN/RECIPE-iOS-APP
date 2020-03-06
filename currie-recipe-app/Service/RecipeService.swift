//
//  RecipeService.swift
//  currie-recipe-app
//
//  Created by Currie on 3/5/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation
import UIKit

protocol DeleteRecipeServiceDelegate {
    func didDeleteRecipe()
}

protocol UpdateRecipeServiceDelegate {
    func didUpdateRecipe()
}


class RecipeService {
    
    //MARK: properties
    let defaults = UserDefaults.standard
    let jsonDecoder = JSONDecoder()
    let jsonEncoder = JSONEncoder()
    
    var deleteRecipeServiceDelegate: DeleteRecipeServiceDelegate?
    var updateRecipeServiceDelegate: UpdateRecipeServiceDelegate?
    
    //MARK: handler
    func read() -> [RecipeViewModel] {
        let data = defaults.object(forKey: "recipes")
        if(data != nil){
            do{
                let value = try jsonDecoder.decode([Recipe].self, from: data as! Data)
                let valueConvert = value.map{RecipeViewModel(recipe: $0)}
                return valueConvert
            } catch let e{
                print(e)
            }
        }
        return []
    }
    
    func save(recipe: RecipeViewModel) {
        var recipes = read()
        recipes.append(recipe)
        do{
            let recipesConvert = recipes.map{RecipeViewModel.convertToRecipe(recipeViewModel: $0)}
            let value = try jsonEncoder.encode(recipesConvert)
            defaults.set(value, forKey: "recipes")
        } catch let e{
            print(e)
        }
    }
    
    func delete(recipeDelete: RecipeViewModel) {
        var recipesVM = read()
        var i = 0
        for recipe in recipesVM {
            if recipe.name == recipeDelete.name {
                recipesVM.remove(at: i)
                break
            }
            i += 1
        }
        updateListRecipes(recipesVM: recipesVM)
        deleteRecipeServiceDelegate?.didDeleteRecipe()
    }
    
    func updateListRecipes(recipesVM: [RecipeViewModel]) {
        do{
            let recipesConvert = recipesVM.map{RecipeViewModel.convertToRecipe(recipeViewModel: $0)}
            let value = try jsonEncoder.encode(recipesConvert)
            defaults.set(value, forKey: "recipes")
        } catch let e{
            print(e)
        }
    }
    
    func update(recipeUpdate: RecipeViewModel) {
        var recipesVM = read()
        print(recipeUpdate.name)
        var i = 0
        print()
        for recipe in recipesVM {
            if recipe.name == recipeUpdate.name {
                recipesVM[i] = recipeUpdate
                print(recipesVM[i].ingredients)
                break
            }
            i += 1
        }
        updateListRecipes(recipesVM: recipesVM)
        updateRecipeServiceDelegate?.didUpdateRecipe()
    }
}
