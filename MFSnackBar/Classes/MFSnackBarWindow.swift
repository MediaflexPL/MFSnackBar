//
//  MFSnackBarWindow.swift
//  Pods
//
//  Created by Jakub Darowski on 19.01.2017.
//
//

import UIKit

class MFSnackBarWindow: UIWindow {

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view: UIView in subviews {
            if view.point(inside: point, with: event) {
                return true
            }
        }
        return false
    }

}
