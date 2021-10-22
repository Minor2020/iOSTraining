//
//  CircleImage.swift
//  Training
//
//  Created by Zhang,Yongchao(BAMRD) on 2021/10/20.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    // 在 body 属性里初始化 view
    var body: some View {
        image
            .frame(width: 250, height: 250)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}
