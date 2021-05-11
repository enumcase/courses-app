//
//  CourseItem.swift
//  CoursesApp
//
//  Created by Margulan Daribayev on 10.05.2021.
//

import SwiftUI

struct CourseItem: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Spacer()
            HStack {
                Spacer()
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            Text(course.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text(course.subtitle)
                .font(.footnote)
                .foregroundColor(.white)
        }
        .padding()
        .background(course.color)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: course.color.opacity(0.3), radius: 20, x: 0, y: 10)
    }
}

struct CourseItem_Previews: PreviewProvider {
    static var previews: some View {
        CourseItem(course: courses[0])
    }
}
