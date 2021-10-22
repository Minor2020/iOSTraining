//
//  TrainingApp.swift
//  Training
//
//  Created by Zhang,Yongchao(BAMRD) on 2021/10/19.
//

import SwiftUI

@main
struct TrainingApp: App {
    // 添加被观察的数据模型
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        // WindowGroup 声明 ContentView 为 app 的 root view
        WindowGroup {
            ContentView().environmentObject(modelData)
        }
    }
}
