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
    @Namespace private var namespaceForLatestSections
    
    @State private var selectedCourse: Course? = nil
    @State private var isDisabled = false
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    var body: some View {
        ZStack {
            #if os(iOS)
            if horizontalSizeClass == .compact {
                tabBar
            } else {
                sidebar
            }
            fullContent
                .background(VisualEffectBlur(blurStyle: .systemMaterial).edgesIgnoringSafeArea(.all))
            #else
            content
            fullContent
                .background(VisualEffectBlur().edgesIgnoringSafeArea(.all))
            #endif
        }
        .navigationTitle("Courses")
    }
    
    @ViewBuilder
    var content: some View {
        ScrollView {
            VStack(spacing: 0) {
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
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0)) {
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
                
                Text("Latest sections")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum:240))]) {
                    ForEach(courseSections) { item in
                        #if os(iOS)
                        NavigationLink(destination: CourseFullDetail(course: courses[0], namespace: namespaceForLatestSections)) {
                            CourseRow(item: item)
                        }
                        #else
                        CourseRow(item: item)
                        #endif
                    }
                }
            }
            
        }
        .zIndex(1)
        .navigationTitle("Courses")
    }
    
    @ViewBuilder
    var fullContent: some View {
        if selectedCourse != nil {
            ZStack(alignment: .topTrailing) {
                CourseFullDetail(course: selectedCourse!, namespace: namespace)
                
                CloseButton()
                    .padding(16)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isShowingCourseItem.toggle()
                            selectedCourse = nil
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isDisabled = false
                            }
                        }
                    }
            }
            .zIndex(2)
            .frame(maxWidth: 712)
            .frame(maxWidth: .infinity)
        }
    }
    
    var tabBar: some View {
        TabView {
            NavigationView {
                content
            }
            .tabItem {
                Image(systemName: "book.closed")
                Text("Courses")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "list.bullet.rectangle")
                Text("Tutorials")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "tv")
                Text("Livestreams")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "mail.stack")
                Text("Certificates")
            }
            
            NavigationView {
                CourseList()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
    
    @ViewBuilder
    var sidebar: some View {
        #if os(iOS)
        NavigationView {
            List {
                NavigationLink(destination: CoursesView()) {
                    Label("Courses", systemImage: "book.closed")
                }
                NavigationLink(destination: CoursesView()) {
                    Label("Tutorials", systemImage: "list.bullet.rectangle")
                }
                NavigationLink(destination: CoursesView()) {
                    Label("Livestreams", systemImage: "tv")
                }
                NavigationLink(destination: CoursesView()) {
                    Label("Certificates", systemImage: "mail.stack")
                }
                NavigationLink(destination: CoursesView()) {
                    Label("Search", systemImage: "magnifyingglass")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Learn")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "person.crop.circle")
                }
            }
            
            content
        }
        #endif
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
