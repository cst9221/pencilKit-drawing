//
//  DrawingView.swift
//  Drawing
//
//  Created by prediction on 2021/11/17.
//

import SwiftUI

struct DrawingView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State var id:UUID?
    @State var data:Data?
    @State var title:String?
    var body: some View {
        VStack{
            DrawingCanvasView(data: data ?? Data(), id: id ?? UUID())
                .environment(\.managedObjectContext, viewContext)
                .navigationBarTitle(title ?? "Untitled", displayMode: .inline)
        }
        .frame(width:100, height: 100)
        .foregroundColor(.yellow)
        .border(Color.red, width: 4)
    }
}
