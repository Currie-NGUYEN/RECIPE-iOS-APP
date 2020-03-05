//
//  AddItemViewController.swift
//  currie-recipe-app
//
//  Created by Currie on 3/2/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: properties
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var imageLink: UITextField!
    @IBOutlet weak var nameRecipe: UITextField!
    @IBOutlet weak var ingredients: UITextField!
    @IBOutlet weak var steps: UITextView!
    
    var recipeTypes: [RecipeType] = []
    var type: String = ""
    var recipes: [Recipe] = []
    
    let recipeService = RecipeService()
    let recipeTypeService = RecipeTypeService()
    
    //MARK: init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipes = recipeService.read()
        picker.dataSource = self
        picker.delegate = self
        recipeTypes = recipeTypeService.getAllRecipeType()
    }
    
    //MARK: handler
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
//        print(recipeTypes[row].name)
        self.type = recipeTypes[row].name
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let recipe = Recipe(name: nameRecipe.text!, imageLink: imageLink.text!, ingredients: ingredients.text!, steps: steps.text!, type: self.type)
        recipes.append(recipe)
        recipeService.save(recipes: recipes)
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


