//
//  EditViewController.swift
//  currie-recipe-app
//
//  Created by Currie on 3/2/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //MARK: properties
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var imageRecipe: UITextField!
    @IBOutlet weak var pickerType: UIPickerView!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var steps: UITextView!
    
    let recipeService = RecipeService()
    let recipeTypeService = RecipeTypeService()
    
    var recipes:[Recipe] = []
    var recipeTypes: [RecipeType] = []
    var recipeType: String = ""
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()

        let name = self.title
        pickerType.dataSource = self
        pickerType.delegate = self
        recipes = recipeService.read()
        recipeTypes = recipeTypeService.getAllRecipeType()
        for recipe in recipes {
            if recipe.name == name! {
                self.imageRecipe.text = recipe.imageLink
                self.name.text = recipe.name
                recipeType = recipe.type
                let tmpType = RecipeType(name: recipe.type)
                let defaultType = recipeTypes.lastIndex { $0.name == tmpType.name }
                self.pickerType.selectRow(defaultType ?? 0, inComponent: 0, animated: true)
                self.ingredients.text = recipe.ingredients
                self.steps.text = recipe.steps
            }
        }
    }
    
    //MARK: handler
    @IBAction func done(_ sender: UIButton) {
        var i = 0
        for recipe in recipes {
            if recipe.name == self.title {
                recipes[i].imageLink = self.imageRecipe.text!
                recipes[i].type = recipeType
                print(recipeType)
                recipes[i].ingredients = self.ingredients.text
                recipes[i].steps = self.steps.text
                break
            }
            i += 1
        }
        recipeService.save(recipes: recipes)
        navigationController?.popViewController(animated: true)
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recipeTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return recipeTypes[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.recipeType = recipeTypes[row].name
        print(recipeType)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
