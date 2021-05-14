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
    
    #if os(iOS)
    let cornerRadius: CGFloat = 10
    #else
    let cornerRadius: CGFloat = 0
    #endif
    
    @State private var isShowingModal = false
    
    var body: some View {
        #if os(iOS)
        content
            .edgesIgnoringSafeArea(.all)
        #else
        content
        #endif
    }
    
    var content: some View {
        VStack {
            ScrollView {
                CourseItem(course: course, cornerRadius: 0)
                    .matchedGeometryEffect(id: course.id, in: namespace)
                    .frame(height: 300)
                VStack {
                    ForEach(courseSections) { item in
                        CourseRow(item: item)
                            .sheet(isPresented: $isShowingModal) {
                                CourseSectionDetail()
                            }
                            .onTapGesture {
                                isShowingModal = true
                            }
                        Divider()
                    }
                }
            }
        }
        .background(Color("Background 1"))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .matchedGeometryEffect(id: "container\(course.id)", in: namespace)
    }
}

struct CourseFullDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CourseFullDetail(course: courses[0], namespace: namespace)
    }
}
