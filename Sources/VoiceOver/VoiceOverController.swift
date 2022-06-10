//
//  VoiceOverViewModel.swift
//  CleanSlate
//
//  Created by Carlos Andres Chaguendo Sanchez on 9/06/22.
//

import Dynamic
import Foundation
import UIKit

internal class VoiceOverController: ObservableObject {
    
    private(set) var isVoiceOverRunning = UIAccessibility.isVoiceOverRunning
    
    internal init() {
        guard
            let clazz = NSClassFromString("UIView").self,
            let path = Bundle(for:  clazz).privateFrameworksPath else {
            return
        }
        
        let base = path.replacingOccurrences(of: "/UIKitCore.framework/Frameworks", with: "")
        print(base)
        print(Bundle(path: "\(base)/VoiceServices.framework")?.load())
        print(Bundle(path: "\(base)/VoiceOverServices.framework")?.load())
        print(Bundle(path: "\(base)/UIAccessibility.framework")?.load())
        print(Bundle(path: "\(base)/AccessibilityUtilities.framework")?.load())
    }
    
    func toggleVoiceOver() {
        isVoiceOverRunning.toggle()
        Dynamic.AXSettings.sharedInstance.setVoiceOverEnabled(isVoiceOverRunning)
        
        Dynamic.VOSCommandManager().loadShortcuts
        Dynamic.VOSCommandManager().allBuiltInCommands.asString
        Dynamic.VOSCommandManager().activeProfile
    }
    
}

