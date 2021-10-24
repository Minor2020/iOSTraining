//
//  ProfileEditor.swift
//  Training
//
//  Created by Zhang,Yongchao(BAMRD) on 2021/10/22.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    // 错误提示消失太慢了
    var dataRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalData)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalData)!
        return min...max
    }
    
    var body: some View {
        List {
            HStack {
                Text("Username").bold()
                Divider()
                TextField("Username", text: $profile.username)
            }
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notifications.").bold()
            }
            
            Text("Season Photo").bold()
            Picker("Season Photot", selection: $profile.seasonalPhoto) {
                ForEach(Profile.Season.allCases) { season in
                    Text(season.rawValue).tag(season)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            DatePicker(selection: $profile.goalData, in: dataRange, displayedComponents: .date) {
                Text("Goal Date").bold()
            }
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
