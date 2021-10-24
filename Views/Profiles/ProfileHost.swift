//
//  ProfileHost.swift
//  Training
//
//  Created by Zhang,Yongchao(BAMRD) on 2021/10/22.
//

import SwiftUI

struct ProfileHost: View {
    // Environment 修饰的属性可以获得读写 editMode 的入口
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel") {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
           
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                // TODO: 这里的 $ 什么意思？The profile binding.
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        // 子 view 使用了 ModelData, 如果不添加则不能预览
        ProfileHost()
            .environmentObject(ModelData())
    }
}
