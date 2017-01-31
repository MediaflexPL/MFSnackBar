//
//  MFSnackBarView.swift
//  Pods
//
//  Created by Jakub Darowski on 13.01.2017.
//
//

import UIKit
import Stevia

public class MFSnackBarView: UIView {

    var hasAccessory        : Bool = false
    var hasText             : Bool = false
    var hasButton           : Bool = false
    var hasBlur             : Bool = false
    
    var isConfigured        : Bool = false
    
    var leftAccessoryView   : UIView? {
        didSet {
            if leftAccessoryView == nil {
                hasAccessory = false
            } else {
                hasAccessory = true
            }
        }
    }
    
    var textLabel           : UILabel = UILabel()
    var text                : String? {
        didSet {
            if text == nil {
                hasText = false
            } else {
                hasText = true
                textLabel.text(text!)
            }
        }
    }
    
    var rightButton         : UIButton = UIButton(type: .roundedRect)
    var rightButtonAction   : ((MFSnackBarView?) -> Void)?
    var rightButtonText     : String? {
        didSet {
            if rightButtonText == nil {
                hasButton = false
            } else {
                hasButton = true
                rightButton.text(rightButtonText!)
            }
        }
    }
    
    var dismissAction       : ((MFSnackBarView?) -> Void)?
    
    var blurView            : UIVisualEffectView = UIVisualEffectView()
    
    var sideMargin   : CGFloat = 0.0
    var topMargin    : CGFloat = 0.0
    var cornerRadius : CGFloat = 0.0
    var topInset     : CGFloat = 0.0
    
    
    var blurEffect   : UIVisualEffect? {
        didSet {
            if blurEffect == nil {
                hasBlur = false
            } else {
                hasBlur = true
                blurView.effect = blurEffect
            }
        }
    }
    
    public func setMessage(message: String) {
        text = message
    }
    
    public func appendMessage(message: String) {
        if text != nil {
            text = text! + message
        } else {
            text = message
        }
    }
    
    @objc private func buttonPressed(sender: UIButton?) {
        rightButtonAction?(self)
    }
    
    private func configureBlur() {
        blurView.frame = self.bounds
        blurView.top(0.0).right(0.0).bottom(0.0).right(0.0)
        blurView.backgroundColor = UIColor.clear
        sendSubview(toBack: blurView)
    }
    
    private func configureTextLabel( ){
        if topInset > 0.0 {
            textLabel.top(topInset)
        } else {
            textLabel.top(8.0)
        }
        textLabel.bottom(8.0)
        textLabel.numberOfLines = 0
        textLabel.setContentCompressionResistancePriority(1000, for: .vertical)
        textLabel.setContentHuggingPriority(1, for: .vertical)
        textLabel.font = UIFont.systemFont(ofSize: 14.0)
    }
    
    private func centerViews() {
        leftAccessoryView?.centerVertically()
        if hasText {
            //textLabel.centerVertically()
        }
        
        if hasButton {
            rightButton.centerVertically(topInset*0.5)
        }
    }
    
    private func configureButton() {
        if hasButton {
            rightButton.setContentCompressionResistancePriority(1000.0, for: .horizontal)
            if let actions = rightButton.actions(forTarget: self, forControlEvent: .touchUpInside), actions.count > 0 {
                return
            }
            rightButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        }
    }
    
    func configureView() {
        if !isConfigured {
            isConfigured = true
            layer.cornerRadius = cornerRadius
            
            if hasAccessory {
                if hasText {
                    if hasButton {
                        if hasBlur {
                            // accessory && text && button && blur
                            sv(leftAccessoryView!, textLabel.text(text!), rightButton.text(rightButtonText!), blurView)
                            configureBlur()
                            
                            layout(|-8-leftAccessoryView!-8-textLabel-8-rightButton-8-|)
                            configureTextLabel()
                            centerViews()
                            
                        } else {
                            // accessory && text && button
                            sv(leftAccessoryView!, textLabel.text(text!), rightButton.text(rightButtonText!))
                            
                            layout(|-8-leftAccessoryView!-8-textLabel-8-rightButton-8-|)
                            configureTextLabel()
                            centerViews()
                            
                        }
                        configureButton()
                    } else {
                        if hasBlur {
                            // accessory && text && blur
                            sv(leftAccessoryView!, textLabel.text(text!), blurView)
                            configureBlur()
                            
                            layout(|-8-leftAccessoryView!-8-textLabel-8-|)
                            configureTextLabel()
                            centerViews()
                            
                        } else {
                            // accessory && text
                            sv(leftAccessoryView!, textLabel.text(text!))
                            
                            layout(|-8-leftAccessoryView!-8-textLabel-8-|)
                            configureTextLabel()
                            centerViews()
                            
                        }
                    }
                } else {
                    if hasButton {
                        if hasBlur {
                            // accessory && button && blur
                            sv(leftAccessoryView!, rightButton.text(rightButtonText!), blurView)
                            configureBlur()
                            
                            layout(|-8-leftAccessoryView!-8-rightButton-8-|)
                            centerViews()
                            
                        } else {
                            // accessory && button
                            sv(leftAccessoryView!, rightButton.text(rightButtonText!))
                            
                            layout(|-8-leftAccessoryView!-8-rightButton-8-|)
                            centerViews()
                            
                        }
                        configureButton()
                    } else {
                        if hasBlur {
                            // accessory && blur
                            sv(leftAccessoryView!, blurView)
                            configureBlur()
                            
                            layout(|-8-leftAccessoryView!-8-|)
                            centerViews()
                            
                        } else {
                            // accessory
                            sv(leftAccessoryView!)
                            
                            layout(|-8-leftAccessoryView!-8-|)
                            centerViews()
                            
                        }
                    }
                }
            } else {
                if hasText {
                    if hasButton {
                        if hasBlur {
                            // text && button && blur
                            sv(textLabel.text(text!), rightButton.text(rightButtonText!), blurView)
                            configureBlur()
                            
                            layout(|-8-textLabel-8-rightButton-8-|)
                            configureTextLabel()
                            centerViews()
                            
                        } else {
                            // text && button
                            sv(textLabel.text(text!), rightButton.text(rightButtonText!))
                            
                            layout(|-8-textLabel-8-rightButton-8-|)
                            configureTextLabel()
                            centerViews()
                            
                        }
                        configureButton()
                    } else {
                        if hasBlur {
                            // text && blur
                            sv(textLabel.text(text!), blurView)
                            configureBlur()
                            
                            layout(|-8-textLabel-8-|)
                            configureTextLabel()
                            centerViews()
                            
                        } else {
                            // text
                            sv(textLabel.text(text!))
                            
                            layout(|-8-textLabel-8-|)
                            configureTextLabel()
                            centerViews()
                            
                        }
                    }
                } else {
                    if hasButton {
                        if hasBlur {
                            // button && blur
                            sv(rightButton.text(rightButtonText!), blurView)
                            configureBlur()
                            
                            layout(|-8-rightButton-8-|)
                            centerViews()
                            
                        } else {
                            // button
                            sv(rightButton.text(rightButtonText!))
                            
                            layout(|-8-rightButton-8-|)
                            centerViews()
                            
                        }
                        configureButton()
                    }
                }
            }
            
            superview?.layout(|-sideMargin-self-sideMargin-|)
            self.top(topMargin)
        }
    }
    
}
