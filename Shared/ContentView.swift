//
//  ContentView.swift
//  Shared
//
//  Created by Anbalagan D on 26/12/20.
//

import SwiftUI

class MailItem: Identifiable, ObservableObject {
    let id = UUID()
    var isSelected: Bool
    var isRead: Bool
    var title: String
    var description: String
    
    init(isSelected: Bool, isRead: Bool, title: String, description: String) {
        self.isSelected = isSelected
        self.isRead = isRead
        self.title = title
        self.description = description
    }
    
    func toggleSelection() {
        objectWillChange.send()
        isSelected.toggle()
    }
}

extension MailItem {
    static var mailList: [MailItem] = {
        return [
            MailItem(isSelected: false, isRead: true, title: "Anbalagan D", description: "Test data"),
            MailItem(isSelected: false, isRead: false, title: "Anbalagan D", description: "Test data"),
            MailItem(isSelected: false, isRead: false, title: "Anbalagan D", description: "Test data"),
            MailItem(isSelected: false, isRead: false, title: "Anbalagan D", description: "Test data"),
            MailItem(isSelected: false, isRead: false, title: "Anbalagan D", description: "Test data"),
            MailItem(isSelected: false, isRead: false, title: "Anbalagan D", description: "Test data"),
            MailItem(isSelected: false, isRead: false, title: "Anbalagan D", description: "Test data"),
            MailItem(isSelected: false, isRead: false, title: "Anbalagan D", description: "Test data"),
            MailItem(isSelected: false, isRead: false, title: "Anbalagan D", description: "Test data"),
            MailItem(isSelected: false, isRead: false, title: "Anbalagan D", description: "Test data")
        ]
    }()
}

class Mail: ObservableObject {
    @Published var items = [MailItem]()
    
    init() {
        items = MailItem.mailList
    }
    
    func resetAllSelection() {
        objectWillChange.send()
        items.forEach { $0.isSelected = false }
    }
    
    func toggleSelection(mailItem: MailItem) {
        objectWillChange.send()
        mailItem.isSelected.toggle()
    }
}

struct ContentView: View {
    
    @State private var isEdit: Bool = false
    @ObservedObject var mail = Mail()
    
    var body: some View {
        List {
            ForEach(mail.items) { mailItem in
                MailItemView(isEdit: $isEdit, mailItem: mailItem)
            }
        }
        .listStyle(PlainListStyle())
        .navigationBarItems(trailing: Button("Edit") {
            
            if isEdit {
                resetAllSelection()
            }
            
            withAnimation(.linear(duration: 0.20)) {
                isEdit.toggle()
            }
        })
        .navigationTitle("Mail")
        .overlay(
            NavigationSearch()
                .frame(width: 0, height: 0)
                .background(Color.red.opacity(0.3))
        )
        .onAppear(perform: {
            UITableView.appearance().separatorColor = .clear
        })
        
    }
    
    func resetAllSelection() {
        mail.resetAllSelection()
    }
}

struct MailItemView: View {
    
    @Binding var isEdit: Bool
    @ObservedObject var mailItem: MailItem
    @State private var isShowingDetailView = false
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            NavigationLink(destination:
                            PolygonShape(sides: 3).stroke(Color.blue, lineWidth: 3)
                            .padding(),
                           isActive: $isShowingDetailView) { EmptyView() }
                .opacity(0)
            
            HStack(spacing: 16) {
                if isEdit {
                    let imageName = mailItem.isSelected ? "checkmark.circle.fill" : "circle"
                    Image(systemName: imageName)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.blue)
                }
                
                HStack(alignment: .top) {
                    
                    Circle()
                        .fill(mailItem.isRead ? Color.clear : Color.blue)
                        .frame(width: 12, height: 12)
                        .padding(.top, 5)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        HStack(alignment: .top, spacing: 8) {
                            Text("HDFC Bank - Anna Nager West - li Avenue")
                                .font(.headline)
                                .lineLimit(1)
                            
                            Text("Yesterday")
                                .font(.body)
                                .foregroundColor(.gray)
                            
                            if !isEdit {
                                Image(systemName: "chevron.forward")
                                    .foregroundColor(.gray)
                                    .padding(.top, 3)
                            }
                        }
                        
                        Text("😄Anbalagan Dharmar, A special gift🎁 only for you!")
                            .lineLimit(1)
                        
                        Text("Your Smart Statement was created with this in mind. Designed to make monthly expense tracking easier, here are some things you can do")
                            .lineLimit(2)
                            .foregroundColor(.gray)
                    }
                }
                .onTapGesture {
                    isShowingDetailView = true
                }
            }
        }
        .onTapGesture {
            mailItem.toggleSelection()
        }
    }
}

struct SwipeView<Content>: View where Content : View {
    
    init(@ViewBuilder content: () -> Content) {
    }
    
    var body: some View {
        ZStack {
            Text("Swipe View")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
