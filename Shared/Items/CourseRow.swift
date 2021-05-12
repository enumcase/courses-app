//
//  CourseRow.swift
//  CoursesApp
//
//  Created by Margulan Daribayev on 07.05.2021.
//

import SwiftUI

struct CourseRow: View {
    let item: CourseSection
    
    var body: some View {
        HStack(alignment: .top) {
            Image(item.logo)
                .renderingMode(.original)
                .frame(width: 48, height: 48)
                .imageScale(.medium)
                .background(item.color)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.subheadline)
                    .bold()
                Text(item.subtitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.all, 12)
    }
}

struct CourseRow_Previews: PreviewProvider {
    static var previews: some View {
        CourseRow(item: courseSections[0])
    }
}
