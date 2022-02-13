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
            static let height: CGFloat = 30
            static let bottomInset: CGFloat = 300
        }
        
        enum BottomStyleTextView {
            static let height: CGFloat = 300
            static let subviewInset: CGFloat = 10
        }
    }
    
    private enum fontStyle {
        static let name = UIFont.boldSystemFont(ofSize: 24)
        static let title = UIFont.boldSystemFont(ofSize: 22)
        static let subtitel = UIFont.boldSystemFont(ofSize: 20)
        static let mainText = UIFont.systemFont(ofSize: 18)
    }
    
    private let presenter: AddNoteViewOutput
    
    private var buttonBack = UIButton(frame: .zero)
    private var buttonDone = UIButton(frame: .zero)
    
    private var dateLabel = UILabel(frame: .zero)
    private var textField = UITextField()
    private var textView = UITextView(frame: .zero)
    private var bottomStackView = UIStackView()
    private var buttonChangeTextStyle = UIButton(frame: .zero)
    private var buttonAddPhoto = UIButton(frame: .zero)
    private var buttonAddNewNote = UIButton(frame: .zero)
    private var buttonDeleteNote = UIButton(frame: .zero)
    
    private var bottomStyleView = UIView(frame: .zero)
    private var buttonClosebottomStyleView = UIButton(frame: .zero)
    private var formatLabel = UILabel(frame: .zero)
    private var styleStackView = UIStackView(frame: .zero)
    private var buttonName = UIButton(frame: .zero)
    private var buttonTitle = UIButton(frame: .zero)
    private var buttonSubTitle = UIButton(frame: .zero)
    private var buttonMainText = UIButton(frame: .zero)
    
//    MARK: - Init
    init(presenter: AddNoteViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }

