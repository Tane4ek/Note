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
    let bottomStyleView = BottomStyleView()
    
    init(serviceContainer: ServiceContainer) {
        self.serviceContainer = serviceContainer
    }
    
    func returnToNoteListModule() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        view?.present(alert, animated: true, completion: nil)
    }
    
    func showAddNoteModule(note: Note) {
        let configurator = AddNoteModuleConfigurator(serviceContainer: serviceContainer)
        let addNoteViewController = configurator.configure(note: note)
        view?.navigationController?.pushViewController(addNoteViewController, animated: true)
    }
}
