//
//  RoundedCornerView.swift
//  WeatherApp
//
//  Created by Tolgahan Sonmez on 15.03.2023.
//

import UIKit

class RoundedCornerView: UIView {

    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
           didSet {
               layer.borderWidth = borderWidth
           }
       }
       
       @IBInspectable var borderColor: UIColor? {
           didSet {
               layer.borderColor = borderColor?.cgColor
           }
       }
}

class CornerRadiusView : UISearchBar {
    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
           didSet {
               layer.borderWidth = borderWidth
           }
       }
       
       @IBInspectable var borderColor: UIColor? {
           didSet {
               layer.borderColor = borderColor?.cgColor
           }
       }
}


