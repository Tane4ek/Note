//
//  BottomStackView.swift
//  Note
//
//  Created by Татьяна Лузанова on 15.02.2022.
//

import UIKit

class BottomStackView: UIStackView {
    
    private var buttonChangeTextStyle = UIButton(frame: .zero)
    private var buttonAddPhoto = UIButton(frame: .zero)
    private var buttonAddNewNote = UIButton(frame: .zero)
    private var buttonDeleteNote = UIButton(frame: .zero)
    var delegate: BottomStackViewDelegate?
    
    
//  MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  MARK: - SetupUI
    func setupUI() {
        axis = .horizontal
        spacing = 5
        distribution = .fillEqually
        setupButtoaAddPhoto()
        setupButtonChangeTextStyle()
        setupButtonAddNewNote()
        setupButtonDeleteNote()
    }

    private func setupButtoaAddPhoto() {
        buttonAddPhoto = buttonsStyle(image: "camera")
        buttonAddPhoto.addTarget(self, action: #selector(addPhotoButtonTapped(_:)), for: .touchUpInside)
        addArrangedSubview(buttonAddPhoto)
    }
    
    private func setupButtonChangeTextStyle() {
        buttonChangeTextStyle = buttonsStyle(image: "square.and.pencil")
        buttonChangeTextStyle.addTarget(self, action: #selector(changeTextStyleButtonTapped(_:)), for: .touchUpInside)
        addArrangedSubview(buttonChangeTextStyle)
    }
    
    private func setupButtonAddNewNote() {
        buttonAddNewNote = buttonsStyle(image: "plus")
        buttonAddNewNote.addTarget(self, action: #selector(addNewNoteButtonTapped(_:)), for: .touchUpInside)
        addArrangedSubview(buttonAddNewNote)
    }
    
    private func setupButtonDeleteNote() {
        buttonDeleteNote = buttonsStyle(image: "trash")
        buttonDeleteNote.addTarget(self, action: #selector(deleteNoteButtonTapped(_:)), for: .touchUpInside)
        addArrangedSubview(buttonDeleteNote)
    }
    
    private func buttonsStyle(image: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: image), for: .normal)
        button.tintColor = UIColor(named: "Coral")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
//    MARK: - Button action
    @objc private func addPhotoButtonTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.addPhotoButtonTapped()
        }
    }
    
    @objc private func changeTextStyleButtonTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.changeTextStyleButtonTapped()
        }
    }
    
    @objc private func addNewNoteButtonTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.addNewNoteButtonTapped()
        }
    }
    
    @objc private func deleteNoteButtonTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.deleteNoteButtonTapped()
        }
    }
    
}
