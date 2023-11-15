//
//  PinnedViews.swift
//  SwiftUICase
//
//  Created by Gab on 2023/11/15.
//

import SwiftUI

struct HeaderView: View {
    var headerText: String
    
    var body: some View {
        Text(headerText)
    }
}

struct PinnedViews: View {
    let contents = ["안아줘요", "안아달라고", "안돼"]
    
    var body: some View {
        
        ScrollView {
            Image("안돼")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
            
            // pinnedViews의 sectionHeaders를 켜지만 Section을 Group으로 묶음
            // Group으로 묶은 Secion Header는 pinnedViews가 정상적으로 작동함
            // Group은 레이아웃에 덜 제한적이라고 한다. 단순히 자식 뷰를 그룹화하는 역할을 하며,
            // 레이아웃에 대해 강력한 규칙을 부과하지 않는다.
            // Group은 그룹화를 하는게 더 크기 때문에 뷰의 배치 및 크기를 VStack보다 엄격하게 정의하는게
            // 아니기 때문에 이때는 pinnedViews가 먹히나 보다.
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Group {
                    ForEach(contents, id: \.self) { name in
                        Section(header:
                                HeaderView(headerText: name)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                            .background(Color.red)
                        ) {
                            Image(name)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            // pinnedViews의 sectionHeaders를 켜지만 Section을 VStack으로 묶음
            // VStack으로 묶은 Secion Header는 pinnedViews가 정상적으로 작동하지않음
            // VStack은 세로 방향으로 뷰를 쌓는데 중점을 두고 있어서 뷰를 상대적으로 제한된 수직 공간에
            // 배치하는 경향이 있다. 이러한 특성 때문에 VStack이 뷰의 크기와 위치를 좀 더 명확하게 정의하니까
            // 이렇게 되버리는 것 같다.
            LazyVStack(pinnedViews: [.sectionHeaders]) {
                VStack {
                    ForEach(contents, id: \.self) { name in
                        Section(header:
                                HeaderView(headerText: name)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                            .background(Color.red)
                        ) {
                            Image(name)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .clipped()
    }
}

struct PinnedViews_Previews: PreviewProvider {
    static var previews: some View {
        PinnedViews()
    }
}
