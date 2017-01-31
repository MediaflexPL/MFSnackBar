//
//  ViewController.swift
//  MFSnackBar
//
//  Created by Jakub Darowski on 01/13/2017.
//  Copyright (c) 2017 Jakub Darowski. All rights reserved.
//

import UIKit
import MFSnackBar

class ViewController: UIViewController {
    var snackBar : MFSnackBarViewController?
    
    var shouldUseSnackBarWindow = true
    
    var animationDuration : TimeInterval = 0.0 {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.animationDurationLabel.text = String(format: "%.1lf", self.animationDuration)
            }
        }
    }
    
    @IBOutlet weak var animationDurationSlider: UISlider!
    @IBOutlet weak var animationDurationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        snackBar = MFSnackBarViewController()
        snackBar?.configureSnackbar(withMessage: "Supeeer uaoeiaeoiaoe duidy,.uikj dhfydihdihfyg hfygphdi ihd deuod pyeou", buttonText: "Okeej", dismissAction: { view in print("dismiss")}, buttonAction:  { view in print("button"); view?.appendMessage(message: " more")} )
        let snackBarViewConfigurator = MFSnackBarViewConfigurator()
        if !shouldUseSnackBarWindow {
            snackBarViewConfigurator.topMargin = (self.navigationController?.navigationBar.frame.size.height ?? 0) + snackBarViewConfigurator.topMargin
            snackBarViewConfigurator.sideMargin = 0.0
            snackBarViewConfigurator.cornerRadius = 0.0
        }
        snackBar?.snackBarConfigurator = snackBarViewConfigurator
        
        animationDuration = 0.2
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showSnackBarButtonPressed(_ sender: Any) {
        if shouldUseSnackBarWindow {
            snackBar?.showView(animated: true, animationDuration)
        } else {
            snackBar?.showView(animated: true, animationDuration, inView: self.view)
        }

    }
    
    @IBAction func hideSnackBarButtonPressed(_ sender: Any) {
        snackBar?.hideView(animated: true, animationDuration)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        animationDuration = round(TimeInterval(sender.value) * 10.0) * 0.1
    }
    
    @IBAction func closeViewButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
