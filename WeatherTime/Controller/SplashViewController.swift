//
//  SplashViewController.swift
//  WeatherTime
//
//  Created by GAURVI SINGHAL on 28/07/24.
//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var clickSearchPressed: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            clickSearchPressed.layer.cornerRadius = 10
            clickSearchPressed.layer.masksToBounds = false
    }

}
