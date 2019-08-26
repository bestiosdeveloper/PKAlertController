//
//  PKAlertController.swift
//
//  Created by Pramod Kumar on 16/01/19.
//  Copyright © 2019 Pramod Kumar. All rights reserved.
//

import UIKit

open class PKAlertController {

    //MARK:- Properties
    //MARK:- Public
    static let `default` = PKAlertController()
    
    //MARK:- Private
    private var topMostController: UIViewController? {
        
        var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentedVC?.presentedViewController
        {
            presentedVC = pVC
        }
        
        if presentedVC == nil {
             printDebug("PKAlertController Error: You don't have any views set. You may be calling in viewdidload. Try viewdidappear.")
        }
        return presentedVC
    }
    
    private var alertController: UIAlertController!
    
    //MARK:- ViewLifeCycle
    //MARK:-
    private init() {}
    
    //MARK:- Methods
    //MARK:- Private
    private func getAttributedString(string: String, font: UIFont?, color: UIColor?) -> NSMutableAttributedString {
        
        let myMutableString = NSMutableAttributedString(string: string)
        
        let range = NSRange(location: 0, length: string.count)
        if let fnt = font {
            myMutableString.addAttributes([NSAttributedString.Key.font : fnt], range: range)
        }
        
        if let clr = color {
            myMutableString.addAttributes([NSAttributedString.Key.foregroundColor : clr], range: range)
        }
        
        return myMutableString
    }
    private func changeControllerTitle(title: String?, font: UIFont?, color: UIColor?) {
        
        // Change Title With Color and Font:
        guard let str = title else {return}
        alertController.setValue(self.getAttributedString(string: str, font: font, color: color), forKey: "attributedTitle")
    }
    
    private func changeControllerMessage(message: String?, font: UIFont?, color: UIColor?) {
        
        // Change Message With Color and Font:
        guard let str = message else {return}
        alertController.setValue(self.getAttributedString(string: str, font: font, color: color), forKey: "attributedMessage")
    }
    
    private func configureAlertAction(action: UIAlertAction, withData data: PKAlertButton) {
        action.setValue(data.titleColor, forKey: "titleTextColor")
    }
    
    //MARK:- Public
    func presentActionSheet(_ title: String?, titleFont: UIFont? = nil, titleColor: UIColor? = nil, message: String?, messageFont: UIFont? = AppFonts.SemiBold.withSize(14.0), messageColor: UIColor? = AppColors.themeGray40, sourceView: UIView, alertButtons: [PKAlertButton], cancelButton: PKAlertButton, tapBlock:((UIAlertAction,Int) -> Void)?) -> UIAlertController {
        
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        self.changeControllerTitle(title: title, font: titleFont, color: titleColor)
        self.changeControllerMessage(message: message, font: messageFont, color: messageColor)
        
        //add all alert buttons
        let closure: (UIAlertAction) -> Void = { (alert) in
            printDebug(alert.title ?? "")
            if let handel = tapBlock, let idx = alertButtons.firstIndex(where: { (button) -> Bool in
                (alert.title ?? "") == button.title
            }) {
                handel(alert, idx)
            }
        }
        
        for button in alertButtons {
            let alertAction = UIAlertAction(title: button.title, style: .default, handler: closure)
            self.configureAlertAction(action: alertAction, withData: button)
            alertController.addAction(alertAction)
        }
        
        //add cancel button
        let cancelAction = UIAlertAction(title: cancelButton.title, style: .cancel) { (alert) in
            self.dismissActionSheet()
        }
        self.configureAlertAction(action: cancelAction, withData: cancelButton)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = sourceView
        alertController.popoverPresentationController?.sourceRect = sourceView.bounds
        self.topMostController?.present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    //MARK:- Public
    func presentActionSheetWithTextAllignMentAndImage(_ title: String?, message: String?, sourceView: UIView, alertButtons: [PKAlertButton], cancelButton: PKAlertButton, textAlignment: CATextLayerAlignmentMode = CATextLayerAlignmentMode.center , selectedButtonIndex: Int? = 0 , tapBlock:((UIAlertAction,Int) -> Void)?) -> UIAlertController {
        
        alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        //add all alert buttons
        let closure: (UIAlertAction) -> Void = { (alert) in
            printDebug(alert.title ?? "")
            if let handel = tapBlock, let idx = alertButtons.firstIndex(where: { (button) -> Bool in
                (alert.title ?? "") == button.title
            }) {
                handel(alert, idx)
            }
        }
        
        for (index,button) in alertButtons.enumerated() {
            let alertAction = UIAlertAction(title: button.title, style: .default, handler: closure)
            alertAction.setValue(button.titleColor, forKey: "titleTextColor")
//            alertAction.setValue(textAlignment, forKey: "titleTextAlignment")
            if index == selectedButtonIndex {
                alertAction.setValue(#imageLiteral(resourceName: "buttonCheckIcon"), forKey: "image")
            } else {
                alertAction.setValue(nil, forKey: "image")
            }
            alertController.addAction(alertAction)
        }
        
        //add cancel button
        let cancelAction = UIAlertAction(title: cancelButton.title, style: .cancel) { (alert) in
            self.dismissActionSheet()
        }
        cancelAction.setValue(cancelButton.titleColor, forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = sourceView
        alertController.popoverPresentationController?.sourceRect = sourceView.bounds
        self.topMostController?.present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    func presentActionSheetWithAttributed(_ title: NSMutableAttributedString?, message: NSMutableAttributedString?, sourceView: UIView, alertButtons: [PKAlertButton], cancelButton: PKAlertButton, tapBlock:((UIAlertAction,Int) -> Void)?) -> UIAlertController {
        alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alertController.setValue(title, forKey: "attributedTitle")
        alertController.setValue(message, forKey: "attributedMessage")
        //add all alert buttons
        let closure: (UIAlertAction) -> Void = { (alert) in
            printDebug(alert.title ?? "")
            if let handel = tapBlock, let idx = alertButtons.firstIndex(where: { (button) -> Bool in
                (alert.title ?? "") == button.title
            }) {
                handel(alert, idx)
            }
        }
        for button in alertButtons {
            let alertAction = UIAlertAction(title: button.title, style: .default, handler: closure)
            alertAction.setValue(button.titleColor, forKey: "titleTextColor")
            alertController.addAction(alertAction)
        }
        
        //add cancel button
        let cancelAction = UIAlertAction(title: cancelButton.title, style: .cancel) { (alert) in
            self.dismissActionSheet()
        }
        cancelAction.setValue(cancelButton.titleColor, forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = sourceView
        alertController.popoverPresentationController?.sourceRect = sourceView.bounds
        self.topMostController?.present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    public func dismissActionSheet() {
        self.alertController.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Action
}
