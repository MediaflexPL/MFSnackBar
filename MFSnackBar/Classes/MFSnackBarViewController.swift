//
//  MFSnackBarViewController.swift
//  Pods
//
//  Created by Jakub Darowski on 13.01.2017.
//
//

import UIKit
import Stevia



public class MFSnackBarViewController: UIViewController {

    @IBOutlet var snackBarView: MFSnackBarView!
    
    var snackBarWindow = MFSnackBarWindow(frame: UIScreen.main.bounds)
    
    var isBeingShown = false
    var isLayedOut = false
    
    public var snackBarConfigurator : MFSnackBarViewConfigurator?
    
    public init () {
        let bundle = Bundle(for: MFSnackBarViewController.self)
        super.init(nibName: "MFSnackBarViewController", bundle: bundle)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
//    public func init(with: )
    public func configureSnackbar(withMessage message: String?=nil, buttonText: String?=nil, dismissAction: ((MFSnackBarView?) -> Void)?=nil, buttonAction: ((MFSnackBarView?) -> Void)?=nil)  {
        let _ = view
        
        snackBarView.text = message
        snackBarView.rightButtonText = buttonText
        snackBarView.dismissAction = dismissAction
        snackBarView.rightButtonAction = buttonAction
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        snackBarWindow.backgroundColor = UIColor.clear
        snackBarWindow.rootViewController = self
        snackBarWindow.windowLevel = UIWindowLevelStatusBar
        snackBarWindow.isHidden = true
        
        if snackBarConfigurator == nil {
            snackBarConfigurator = MFSnackBarViewConfigurator()
        }
        
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    public func showView(animated : Bool = true, _ duration : TimeInterval = 0.2, inView parentView: UIView?=nil) {
        let _ = self.view
        
        var destinationView : UIView
        if parentView != nil {
            destinationView = parentView!
        } else {
            destinationView = snackBarWindow
        }
        if !isBeingShown {
            isBeingShown = true;
            snackBarConfigurator?.configure(snackBarView: snackBarView)
            snackBarView.configureView()
            
            if !isLayedOut {
                
                destinationView.sv(snackBarView)
                destinationView.layout(|-snackBarView.sideMargin-snackBarView-snackBarView.sideMargin-|)
                snackBarView.top(snackBarView.topMargin)
                destinationView.layoutIfNeeded()
                isLayedOut = true
                
            }
            
            
            let height = view.frame.size.height
            
            snackBarView.topConstraint?.constant = -height
            destinationView.layoutIfNeeded()
            
            snackBarWindow.isHidden = false
            
            snackBarView.topConstraint?.constant = snackBarView.topMargin

            if animated {
                UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseOut], animations: {
                    destinationView.layoutIfNeeded()
                })
            } else {
                destinationView.layoutIfNeeded()
            }
        }
        
    }
    
    public func hideView(animated : Bool = true, _ duration : TimeInterval = 0.2) {
        if isBeingShown {
            
            self.view.topConstraint?.constant = -self.view.frame.size.height
            if animated {
                UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseIn], animations: {
                    self.snackBarView.superview?.layoutIfNeeded()
                }, completion: { (complete) in
                    self.snackBarWindow.isHidden = true
                    self.snackBarView.dismissAction?(self.snackBarView)
                })

            } else {
                self.snackBarWindow.isHidden = true
                self.snackBarView.dismissAction?(self.snackBarView)
            }
            isBeingShown = false
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideView()
    }
}
