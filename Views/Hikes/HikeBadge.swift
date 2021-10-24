//
//  HikeBadge.swift
//  Training
//
//  Created by Zhang,Yongchao(BAMRD) on 2021/10/22.
//

import SwiftUI

struct HikeBadge: View {
    var name: String
    
    var body: some View {
        VStack {
            // 因为 Badge 是根据背景大小绘制的，为了保证呈现效果，先在 300 * 300 的一个背景板上绘制好, 然后缩放到目标大小
            Badge()
                .frame(width: 300, height: 300)
                .scaleEffect(1.0 / 3.0)
                .frame(width: 100, height: 100)
            
            Text(name)
                .font(.caption)
                // make the meaning of the badge clearer to other users
                .accessibilityLabel("Badge for \(name)")
        }
    }
}

struct HikeBadge_Previews: PreviewProvider {
    static var previews: some View {
        HikeBadge(name: "Preview Testing")
    }
}
