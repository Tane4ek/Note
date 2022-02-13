//
//  ViewController.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import UIKit


class NoteListViewController: UIViewController {
    
    private enum Paddings {
        static let subviewHorizontalInset: CGFloat = 30
        static let subviewVerticalInset: CGFloat = 20
        
        enum NoteListCollectionView {
            static let topInset: CGFloat = 40
        }
    }
    
    private let presenter: NoteListViewOutput
    
    init(presenter: NoteListViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var labelNote = UILabel(frame: .zero)
    private var buttonAdd = UIButton(frame: .zero)
    private var labelNoWallet = UILabel(frame: .zero)
    
    private var noteListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    private let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
        if presenter.numberOfItems() != 0 {
            labelNoWallet.isHidden = true
        } else {
            labelNoWallet.isHidden = false
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupLabelNote()
        setupButtonAdd()
        setupNoWalletLabel()
        setupWalletListCollectionView()
        setupLayout()
    }
    
    private  func setupLabelNote() {
        labelNote.text = "Notes"
        labelNote.font = UIFont.boldSystemFont(ofSize: 24)
        labelNote.textColor = .black
        labelNote.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelNote)
    }
    
    private func setupButtonAdd() {
        buttonAdd.setImage(UIImage(systemName: "plus"), for: .normal)
        buttonAdd.tintColor = UIColor(named: "Coral")
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.addTarget(self, action: #selector(addNoteButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(buttonAdd)
    }
    
    private func setupNoWalletLabel() {
        labelNoWallet.text = "No notes created"
        labelNoWallet.font = UIFont.systemFont(ofSize: 24)
        labelNoWallet.textColor = .black
        labelNoWallet.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelNoWallet)
    }
    
    private func setupWalletListCollectionView() {
        noteListCollectionView.register(NoteListCollectionViewCell.self, forCellWithReuseIdentifier: NoteListCollectionViewCell.reusedId)
        layout.scrollDirection = .vertical
        noteListCollectionView.backgroundColor = UIColor.clear
        noteListCollectionView.setCollectionViewLayout(layout, animated: true)
        noteListCollectionView.delegate = self
        noteListCollectionView.dataSource = self
        layout.minimumLineSpacing = 10
        noteListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(noteListCollectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            labelNote.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Paddings.subviewVerticalInset),
            labelNote.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Paddings.subviewHorizontalInset),
            
            buttonAdd.centerYAnchor.constraint(equalTo: labelNote.centerYAnchor),
            buttonAdd.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Paddings.subviewHorizontalInset),
            
            labelNoWallet.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelNoWallet.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            noteListCollectionView.topAnchor.constraint(equalTo: labelNote.bottomAnchor, constant: Paddings.NoteListCollectionView.topInset),
            noteListCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            noteListCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            noteListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func addNoteButtonTapped(_ sender: UIButton) {
        presenter.buttonAddTapped()
    }
}

extension NoteListViewController: NoteListViewInput {
    func reloadUI() {
        noteListCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension NoteListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource
extension NoteListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = noteListCollectionView.dequeueReusableCell(withReuseIdentifier: NoteListCollectionViewCell.reusedId, for: indexPath) as! NoteListCollectionViewCell
        let modelOfIndex = presenter.modelOfIndex(index: indexPath.row)
        cell.configure(model: modelOfIndex)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NoteListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}

