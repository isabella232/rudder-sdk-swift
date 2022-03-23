//
//  RSiOSLifecycleEvents.swift
//  RudderStack
//
//  Created by Pallab Maiti on 24/02/22.
//  Copyright © 2021 Rudder Labs India Pvt Ltd. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)

import UIKit

class RSiOSLifecycleEvents: RSPlatformPlugin, RSiOSLifecycle {
    let type = PluginType.before
    var client: RSClient?
    
    func application(_ application: UIApplication?, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if client?.config.trackLifecycleEvents == false {
            return
        }
        
        let previousVersion = RSUserDefaults.getApplicationVersion()
        let previousBuild = RSUserDefaults.getApplicationBuild()
        
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let currentBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        if previousBuild != nil {
            client?.track("Application Installed", properties: [
                "version": currentVersion ?? "",
                "build": currentBuild ?? ""
            ])
        } else if currentBuild != previousBuild {
            client?.track("Application Updated", properties: [
                "previous_version": previousVersion ?? "",
                "previous_build": previousBuild ?? "",
                "version": currentVersion ?? "",
                "build": currentBuild ?? ""
            ])
        }
        
        client?.track("Application Opened", properties: [
            "from_background": false,
            "version": currentVersion ?? "",
            "build": currentBuild ?? "",
            "referring_application": launchOptions?[UIApplication.LaunchOptionsKey.sourceApplication] ?? "",
            "url": launchOptions?[UIApplication.LaunchOptionsKey.url] ?? ""
        ])
        
        RSUserDefaults.saveApplicationVersion(currentVersion)
        RSUserDefaults.saveApplicationBuild(currentBuild)
    }
    
    func applicationWillEnterForeground(application: UIApplication?) {
        if client?.config.trackLifecycleEvents == false {
            return
        }
        
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        let currentBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        
        client?.track("Application Opened", properties: [
            "from_background": true,
            "version": currentVersion ?? "",
            "build": currentBuild ?? ""
        ])
    }
    
    func applicationDidEnterBackground(application: UIApplication?) {
        if client?.config.trackLifecycleEvents == false {
            return
        }
        
        client?.track("Application Backgrounded")
    }
}

#endif
