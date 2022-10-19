//
//  UIApplication.swift
//  Exchages
//
//  Created by Dario Gallegos on 20/10/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
