//
//  BottomStyleView.swift
//  Note
//
//  Created by Поздняков Игорь Николаевич on 15.02.2022.
//

import UIKit

class BottomStyleView: UIView {

    private enum Layout {
        static let subviewInset: CGFloat = 10
    }
    
    private enum fontStyle {
        static let name = UIFont.boldSystemFont(ofSize: 24)
        static let title = UIFont.boldSystemFont(ofSize: 22)
        static let subtitel = UIFont.boldSystemFont(ofSize: 20)
        static let mainText = UIFont.systemFont(ofSize: 18)
    }
    
    private var buttonClosebottomStyleView = UIButton(frame: .zero)
    private var buttonPaintbrush = UIButton(frame: .zero)
    private var formatLabel = UILabel()
    
    private var styleFontStackView = UIStackView(frame: .zero)
    private var buttonBoldFont = UIButton(frame: .zero)
    private var buttonItalicFont = UIButton(frame: .zero)
    private var buttonUnderlineFont = UIButton(frame: .zero)
    private var buttonStrikethroughFont = UIButton(frame: .zero)
    
    private var styleStackView = UIStackView(frame: .zero)
    private var buttonName = UIButton(frame: .zero)
    private var buttonTitle = UIButton(frame: .zero)
    private var buttonSubTitle = UIButton(frame: .zero)
    private var buttonMainText = UIButton(frame: .zero)
    
