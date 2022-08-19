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
        loadPrivateFramework(named: "TipKit.framework")
        
        // Progresive testing
        let settings = Settings()
        Reference(value: settings)
            .name("Carlos")
            .size(.small)
        
    }

    private func loadPrivateFramework(named name: String) {
        Bundle(path: "\(privateFrameworksPath)/\(name)")?.load()
    }
    
    @objc
    func setVoiceOverEnabled(_ arg1: Bool) {
    }

    func toggleVoiceOver() {
        guard
            let clazz = NSClassFromString("AXSettings") as? NSObject.Type,
            let settings = clazz.value(forKey: "sharedInstance") as? NSObject else {
            return
        }
        
        settings.setValue(isVoiceOverRunning, forKey: "voiceOverEnabled")
      
        
        #if canImport(Dynamic)
        //Dynamic.AXSettings.sharedInstance.setVoiceOverEnabled(isVoiceOverRunning)
        #else
        
        #endif

        /// Enable keyboard control
        //let _ = Dynamic.VOSCommandManager().loadShortcuts
        //let _ = Dynamic.VOSCommandManager().allBuiltInCommands
        //let _ = Dynamic.VOSCommandManager().activeProfile
    }
    
    func toggleVoiceOverCaptions() {
        //Dynamic.AXSettings.sharedInstance.setVoiceOverSceneDescriptionsEnabled(isVoiceOverCaptionsEnabled)
//        Dynamic.AXSettings.sharedInstance.setEnableVoiceOverCaptions(isVoiceOverCaptionsEnabled)
    }
    
    func toggleReduceMotion() {
        Dynamic.AXSettings.sharedInstance.setReduceMotionEnabled(isReduceMotionEnabled)
    }
    
    func toggleInvertColors() {
        Dynamic.AXSettings.sharedInstance.setClassicInvertColors(isInvertColorsEnabled)
        Dynamic.AXSettings.sharedInstance.setLastSmartInvertColorsEnablement(isInvertColorsEnabled)
    }
    
    private func describeInOrder(_ object: [String: Any]) {
        let dictionary = object.sorted { $0.key > $1.key}
        for element in dictionary {
            print("\(element.key):", element.value )
        }
        
  
        
    }
    
}

class Settings {
    
    enum Size {
        case small
        case large
    }
    
    var name: String = ""
    var size: Size = .small
    
}

@dynamicCallable
class Setter<Object, Value> {
    let action: (Value) -> Void
    let returnValue: Object
    
    init(_ object: Object, _ action: @escaping (Value) -> Void) {
        self.action = action
        self.returnValue = object
    }
    
    func dynamicallyCall(withArguments args: [Value]) -> Object {
        action(args.first!)
        return returnValue
    }
    
}

@dynamicMemberLookup
class Reference<Value> {
    private(set) var value: Value

    init(value: Value) {
        self.value = value
    }

    subscript<T>(dynamicMember keyPath: WritableKeyPath<Value, T>) -> Setter<Reference<Value>, T>  {
        print("Dinamic menber", keyPath)
       return Setter(self) { newValue in
            self.value[keyPath: keyPath] = newValue
        }
    }
}

