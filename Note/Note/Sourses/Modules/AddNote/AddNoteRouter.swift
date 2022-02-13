//
//  AddNoteRouter.swift
//  Note
//
//  Created by Татьяна Лузанова on 11.02.2022.
//

import UIKit

class AddNoteRouter {
    
    weak var view: UIViewController?
    var serviceContainer: ServiceContainer
    weak var alert: UIAlertController?
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func returnToNoteListModule() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Attention", message: "Note can't be empty", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view?.present(alert, animated: true, completion: nil)
    }
    
    func showPhotoAlert() {
        let alert = UIAlertController(title: "Add Photo", message: "Will be available soon", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view?.present(alert, animated: true, completion: nil)
    }
    
    func showAddNoteModule(note: Note) {
        let configurator = AddNoteModuleConfigurator(serviceContainer: serviceContainer)
        let addNoteViewController = configurator.configure(note: note)
        view?.navigationController?.pushViewController(addNoteViewController, animated: true)
    }
}
