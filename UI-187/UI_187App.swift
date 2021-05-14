//
//  UI_187App.swift
//  UI-187
//
//  Created by にゃんにゃん丸 on 2021/05/14.
//

import SwiftUI

@main
struct UI_187App: App {
    var body: some Scene {
        
        #if os(iOS)
        
        WindowGroup {
            ContentView()
        }
        
        #else
        WindowGroup {
            ContentView()
                
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        #endif
        
    }
}
