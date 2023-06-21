//
//  LaunchScreenViewController.swift
//  InDoor-Admin
//
//  Created by Ahmed on 19/06/2023.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNametextField: UITextField!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var adminLabel: UILabel!
    @IBOutlet weak var startAnimation: LottieAnimationView!
    var userDefaults = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults.setValue(Constants.userName, forKey: Constants.user)
        userDefaults.setValue(Constants.password, forKey: Constants.pass)
        loginView.isHidden = true
        startAnimation.contentMode = .scaleAspectFit
        startAnimation.loopMode = .playOnce
        startAnimation.animationSpeed = 0.5
        startAnimation.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            self?.adminLabel.isHidden = false
            self?.startAnimation.pause()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.startAnimation.isHidden = true
                self?.adminLabel.isHidden = true
                self?.loginView.isHidden = false
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }

    @IBAction func Login(_ sender: Any) {
        if userDefaults.string(forKey: Constants.user) ?? "" == userNametextField.text! && userDefaults.string(forKey: Constants.pass) ?? "" == passwordTextField.text {
            let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
            self.navigationController?.pushViewController(tabBar, animated: true)
        }else{
            let alert = UIAlertController(title: Constants.error, message: Constants.wrongCredentials, preferredStyle: .alert)
            let ok = UIAlertAction(title: Constants.ok, style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
}
