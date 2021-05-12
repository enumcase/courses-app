//
//  CourseFullDetail.swift
//  CoursesApp
//
//  Created by Margulan Daribayev on 12.05.2021.
//

import SwiftUI

struct CourseFullDetail: View {
    let course: Course
    let namespace: Namespace.ID
    
    var body: some View {
        VStack {
            ScrollView {
                CourseItem(course: course)
                    .matchedGeometryEffect(id: course.id, in: namespace)
                    .frame(height: 300)
                VStack {
                    ForEach(courseSections) { item in
                        CourseRow(item: item)
                        Divider()
                    }
                }
            }
        }
        .background(Color("Background 1"))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .matchedGeometryEffect(id: "container\(course.id)", in: namespace)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CourseFullDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CourseFullDetail(course: courses[0], namespace: namespace)
    }
}