//    MARK: Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        setupBackButton()
        setupDoneButton()
        setupDateLabel()
        setupTextField()
        setupTextView()
        setupStackView()
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
        textView.textColor = UIColor.black
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.delegate = self
        textView.tag = 2
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
    }
    
    private func setupStackView() {
        bottomStackView = stackViewStyle()
        view.addSubview(bottomStackView)
        setupButtons()
    }
    
    private func setupBottomStyleView() {
        bottomStyleView.backgroundColor = UIColor.white
        bottomStyleView.isHidden = true
        bottomStyleView.layer.borderColor = UIColor.lightGray.cgColor
        bottomStyleView.layer.borderWidth = 1
        bottomStyleView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomStyleView.layer.shadowRadius = 5
        bottomStyleView.layer.shadowOpacity = 0.5
        bottomStyleView.layer.shadowOffset = CGSize.zero
        bottomStyleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStyleView)
        setupButtonCloseBottomStyleView()
        setupformatLabel()
        setupStyleStackView()
        
    }
    
    private func setupLayout() {
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
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 50),
            
            textView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Layout.subviewInset),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Layout.subviewInset),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Layout.subviewInset),
            textView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor),
            
            bottomStyleView.heightAnchor.constraint(equalToConstant: 100),
            bottomStyleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStyleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomStyleView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor),
            
            formatLabel.topAnchor.constraint(equalTo: bottomStyleView.topAnchor, constant: Layout.BottomStyleTextView.subviewInset),
            formatLabel.leadingAnchor.constraint(equalTo: bottomStyleView.leadingAnchor, constant: Layout.BottomStyleTextView.subviewInset),
            
            buttonClosebottomStyleView.trailingAnchor.constraint(equalTo: bottomStyleView.trailingAnchor, constant: -Layout.BottomStyleTextView.subviewInset),
            buttonClosebottomStyleView.centerYAnchor.constraint(equalTo: formatLabel.centerYAnchor),
            
            styleStackView.topAnchor.constraint(equalTo: formatLabel.bottomAnchor, constant: Layout.BottomStyleTextView.subviewInset),
            styleStackView.leadingAnchor.constraint(equalTo: bottomStyleView.leadingAnchor, constant: Layout.BottomStyleTextView.subviewInset),
            styleStackView.trailingAnchor.constraint(equalTo: bottomStyleView.trailingAnchor, constant: -Layout.BottomStyleTextView.subviewInset),
            
        ])
    }
    
    private func setupButtons() {
        
        buttonAddPhoto = buttonsStyle(image: "camera")
        buttonAddPhoto.addTarget(self, action: #selector(addPhotoButtonTapped(_:)), for: .touchUpInside)
        bottomStackView.addArrangedSubview(buttonAddPhoto)
    
        buttonChangeTextStyle = buttonsStyle(image: "square.and.pencil")
        buttonChangeTextStyle.addTarget(self, action: #selector(changeTextStyleButtonTapped(_:)), for: .touchUpInside)
        bottomStackView.addArrangedSubview(buttonChangeTextStyle)
        
        buttonAddNewNote = buttonsStyle(image: "plus")
        buttonAddNewNote.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside)
        bottomStackView.addArrangedSubview(buttonAddNewNote)
        
        buttonDeleteNote = buttonsStyle(image: "trash")
        buttonDeleteNote.addTarget(self, action: #selector(deleteNoteButtonTapped(_:)), for: .touchUpInside)
        bottomStackView.addArrangedSubview(buttonDeleteNote)
    }
    
    private func styleOfSelectedText(size: CGFloat) {
        let font = UIFont.boldSystemFont(ofSize: size)
        let color = UIColor(named: "Coral")
            let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.backgroundColor: color]
            
            let attributedString = NSMutableAttributedString(string: textView.text)
            attributedString.addAttributes(attributes as [NSAttributedString.Key : Any], range: textView.selectedRange)
            
            self.textView.attributedText = attributedString
    }
    
    private func buttonsStyle(image: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: image), for: .normal)
        button.tintColor = UIColor(named: "Coral")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func styleButtonsStyle(name: String) -> UIButton {
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor(named: "Coral")?.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func stackViewStyle() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func setupButtonCloseBottomStyleView() {
        buttonClosebottomStyleView = buttonsStyle(image: "xmark.circle")
        buttonClosebottomStyleView.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        bottomStyleView.addSubview(buttonClosebottomStyleView)
    }
    
    private func setupformatLabel() {
        formatLabel.text = "Format"
        formatLabel.font = UIFont.boldSystemFont(ofSize: 24)
        formatLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomStyleView.addSubview(formatLabel)
    }
    
    private func setupStyleStackView() {
        styleStackView = stackViewStyle()
        bottomStyleView.addSubview(styleStackView)
        setupStyleButtons()
    }
    
    private func setupStyleButtons() {
        
        buttonName = styleButtonsStyle(name: "Name")
        buttonName.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        buttonName.addTarget(self, action: #selector(nameButtonTapped(_:)), for: .touchUpInside)
        styleStackView.addArrangedSubview(buttonName)
    
        buttonTitle = styleButtonsStyle(name: "Title")
        buttonTitle.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        buttonTitle.addTarget(self, action: #selector(titleButtonTapped(_:)), for: .touchUpInside)
        styleStackView.addArrangedSubview(buttonTitle)
        
        buttonSubTitle = styleButtonsStyle(name: "SubTitle")
        buttonSubTitle.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buttonSubTitle.addTarget(self, action: #selector(subTitleButtonTapped(_:)), for: .touchUpInside)
        styleStackView.addArrangedSubview(buttonSubTitle)
        
        buttonMainText = styleButtonsStyle(name: "Main text")
        buttonMainText.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonMainText.addTarget(self, action: #selector(mainTextButtonTapped(_:)), for: .touchUpInside)
        styleStackView.addArrangedSubview(buttonMainText)
    }
    
    @objc private func doneButtonTapped(_ sender: UIButton) {
        presenter.buttonDoneTapped()
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        presenter.buttonBackTapped()
    }
    
    @objc private func addPhotoButtonTapped(_ sender: UIButton) {
        presenter.addPhotoButtonTapped()
    }
    
    @objc private func changeTextStyleButtonTapped(_ sender: UIButton) {
        bottomStyleView.isHidden = false
    }
    
    @objc private func addNewNoteButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc private func deleteNoteButtonTapped(_ sender: UIButton) {
        presenter.deleteNoteButtonTapped()
    }
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        bottomStyleView.isHidden = true
    }
    
    @objc private func nameButtonTapped(_ sender: UIButton) {
        let size: CGFloat = 24
        styleOfSelectedText(size: size)
    }
    
    @objc private func titleButtonTapped(_ sender: UIButton) {
        let size: CGFloat = 20
        styleOfSelectedText(size: size)
    }
    
    @objc private func subTitleButtonTapped(_ sender: UIButton) {
        let size: CGFloat = 18
        styleOfSelectedText(size: size)
    }
    
    @objc private func mainTextButtonTapped(_ sender: UIButton) {
        let font = UIFont.systemFont(ofSize: 18)
        let color = UIColor.red
            let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.backgroundColor: color]
            
            let attributedString = NSMutableAttributedString(string: textView.text)
            attributedString.addAttributes(attributes as [NSAttributedString.Key : Any], range: textView.selectedRange)
            
            self.textView.attributedText = attributedString
    }
    
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300)
        ])
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
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
    func reloadUI() {

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

//MARK: - UIScrollView
extension UIScrollView {
    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {
        self.contentInset = edgeInsets
        self.scrollIndicatorInsets = edgeInsets
    }
}


