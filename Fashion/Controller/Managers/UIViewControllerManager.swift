//
//  UIViewControllerManager.swift
//  Fashion
//
//  Created by Ahmed Yamany on 21/09/2022.
//

import UIKit

class UIViewControllerManager{
    let viewController: UIViewController
    
    init(viewContoller: UIViewController) {
        self.viewController = viewContoller
    }
    
     func selectNextTextFieldByTagOrEndEditing(_ textField: UITextField){
        let nextTFTag = textField.tag + 1
         guard let nextTextField = getViewByTag(nextTFTag) as? UITextField else{
             self.endEditing()
            return
        }
        nextTextField.becomeFirstResponder()
    }
    

    private func getViewByTag(_ tag: Int) -> UIView?{
        return self.viewController.view.viewWithTag(tag)
    }
    
    @objc private func endEditing(){
        self.viewController.view.endEditing(true)

    }
   
    
}
