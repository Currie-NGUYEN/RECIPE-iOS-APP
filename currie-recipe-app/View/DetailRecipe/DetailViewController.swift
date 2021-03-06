//
//  DetailViewController.swift
//  currie-recipe-app
//
//  Created by Currie on 3/2/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: properties
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var steps: UITextView!
    
    let detailRecipeVM = DetailRecipeViewModel()
    let deleteRecipeVM = DeleteRecipeViewModel()
    var recipe: RecipeViewModel? = nil
    var nameTitle: String? = nil
    //MARK: init

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.deleteRecipeVM.deleteRecipeViewModelDelegate = self
        
        self.nameTitle = self.title
        self.recipe = detailRecipeVM.getDetailRecipe(name: nameTitle!)!
        
        self.imageRecipe.imageFromUrl(urlString: recipe!.image)
        self.name.text = recipe!.name
        self.type.text = recipe!.type
        self.ingredients.text = recipe!.ingredients
        self.steps.text = recipe!.steps
         
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        recipe = detailRecipeVM.getDetailRecipe(name: nameTitle!)!
        self.imageRecipe.imageFromUrl(urlString: recipe!.image)
        self.name.text = recipe!.name
        self.type.text = recipe!.type
        self.ingredients.text = recipe!.ingredients
        self.steps.text = recipe!.steps
     
    }
    
    //MARK: handler
    @IBAction func deleteItem(_ sender: Any) {
        let alert = UIAlertController(title: "DELETE", message: "Are you sure to remove it?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: deleteHandler(alert:)))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    func deleteHandler(alert: UIAlertAction!) {
        deleteRecipeVM.deleteRecipe(recipe: self.recipe!)
    }
    
    @IBAction func edit(_ sender: UIButton) {
        guard let viewController = storyboard?.instantiateViewController(identifier: "EditRecipe") else {
            return
        }
        viewController.title = self.title
        navigationController?.pushViewController(viewController, animated: true)
    }

}
extension DetailViewController: DeleteRecipeViewModelDelegate{
    
    func didDeleteRecipe() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
