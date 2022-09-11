//
//  LoginViewController.swift
//  TicTacToe
//
//  Created by Oskar Larsson on 2022-09-09.
//

import UIKit

class LoginViewController: UIViewController{

    
    @IBOutlet weak var inputPlayer1: UITextField!
    @IBOutlet weak var inputPlayer2: UITextField!
    
    let loginToGameSegue = "loginToGameSegue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onPressStart(_ sender: Any) {
        
       
        
    performSegue(withIdentifier: loginToGameSegue, sender: self)
        
    }
    
     //MARK: - Navigation

   //  In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       
        if segue.identifier == loginToGameSegue {
            if let destinationVC = segue.destination as? ViewController {
                destinationVC.name1 = self.inputPlayer1.text ?? ""
                destinationVC.name2 = self.inputPlayer2.text ?? ""
            }
        }
        
        
//        let destinationVC = segue.destination as! LoginViewController
       
        
//        guard let name1 = inputPlayer1.text else {
//            destinationVC.passed = true
//            return
//        }
      
        
    }
    

}
