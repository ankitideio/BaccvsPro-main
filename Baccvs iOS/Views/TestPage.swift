//
//  TestPage.swift
//  Baccvs iOS
//
//  Created by pm on 16/03/2023.
//

import SwiftUI

struct TestPage: View {
    @State var items: [String] = ["Apples", "Oranges", "Bananas", "Pears", "Mangos", "Grapefruit"]
    @State var selections: [String] = []
    var body: some View {
        VStack{
            Text("")
//            List {
//                ForEach(self.items, id: \.self) { item in
//                    MultipleSelectionRow(title: item, isSelected: self.selections.contains(item)) {
//                        if self.selections.contains(item) {
//                            self.selections.removeAll(where: { $0 == item })
//                        }
//                        else {
//                            self.selections.append(item)
//                        }
//                    }
//                }
//            }
        }
    }
}
struct TestPage_Previews: PreviewProvider {
    static var previews: some View {
        TestPage()
    }
}
