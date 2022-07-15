//
//  VoiceOverViewModel.swift
//  CleanSlate
//
//  Created by Carlos Andres Chaguendo Sanchez on 9/06/22.
//

import Dynamic
import Foundation
import UIKit
import VisionKit
import Combine

internal class VoiceOverController: ObservableObject {
    @Published var isVoiceOverRunning = UIAccessibility.isVoiceOverRunning
    @Published var isReduceMotionEnabled = UIAccessibility.isReduceMotionEnabled
    @Published var isVoiceOverCaptionsEnabled = UIAccessibility.isClosedCaptioningEnabled
    @Published var isInvertColorsEnabled = UIAccessibility.isInvertColorsEnabled
    @Published var isOnOffSwitchLabelsEnabled = UIAccessibility.isOnOffSwitchLabelsEnabled
    
    private let privateFrameworksPath: String
    
    internal init() {
        guard
            let clazz = NSClassFromString("UIView").self,
            let path = Bundle(for:  clazz).privateFrameworksPath else {
            privateFrameworksPath = ""
            return
        }
        
        let base = path.replacingOccurrences(of: "/UIKitCore.framework/Frameworks", with: "")
        privateFrameworksPath = base
        
        loadPrivateFramework(named: "VoiceServices.framework")
        loadPrivateFramework(named: "VoiceOverServices.framework")
        loadPrivateFramework(named: "UIAccessibility.framework")
        loadPrivateFramework(named: "AccessibilityUtilities.framework")
    }

    private func loadPrivateFramework(named name: String) {
        Bundle(path: "\(privateFrameworksPath)/\(name)")?.load()
    }

    func toggleVoiceOver() {
        isVoiceOverRunning.toggle()
        Dynamic.AXSettings.sharedInstance.setVoiceOverEnabled(isVoiceOverRunning)

        /// Enable keyboard control
        let _ = Dynamic.VOSCommandManager().loadShortcuts
        let _ = Dynamic.VOSCommandManager().allBuiltInCommands
        let _ = Dynamic.VOSCommandManager().activeProfile
    }
    
    func toggleVoiceOverCaptions() {
        Dynamic.AXSettings.sharedInstance.setVoiceOverSceneDescriptionsEnabled(isVoiceOverCaptionsEnabled)
        Dynamic.AXSettings.sharedInstance.setEnableVoiceOverCaptions(isVoiceOverCaptionsEnabled)
    }
    
    func toggleReduceMotion() {
        Dynamic.AXSettings.sharedInstance.setReduceMotionEnabled(isReduceMotionEnabled)
    }
    
    func toggleInvertColors() {
        Dynamic.AXSettings.sharedInstance.setClassicInvertColors(isInvertColorsEnabled)
        Dynamic.AXSettings.sharedInstance.setLastSmartInvertColorsEnablement(isInvertColorsEnabled)
    }
    
}

