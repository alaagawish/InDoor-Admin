//
//  LaunchScreenViewController.swift
//  InDoor-Admin
//
//  Created by Ahmed on 19/06/2023.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var adminLabel: UILabel!
    @IBOutlet weak var startAnimation: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        startAnimation.contentMode = .scaleAspectFit
        startAnimation.loopMode = .playOnce
        startAnimation.animationSpeed = 0.5
        startAnimation.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.adminLabel.isHidden = false
            self?.startAnimation.pause()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                let tabBar = self?.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                self?.navigationController?.pushViewController(tabBar, animated: true)
            }
        }
    }

}
