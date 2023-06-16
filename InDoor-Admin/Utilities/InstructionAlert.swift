//
//  InstructionAlert.swift
//  InDoor-Admin
//
//  Created by Ahmed on 16/06/2023.
//

import UIKit

class InstructionAlert {
    static func presentAlert(vc:UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: Constants.ok, style: .default)
        alert.addAction(action)
        vc.present(alert , animated: true)
    }
}
