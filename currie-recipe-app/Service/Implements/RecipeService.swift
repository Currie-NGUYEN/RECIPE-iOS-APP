//
//  RecipeService.swift
//  currie-recipe-app
//
//  Created by Currie on 3/5/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation
import UIKit

class RecipeService: RecipeServiceProtocol {
    
    //MARK: properties
    let defaults = UserDefaults.standard
    let jsonDecoder = JSONDecoder()
    let jsonEncoder = JSONEncoder()
    
    
    
    //MARK: handler
    func read(filterType: String?) -> [RecipeViewModel] {
        let data = defaults.object(forKey: "recipes")
        if(data != nil){
            do{
                let value = try jsonDecoder.decode([Recipe].self, from: data as! Data)
                var valueConvert:[RecipeViewModel]
                if(filterType != nil){
                   valueConvert = value.filter{$0.type == filterType}.map{RecipeViewModel(recipe: $0)}
                } else {
                    valueConvert = value.map{RecipeViewModel(recipe: $0)}
                }
                return valueConvert
            } catch let e{
                print(e)
            }
        }
        return []
    }
    
    func save(recipe: RecipeViewModel) {
        var recipes = read(filterType: nil)
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
        var recipesVM = read(filterType: nil)
        var i = 0
        for recipe in recipesVM {
            if recipe.name == recipeDelete.name {
                recipesVM.remove(at: i)
                break
            }
            i += 1
        }
        updateListRecipes(recipesVM: recipesVM)
//        deleteRecipeServiceDelegate?.didDeleteRecipe()
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
        var recipesVM = read(filterType: nil)
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
//        updateRecipeServiceDelegate?.didUpdateRecipe()
    }
}

