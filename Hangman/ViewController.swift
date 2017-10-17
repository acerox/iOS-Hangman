//
//  ViewController.swift
//  Hangman
//
//  Created by CETYS on 17/10/17.
//  Copyright © 2017 acerox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    let letters = ["c", "e", "t", "y", "s"]
    
    
    @IBAction func pressButton(_ sender: UIButton) {
        for letter in letters {
            if sender.currentTitle != letter {
                print("pruebna")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

