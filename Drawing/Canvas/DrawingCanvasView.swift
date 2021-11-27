//
//  DrawingCanvasView.swift
//  Drawing
//
//  Created by prediction on 2021/11/17.
//

import SwiftUI
import CoreData
import PencilKit

struct DrawingCanvasView: UIViewControllerRepresentable {
    @Environment(\.managedObjectContext) private var viewContext
    
    func updateUIViewController(_ uiViewController: DrawingCanvasViewController, context: Context) {
        print(data.map { String(format: "%02x", $0) }.joined(), 12345)
        uiViewController.drawingData = data
    }
    typealias UIViewControllerType = DrawingCanvasViewController
    
    var data: Data
    var id: UUID
    
    func makeUIViewController(context: Context) -> DrawingCanvasViewController {
        let viewController = DrawingCanvasViewController()
        viewController.drawingData = data
        viewController.drawingChanged = { data in
            let request: NSFetchRequest<Draw> = Draw.fetchRequest()
            let predicate = NSPredicate(format: "id == %@", id as CVarArg)
            request.predicate = predicate
            do{
                let result = try viewContext.fetch(request)
                let obj = result.first
                obj?.setValue(data, forKey: "canvasData")
                
                do{
                    try viewContext.save()
                }
                catch{
                    print(error)
                }
            }
            catch{
                print(error)
            }
        }
        return viewController
    }

}
