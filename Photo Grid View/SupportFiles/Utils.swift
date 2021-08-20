//
//  Utils.swift
//  Photo Grid View
//
//  Created by Surya Pratap Singh on 18/08/21.
//

import UIKit
import SVProgressHUD

class Utils {
    func ShowLoader() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
            SVProgressHUD.setBorderColor(UIColor.black)
            SVProgressHUD.setForegroundColor(UIColor.black)
            SVProgressHUD.setBackgroundColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        }
    }

    func HideLoader() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss(withDelay: 0.1)
        }
    }
}


