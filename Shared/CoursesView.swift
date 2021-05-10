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
    
    var body: some View {
        ZStack {
            CourseItem()
                .matchedGeometryEffect(id: "Card", in: namespace, isSource: !isShowingCourseItem)
                .frame(width: 335, height: 250)
            if isShowingCourseItem {
                ScrollView {
                    CourseItem()
                        .matchedGeometryEffect(id: "Card", in: namespace)
                        .frame(height: 300)
                    VStack {
                        ForEach(0 ..< 20) { item in
                            CourseRow()
                        }
                    }
                }
                .transition(.opacity)
                .ignoresSafeArea(.all)
            }
        }
        .onTapGesture {
            withAnimation(.spring()) {
                isShowingCourseItem.toggle()
            }
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
