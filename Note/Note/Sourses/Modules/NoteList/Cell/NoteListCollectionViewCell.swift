//
//  NoteListCollectionViewCell.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import UIKit

class NoteListCollectionViewCell: UICollectionViewCell {
    
    private enum Paddings {
        static let horizontalInset: CGFloat = 17
        static let subviewHorizontalInset: CGFloat = 30
        enum Name {
            static let topInset: CGFloat = 10
        }
        enum LabelNote {
            static let topInset: CGFloat = 10
            static let horizontalInset: CGFloat = 5
        }
        enum DateOfLastChange {
            static let topInset: CGFloat = 5
            static let bottomInset: CGFloat = 10
        }
        enum Chevron {
            static let width: CGFloat = 10
        }
    }
    
    static let reusedId = "NoteListCollectionViewCell"
    
    private var containerView = UIView(frame: .zero)
    private var name = UILabel(frame: .zero)
    private var chevron = UIImageView(frame: .zero)
    private var note = UILabel(frame: .zero)
    private var dateOfLastChange = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUICell()
    }
    
    private func setupUICell() {
        setupContainerView()
        setupName()
        setupChevron()
        setupLabelNote()
        setupDateOfLastChange()
        setupLayoutCell()
    }
    
    private func setupContainerView() {
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1.5
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
    }
    
    private func setupName() {
        name.font = UIFont.boldSystemFont(ofSize: 24)
        name.textColor = .black
        name.minimumScaleFactor = 0.5
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
    }
    
    private func setupChevron() {
        chevron.image = UIImage(named: "chevron")
        chevron.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(chevron)
    }
    
    private func setupLabelNote() {
        note.font = UIFont.systemFont(ofSize: 18)
        note.textColor = .black
        note.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(note)
    }
    
    private func setupDateOfLastChange() {
        dateOfLastChange.font = UIFont.systemFont(ofSize: 18)
        dateOfLastChange.textColor = .black
        dateOfLastChange.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateOfLastChange)
    }
    
    private func setupLayoutCell() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.horizontalInset),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.horizontalInset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            name.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Paddings.Name.topInset),
            name.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            
            chevron.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            chevron.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Paddings.subviewHorizontalInset),
            chevron.widthAnchor.constraint(equalToConstant: Paddings.Chevron.width),
            
            note.topAnchor.constraint(equalTo: name.bottomAnchor, constant: Paddings.LabelNote.topInset),
            note.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            note.trailingAnchor.constraint(equalTo: chevron.leadingAnchor, constant: Paddings.LabelNote.horizontalInset),
            
            dateOfLastChange.topAnchor.constraint(equalTo: note.bottomAnchor, constant: Paddings.DateOfLastChange.topInset),
            dateOfLastChange.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            dateOfLastChange.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Paddings.DateOfLastChange.bottomInset)
        ])
    }
    
    func configure (model: Note) {
        name.text = model.name
        note.text = model.text
//        containerView.backgroundColor = UIColor(named: model.colorName)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        dateOfLastChange.text = formatter.string(from: model.dateOfLastChange)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


