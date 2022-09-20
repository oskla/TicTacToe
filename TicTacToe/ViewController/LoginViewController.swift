//
//  LoginViewController.swift
//  TicTacToe
//
//  Created by Oskar Larsson on 2022-09-09.
//

import UIKit


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

class LoginViewController: UIViewController {

    
    @IBOutlet weak var inputPlayer1: UITextField!
    @IBOutlet weak var inputPlayer2: UITextField!
    
    @IBOutlet weak var viewMultiplayer: UIView!
    
    let loginToGameSegue = "loginToGameSegue"
    var isComputer = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let clearButton = inputPlayer1.value(forKeyPath: "_clearButton") as? UIButton {
                    clearButton.setImage(UIImage(named:"erase"), for: .normal)
                }
        if let clearButton = inputPlayer2.value(forKeyPath: "_clearButton") as? UIButton {
                    clearButton.setImage(UIImage(named:"erase"), for: .normal)
                }

        inputPlayer1.setLeftPaddingPoints(7)
        inputPlayer2.setLeftPaddingPoints(7)
 
      // viewMultiplayer.backgroundColor = UIColor(patternImage: UIImage(named: "inputfield")!)
        

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onSwitch(_ sender: Any) {
        
        if isComputer == true {
            isComputer = false
            inputPlayer2.isHidden = false
        } else {
            isComputer = true
            inputPlayer2.isHidden = true
        }
        
        
        
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
                destinationVC.isComputer = self.isComputer
            }
        }
        
        
//        let destinationVC = segue.destination as! LoginViewController
       
        
//        guard let name1 = inputPlayer1.text else {
//            destinationVC.passed = true
//            return
//        }
      
        
    }
    

}
