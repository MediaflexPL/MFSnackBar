//
//  MFSnackBarViewConfigurator.swift
//  Pods
//
//  Created by Jakub Darowski on 20.01.2017.
//
//

import UIKit

public class MFSnackBarViewConfigurator: NSObject {
    public var sideMargin       : CGFloat = 8.0
    public var topMargin        : CGFloat = 20.0
    public var cornerRadius     : CGFloat = 4.0
    public var topInset         : CGFloat = 0.0
    public var backgroundColor  : UIColor = UIColor.black.withAlphaComponent(0.1)
    public var blurEffect       : UIVisualEffect? = UIBlurEffect(style: .light)
    
    public func configure(snackBarView view: MFSnackBarView) {
        view.sideMargin = sideMargin
        view.topMargin = topMargin
        view.cornerRadius = cornerRadius
        view.topInset = topInset
        view.backgroundColor = backgroundColor
        view.blurEffect = blurEffect
    }
}
