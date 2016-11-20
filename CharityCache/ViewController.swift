//
//  ViewController.swift
//  CharityCache
//
//  Created by Aditya Koukuntla on 11/18/16.
//  Copyright © 2016 CharityCache. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var loginFieldsContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginClicked(_ sender: AnyObject) {
        self.view.endEditing(true)
        self.performSegue(withIdentifier: "toTypeSelect", sender: self)
    }
    
    @IBAction func registerClicked(_ sender: AnyObject) {
        self.view.endEditing(true)
        self.performSegue(withIdentifier: "toRegisterSegue", sender: self)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.containerBottomConstraint.constant = 300
        self.animateViews()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.containerBottomConstraint.constant = 100
        self.animateViews()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func animateViews() {
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }) 
    }
    
    
    
}

