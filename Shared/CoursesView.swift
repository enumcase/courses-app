//
//  CoursesView.swift
//  CoursesApp
//
//  Created by Margulan Daribayev on 07.05.2021.
//

import SwiftUI

struct CoursesView: View {
    @State private var isShowingCourseItem = false
    @Namespace private var namespace
    
    @State private var selectedCourse: Course? = nil
    @State private var isDisabled = false
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.adaptive(minimum: 160), spacing: 16)
                    ],
                    spacing: 16
                ) {
                    ForEach(courses) { course in
                        VStack {
                            CourseItem(course: course)
                                .matchedGeometryEffect(id: course.id, in: namespace, isSource: !isShowingCourseItem)
                                .frame(height: 200)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        isShowingCourseItem.toggle()
                                        selectedCourse = course
                                        isDisabled = true
                                    }
                                }
                                .disabled(isDisabled)
                        }
                        .matchedGeometryEffect(id: "container\(course.id)", in: namespace, isSource: !isShowingCourseItem)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
            }
            
            if selectedCourse != nil {
                VStack {
                    ScrollView {
                        CourseItem(course: selectedCourse!)
                            .matchedGeometryEffect(id: selectedCourse!.id, in: namespace)
                            .frame(height: 300)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    isShowingCourseItem.toggle()
                                    selectedCourse = nil
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        isDisabled = false
                                    }
                                }
                            }
                        VStack {
                            ForEach(0 ..< 20) { item in
                                CourseRow()
                            }
                        }
                    }
                }
                .background(Color("Background 1"))
                .matchedGeometryEffect(id: "container\(selectedCourse!.id)", in: namespace)
                .transition(
                    .asymmetric(
                        insertion: AnyTransition
                            .opacity
                            .animation(Animation.spring().delay(0.3)),
                        removal: AnyTransition
                            .opacity
                            .animation(.spring())
                    )
                )
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
