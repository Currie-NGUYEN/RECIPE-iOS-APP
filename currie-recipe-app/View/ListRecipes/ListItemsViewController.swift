//
//  ViewController.swift
//  currie-recipe-app
//
//  Created by Currie on 3/2/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import UIKit

class ListItemsController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var listItems: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData:[String] = [String]()
    var recipesVM:[RecipeViewModel] = []
    var recipesFilterVM: [RecipeViewModel] = []
    var recipeTypes: [RecipeType] = []
    var currentType = "All"
    
    let recipeService = RecipeService()
    let recipeTypeService = RecipeTypeService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recipesVM = recipeService.read().map({return RecipeViewModel(recipe: $0)})
        listItems.delegate = self
        listItems.dataSource = self
        listItems.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        recipeTypes.append(RecipeType(name: "All"))
        recipeTypes.append(contentsOf: recipeTypeService.getAllRecipeType())
        
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        filterRecipes(type: currentType)
        // Do any additional setup after loading the view.
    }
    func filterRecipes(type:String) {
        if( type != "All"){
            self.recipesFilterVM = recipesVM.filter {$0.type == type}
        }else{
            self.recipesFilterVM = recipesVM
        }
        
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
    //        print(recipeTypes[row].name)
            self.currentType = recipeTypes[row].name
            filterRecipes(type: currentType)
            listItems.reloadData()
        }

    
    
    override func viewDidAppear(_ animated: Bool) {
        self.recipesVM = recipeService.read().map({return RecipeViewModel(recipe: $0)})
        filterRecipes(type: currentType)
        listItems.reloadData()
    }
    
}

extension ListItemsController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let viewController = storyboard?.instantiateViewController(identifier: "DetailItem") else {
            return
        }
        viewController.title = recipesFilterVM[indexPath.row].name
        navigationController?.pushViewController(viewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ListItemsController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesFilterVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ItemTableViewCell
        let recipeViewModel = recipesVM[indexPath.row]
        cell.recipeViewModel = recipeViewModel
        return cell
    }
    
}
