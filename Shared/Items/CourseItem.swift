//
//  CourseItem.swift
//  CoursesApp
//
//  Created by Margulan Daribayev on 10.05.2021.
//

import SwiftUI

struct CourseItem: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Spacer()
            HStack {
                Spacer()
                Image("Illustration 1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            Text("SwiftUI for iOS 14")
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("20 Sections")
                .font(.footnote)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.blue)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct CourseItem_Previews: PreviewProvider {
    static var previews: some View {
        CourseItem()
    }
}