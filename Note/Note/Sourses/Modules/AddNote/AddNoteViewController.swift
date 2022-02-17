//
//  AddNoteViewController.swift
//  Note
//
//  Created by Татьяна Лузанова on 10.02.2022.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    private enum Layout {
        static let subviewInset: CGFloat = 10
        
        enum BottomStackView {
            static let height: CGFloat = 50
        }
        
        enum BottomStyleView {
            static let height: CGFloat = 110
            static let subviewInset: CGFloat = 10
        }
    }
    
    private enum fontStyle {
        static let name = UIFont.boldSystemFont(ofSize: 24)
        static let title = UIFont.boldSystemFont(ofSize: 22)
        static let subtitel = UIFont.boldSystemFont(ofSize: 20)
        static let mainText = UIFont.systemFont(ofSize: 20)
        static let boldStyle = UIFont.boldSystemFont(ofSize: 20)
        static let italicStyle = UIFont.italicSystemFont(ofSize: 20)
    }
    
    private let presenter: AddNoteViewOutput
    
    private var buttonBack = UIButton(frame: .zero)
    private var buttonDone = UIButton(frame: .zero)
    
    private var dateLabel = UILabel(frame: .zero)
    private var textField = UITextField()
    private var textView = UITextView(frame: .zero)
    private var bottomStackView = BottomStackView()
    private var bottomStyleView = BottomStyleView()
    
    private var bottomAnchorbottomStyleView: NSLayoutConstraint?
    private var bottomAnchorbottomStackView: NSLayoutConstraint?
    
//    MARK: - Init
    init(presenter: AddNoteViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
//    MARK: Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        setupBackButton()
        setupDoneButton()
        setupDateLabel()
        setupTextField()
        setupTextView()
        setupBottomStackView()
        setupBottomStyleView()
        setupLayout()
    }
    
    private func setupBackButton() {
        buttonBack = buttonsStyle(image: "chevron.backward")
        buttonBack.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(buttonBack)
    }
    
    private func setupDoneButton() {
        buttonDone.isHidden = true
        buttonDone = buttonsStyle(image: "checkmark")
        buttonDone.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(buttonDone)
    }
    
    private func setupDateLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm:ss"
        dateLabel.text = formatter.string(from: presenter.currentModel().dateOfLastChange)
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        dateLabel.textColor = .black
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
    }
    
    private func setupTextField() {
        textField.text = presenter.currentModel().name
        textField.placeholder = "Start here..."
        textField.textAlignment = .left
        textField.font = UIFont.boldSystemFont(ofSize: 24)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
    }
    
    private func setupTextView() {
        textView.text = presenter.currentModel().text
        textView.textColor = presenter.currentColor()
        textView.textAlignment = .left
        textView.font = presenter.currentFont()
        textView.delegate = self
        textView.tag = 2
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
    }
    
    private func setupBottomStackView() {
        bottomStackView.delegate = self
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStackView)
    }
    
    private func setupBottomStyleView() {
        bottomStyleView.isHidden = true
        bottomStyleView.delegate = self
        bottomStyleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStyleView)
    }
    
//    MARK: - Layout
    private func setupLayout() {
        let bottomAnchorbottomStyleView = bottomStyleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let bottomAnchorbottomStackView = bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        self.bottomAnchorbottomStyleView = bottomAnchorbottomStyleView
        self.bottomAnchorbottomStackView = bottomAnchorbottomStackView
        
        NSLayoutConstraint.activate([
            
            buttonBack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.subviewInset),
            buttonBack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.subviewInset),
            
            buttonDone.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.subviewInset),
            buttonDone.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.subviewInset),
            
            dateLabel.topAnchor.constraint(equalTo: buttonDone.bottomAnchor, constant: Layout.subviewInset),
            dateLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Layout.subviewInset),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.subviewInset),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.subviewInset),
            
            bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.subviewInset),
            bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.subviewInset),
            bottomStackView.heightAnchor.constraint(equalToConstant: Layout.BottomStackView.height),
            bottomAnchorbottomStackView,
            
            textView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Layout.subviewInset),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.subviewInset),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.subviewInset),
            textView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor),
            
            bottomStyleView.heightAnchor.constraint(equalToConstant: Layout.BottomStyleView.height),
            bottomStyleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStyleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchorbottomStyleView,
        ])
    }
    
//     MARK: - Style methods
    private func buttonsStyle(image: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: image), for: .normal)
        button.tintColor = UIColor(named: "Coral")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
//    MARK: - Button action
    @objc private func doneButtonTapped(_ sender: UIButton) {
        presenter.buttonDoneTapped()
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        presenter.buttonBackTapped()
    }
    
//  MARK: - Keybord
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            bottomAnchorbottomStackView?.constant = -keyboardHeight
            bottomAnchorbottomStyleView?.constant = -keyboardHeight
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomAnchorbottomStackView?.constant = 0
        bottomAnchorbottomStyleView?.constant = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        } else {
            super.touchesBegan(touches, with: event)
        }
    }
}

//  MARK: - AddNoteViewInput
extension AddNoteViewController: AddNoteViewInput {
    func changeTextColor() {
        textView.textColor = presenter.currentColor()
    }
    
    func updateFont() {
        textView.font = presenter.currentFont()
    }
}

//  MARK: - TextFieldDelegate
extension AddNoteViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        self.textView.becomeFirstResponder()
        
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        presenter.addTitle(title: updatedText)
        
        return updatedText.count <= 20
    }
}

//  MARK: - TextViewDelegate
extension AddNoteViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        presenter.addNote(note: updatedText)
        
        return updatedText.count <= 500
    }
}

//  MARK: - BottomStackViewDelegate
extension AddNoteViewController: BottomStackViewDelegate {
    func addPhotoButtonTapped() {
        presenter.addPhotoButtonTapped()
    }
    
    func changeTextStyleButtonTapped() {
        bottomStyleView.isHidden = false
    }
    
    func addNewNoteButtonTapped() {
        presenter.addNewNoteButtonTapped()
    }
    
    func deleteNoteButtonTapped() {
        presenter.deleteNoteButtonTapped()
    }
}

//  MARK: - BottomStyleViewDelegate
extension AddNoteViewController: BottomStyleViewDelegate {
    func closeButtonTapped() {
        bottomStyleView.isHidden = true
    }
    
    func buttonPaintbrushTapped() {
        presenter.changeTextColor()
    }
    
    func nameButtonTapped() {
        presenter.fontForNameStyle()
    }
    
    func titleButtonTapped() {
        presenter.fontForTitleStyle()
    }
    
    func subTitleButtonTapped() {
        presenter.fontForSubTitleStyle()
    }
    
    func mainTextButtonTapped() {
        presenter.fontForMainTextStyle()
    }
    
    func boldFontButtonTapped() {
        presenter.fontForBoldStyle()
        textView.font = presenter.currentFont()
    }
    
    func italicFontButtonTapped() {
        presenter.fontForItalicStyle()
    }
    
    func underlineFontButtonTapped() {
        presenter.fontForUnderlineStyle()
    }
    
    func strikethroughFontButtonTapped() {
        presenter.fontForStrikethroughStyle()
    }
}

