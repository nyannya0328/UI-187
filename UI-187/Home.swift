//
//  Home.swift
//  UI-187
//
//  Created by にゃんにゃん丸 on 2021/05/14.
//

import SwiftUI

struct Home: View {
    @State var slected = "Lap"
    init() {
        #if os(iOS)
        UITabBar.appearance().isHidden = true
        
        #endif
    }
    @Environment(\.colorScheme) var shceme
    var body: some View {
        ZStack(alignment:getDevice() == .iphone ? .bottom : .trailing){
            
            #if os(iOS)
            TabView(selection:$slected){
                
                Color.red
                    .tag("Lap")
                    .ignoresSafeArea(.all, edges: .all)
                
                Color.blue
                    .tag("Sun")
                    .ignoresSafeArea(.all, edges: .all)
                
                
                Color.green
                    .tag("Fire")
                    .ignoresSafeArea(.all, edges: .all)
                
                Color.orange
                    .tag("Volt")
                    .ignoresSafeArea(.all, edges: .all)
            }
            #else
            ZStack{
                
                switch(slected){
                
                case "Lap" : Color.red
                    
                case "Sun" : Color.green
                    
                case "Fire" : Color.blue
                    
                case "Volt" : Color.orange
                default : Color.clear
                
                
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            #endif
            
            if self.getDevice() == .ipad || self.getDevice() == .macOS{
                
                VStack(spacing:0){
                    
                    InsideTabBar(slected: $slected)
                    
                    Spacer()
                }
                .background(shceme == .dark ? Color.black : Color.white)
                
                
                
            }
            
            
            else{
                HStack(spacing:0){
                    
                    InsideTabBar(slected: $slected)
                   
                }
                .padding(.horizontal)
              
                
                .frame(maxWidth: .infinity)
                .background(shceme == .dark ? Color.black : Color.white)
                
                
            }
            
            
           
            
            
        }
        .ignoresSafeArea(.all, edges:getDevice() == .iphone ? .bottom : .all)
        .frame(width: getDevice() == .ipad || getDevice() == .iphone ? nil : getRect().width / 1.6, height: getDevice() == .ipad || getDevice() == .iphone ? nil : getRect().height - 150)
       
    }
}

struct InsideTabBar : View {
    @Binding var slected : String
    var body: some View{
        
        Group{
            
            
            
            TabButton(image: "laptopcomputer", title: "Lap", selected: $slected)
                .padding(.top,getDevice() == .iphone ? 0 : 35)
                .padding(.bottom,getDevice() == .iphone ? 0 : 15 )
            TabButton(image: "sun.min.fill", title: "Sun", selected: $slected)
            TabButton(image: "flame", title: "Fire", selected: $slected)
            
            TabButton(image: "bolt.fill", title: "Volt", selected: $slected)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
           
    }
}


struct TabButton : View {
    var image : String
    var title : String
    @Binding var selected : String
    var body: some View{
        
        
        Button(action: {
            
            withAnimation(.easeInOut){
                
                selected = title
            }
            
        }, label: {
            VStack(spacing:15){
                
                Image(systemName: image)
                    .font(.system(size: getDevice() == .iphone ?  30 : 25, weight: .bold))
                    .foregroundColor(selected == title ? .white : .primary)
                
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(selected == title ? .white : .primary)
                
                
            }
            .padding(.bottom,8)
            .frame(width:self.getDevice() == .iphone ?  (self.getRect().width - 75) / 3 : 100, height: 55 + self.getSafeArea())
            
            .contentShape(Rectangle())
            .background(Color.purple.offset(x :selected == title ? 0 : getDevice() == .iphone ? 0 : +100 ,y: selected == title ? 0 : getDevice() == .iphone ? 100 : 0))
         
            
        })
        .buttonStyle(PlainButtonStyle())
        
    }
}

extension View{
    
    func getRect()->CGRect{
        
        #if os(iOS)
        return UIScreen.main.bounds
        
        #else
        return NSScreen.main!.visibleFrame
        
        #endif
        
    }
    func getSafeArea()->CGFloat{
        
        #if os(iOS)
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 10
        
        #else
        return 10
        
        #endif
    
        
    }
    
    func getDevice() -> Device{
        
        
        #if os(iOS)
        if UIDevice.current.model.contains("iPad"){
            return .ipad
            
            
        }
        else{
            
            return .iphone
        }
        #else
        return .macOS
        
        #endif
        
    }
    
}

enum Device{
    
    case iphone
    case ipad
    case macOS
    
}
