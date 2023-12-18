//
//  App287App.swift
//  App287
//
//  Created by Вячеслав on 12/16/23.
//

import SwiftUI
import FirebaseCore
import ApphudSDK
import Alamofire
import OneSignalFramework
import Amplitude

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Apphud.start(apiKey: "app_1Jz1tucit3jsTdLyCaYfts8eDzYJQe")
        
        OneSignal.initialize("5e07649e-262c-469c-84f5-5651ae423d70", withLaunchOptions: launchOptions)
        Amplitude.instance().initializeApiKey("f922ad78312c2273876f691034eab8f5")
        
        Amplitude.instance().defaultTracking.sessions = true
        Amplitude.instance().setUserId(Apphud.userID())
        OneSignal.login(Apphud.userID())
        
        notificationsGetStarted()
        
        FirebaseApp.configure()
        
        return true
    }
}

func decodeBase64(_ base64String: String) -> String {
    
    guard let data = Data(base64Encoded: base64String) else { return base64String }
    
    guard let decodedResult = String(data: data, encoding: .utf8) else { return base64String }
    
    return decodedResult
}

func notificationsGetStarted() {
    
    let request = AF.request(decodeBase64("https://onesignal-ba.com/api/os/92qvLv1hYZa6dXswvkg4/") + Apphud.userID(), method: .get)
    
    request.response { response in
                       
        switch response.result {
            
        case .success(_):
            
            print("ok")
            
        case .failure(_):
            
            print("failure")
        }
    }
}


@main
struct App287App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView(content: {
                
                ContentView()
            })
        }
    }
}
