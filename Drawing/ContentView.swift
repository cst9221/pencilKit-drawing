//
//  ContentView.swift
//  Drawing
//
//  Created by prediction on 2021/11/17.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Draw.entity(),
        sortDescriptors: []
    ) var draws: FetchedResults<Draw>
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationView{
            VStack{
                List {
                    ForEach(draws) { draw in
                        NavigationLink(destination: DrawingView(id: draw.id, data: draw.canvasData, title: draw.title), label: {
                            Text(draw.title ?? "Untitled")
                        })
                    }
                    .onDelete(perform: deleteItem)
 
                    Button(action: {
                        self.showSheet.toggle()
                    }, label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("add Canvas")
                        }
                    })
                        .sheet(isPresented: $showSheet, content: {
                        AddNewCanvasView().environment(\.managedObjectContext, viewContext)
                    })
                }
                .navigationTitle(Text("Drawing"))
                .toolbar {
                    EditButton()
                }
            }
            
            VStack{
                Image(systemName: "scribble.variable")
                    .font(.largeTitle)
                Text("No canvas has been selected")
                    .font(.title)
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }

    func deleteItem(at offset: IndexSet) -> Void {
        for index in offset{
            let itemToDelete = draws[index]
            viewContext.delete(itemToDelete)
            do{
                try viewContext.save()
            }
            catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