    var delegate: BottomStyleViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize.zero
        setupformatLabel()
        setupButtonCloseBottomStyleView()
        setupButtonPaintbrush()
        setupStyleStackView()
        setupStyleFontStackView()
        setupLayout()
    }
    
    private func setupButtonCloseBottomStyleView() {
        buttonClosebottomStyleView = buttonsStyle(image: "xmark.circle")
        buttonClosebottomStyleView.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
        addSubview(buttonClosebottomStyleView)
    }

    private func setupButtonPaintbrush() {
        buttonPaintbrush = buttonsStyle(image: "paintbrush")
        buttonPaintbrush.addTarget(self, action: #selector(buttonPaintbrushTapped(_:)), for: .touchUpInside)
        addSubview(buttonPaintbrush)
    }
    
    private func setupformatLabel() {
        formatLabel.text = "Format"
        formatLabel.font = UIFont.boldSystemFont(ofSize: 24)
        formatLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(formatLabel)
    }
    
    private func setupStyleStackView() {
        styleStackView = stackViewStyle()
        addSubview(styleStackView)
        setupStyleButtons()
    }

    private func setupStyleFontStackView() {
        styleFontStackView = stackViewStyle()
        addSubview(styleFontStackView)
        setupStyleFontButtons()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            formatLabel.topAnchor.constraint(equalTo: topAnchor, constant: Layout.subviewInset),
            formatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.subviewInset),
            
            buttonClosebottomStyleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.subviewInset),
            buttonClosebottomStyleView.centerYAnchor.constraint(equalTo: formatLabel.centerYAnchor),
            
            buttonPaintbrush.trailingAnchor.constraint(equalTo: buttonClosebottomStyleView.leadingAnchor, constant: -Layout.subviewInset),
            buttonPaintbrush.centerYAnchor.constraint(equalTo: formatLabel.centerYAnchor),
            
            styleStackView.topAnchor.constraint(equalTo: formatLabel.bottomAnchor, constant: Layout.subviewInset),
            styleStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.subviewInset),
            styleStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.subviewInset),

            styleFontStackView.centerYAnchor.constraint(equalTo: formatLabel.centerYAnchor),
            styleFontStackView.leadingAnchor.constraint(equalTo: formatLabel.trailingAnchor, constant: Layout.subviewInset),
            styleFontStackView.trailingAnchor.constraint(equalTo: buttonPaintbrush.leadingAnchor, constant: -Layout.subviewInset),
        ])
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
        buttonMainText.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        buttonMainText.addTarget(self, action: #selector(mainTextButtonTapped(_:)), for: .touchUpInside)
        styleStackView.addArrangedSubview(buttonMainText)
    }

    private func setupStyleFontButtons() {
        buttonBoldFont = styleButtonsStyle(name: "B")
        buttonBoldFont.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        buttonBoldFont.addTarget(self, action: #selector(boldFontButtonTapped(_:)), for: .touchUpInside)
        styleFontStackView.addArrangedSubview(buttonBoldFont)

        buttonItalicFont = styleButtonsStyle(name: "I")
        buttonItalicFont.titleLabel?.font = UIFont.italicSystemFont(ofSize: 20)
        buttonItalicFont.addTarget(self, action: #selector(italicFontButtonTapped(_:)), for: .touchUpInside)
        styleFontStackView.addArrangedSubview(buttonItalicFont)

        buttonUnderlineFont = styleButtonsStyle(name: "U")
        buttonUnderlineFont.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        //        var underlineString: NSMutableAttributedString = NSMutableAttributedString(string: (buttonUnderlineFont.titleLabel?.text)!)
        //        underlineString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: titleLabel?.text.count))
        //        buttonUnderlineFont.setAttributedTitle(underlineString, for: .normal)
        buttonUnderlineFont.addTarget(self, action: #selector(underlineFontButtonTapped(_:)), for: .touchUpInside)
        styleFontStackView.addArrangedSubview(buttonUnderlineFont)

        buttonStrikethroughFont = styleButtonsStyle(name: "S")
        buttonStrikethroughFont.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        //        var strikethroughString: NSMutableAttributedString = NSMutableAttributedString(string: (buttonStrikethroughFont.titleLabel?.text)!)
        //        strikethroughString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title!.count))
        //        buttonStrikethroughFont.setAttributedTitle(strikethroughString, for: .normal)
        buttonStrikethroughFont.addTarget(self, action: #selector(strikethroughFontButtonTapped(_:)), for: .touchUpInside)
        styleFontStackView.addArrangedSubview(buttonStrikethroughFont)
    }

    private func buttonChangeColor(button: UIButton) {
        if button.backgroundColor == UIColor.white {
            button.backgroundColor = UIColor(named: "Coral")
        } else if button.backgroundColor == UIColor(named: "Coral") {
            button.backgroundColor = UIColor.white
        }
    }

    private func stackViewStyle() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    @objc private func closeButtonTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.closeButtonTapped()
        }
    }
    
    @objc private func buttonPaintbrushTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.buttonPaintbrushTapped()
        }
    }
    
    @objc private func nameButtonTapped(_ sender: UIButton) {
        buttonChangeColor(button: sender)
        if buttonName.backgroundColor == UIColor(named: "Coral") {
            buttonTitle.backgroundColor = UIColor.white
            buttonSubTitle.backgroundColor = UIColor.white
            buttonMainText.backgroundColor = UIColor.white
            buttonBoldFont.backgroundColor = UIColor(named: "Coral")
        }
        if let delegate = delegate {
            delegate.nameButtonTapped()
        }
    }
    
    @objc private func titleButtonTapped(_ sender: UIButton) {
        buttonChangeColor(button: sender)
        if buttonTitle.backgroundColor == UIColor(named: "Coral") {
            buttonName.backgroundColor = UIColor.white
            buttonSubTitle.backgroundColor = UIColor.white
            buttonMainText.backgroundColor = UIColor.white
            buttonBoldFont.backgroundColor = UIColor(named: "Coral")
        }
        
        if let delegate = delegate {
            delegate.titleButtonTapped()
        }
    }
    
    @objc private func subTitleButtonTapped(_ sender: UIButton) {
        buttonChangeColor(button: sender)
        if buttonSubTitle.backgroundColor == UIColor(named: "Coral") {
            buttonTitle.backgroundColor = UIColor.white
            buttonName.backgroundColor = UIColor.white
            buttonMainText.backgroundColor = UIColor.white
            buttonBoldFont.backgroundColor = UIColor(named: "Coral")
        }
        
        if let delegate = delegate {
            delegate.subTitleButtonTapped()
        }
    }
    
    @objc private func mainTextButtonTapped(_ sender: UIButton) {
        buttonChangeColor(button: sender)
        if buttonMainText.backgroundColor == UIColor(named: "Coral") {
            buttonTitle.backgroundColor = UIColor.white
            buttonSubTitle.backgroundColor = UIColor.white
            buttonName.backgroundColor = UIColor.white
            buttonBoldFont.backgroundColor = UIColor.white
        }
        
        if let delegate = delegate {
            delegate.mainTextButtonTapped()
        }
    }
    
    @objc private func boldFontButtonTapped(_ sender: UIButton) {
        buttonChangeColor(button: sender)
        
        if let delegate = delegate {
            delegate.boldFontButtonTapped()
        }
    }
    
    @objc private func italicFontButtonTapped(_ sender: UIButton) {
        buttonChangeColor(button: sender)
        if let delegate = delegate {
            delegate.italicFontButtonTapped()
        }
    }
    
    @objc private func underlineFontButtonTapped(_ sender: UIButton) {
        buttonChangeColor(button: sender)
    }
    
    @objc private func strikethroughFontButtonTapped(_ sender: UIButton) {
        buttonChangeColor(button: sender)
    }
}
