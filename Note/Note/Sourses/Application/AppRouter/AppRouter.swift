//
//  AppRouter.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import Foundation
import UIKit

class AppRouter {
    
    var noteStorageImpl = NoteStorageImpl()
    var noteService: NoteServiceImpl
    var serviceContainer: ServiceContainer
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        self.noteService = NoteServiceImpl(noteStorageImpl: noteStorageImpl)
        self.serviceContainer = ServiceContainer(noteService: noteService)
    }
    
    func openInitialViewController() {
        
        let configurator = NoteListModuleConfigurator(serviceContainer: serviceContainer)
        
        let navigationController = UINavigationController(rootViewController: configurator.configure())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
