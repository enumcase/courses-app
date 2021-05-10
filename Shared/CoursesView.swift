//
//  CoursesView.swift
//  CoursesApp
//
//  Created by Margulan Daribayev on 07.05.2021.
//

import SwiftUI

struct CoursesView: View {
    @State private var isShowingCourseItem = false
    var body: some View {
        ZStack {
            CourseItem()
                .frame(width: 335, height: 250)
            VStack {
                if isShowingCourseItem {
                    CourseItem()
                        .transition(.move(edge: .trailing))
                        .ignoresSafeArea(.all)
                }
            }
        }
        .onTapGesture {
            withAnimation(.spring()) {
                isShowingCourseItem.toggle()
            }
        }
//      .animation(.spring())
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
