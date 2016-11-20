//
//  RegisterViewController.swift
//  CharityCache
//
//  Created by Aditya Koukuntla on 11/19/16.
//  Copyright © 2016 CharityCache. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func registerClicked(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "toTypeSelect", sender: self)

    }

    @IBAction func backClicked(_ sender: AnyObject) {
       _ = self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
