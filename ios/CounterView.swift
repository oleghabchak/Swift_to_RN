//
//  CounterView.swift
//  CounterApp
//
//  Created by Andrei Pfeiffer on 3/29/18.
//

import UIKit

class CounterView: UIView {

  // TODO: Need checked how delete
  @objc var count: NSNumber = 0 {
    didSet {
    }
  }
  @objc var onUpdate: RCTDirectEventBlock?


  
  private lazy var textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    label.textAlignment = .center
    label.textColor = .black
    label.font = .systemFont(ofSize: 50.0, weight: .regular)
    label.text = "-----"
    return label
  }()

  private lazy var timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 50.0, weight: .regular)
    label.text = "0"
    label.textColor = .black
    return label
  }()

  private lazy var leftButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    button.backgroundColor = .blue
    button.layer.cornerRadius = 5.0
    button.setTitle("<", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 50.0, weight: .regular)
    button.addTarget(self, action: #selector(leftButtonAction), for: .touchDown)
    button.setTitleColor(.gray, for: .highlighted)
    button.isEnabled = false
    return button
  }()

  private lazy var rightButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    button.backgroundColor = .blue
    button.layer.cornerRadius = 5.0
    button.setTitle(">", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 50.0, weight: .regular)
    button.addTarget(self, action: #selector(rightButtonAction), for: .touchDown)
    button.setTitleColor(.gray, for: .highlighted)
    button.isEnabled = false
    return button
  }()

  private let gameManager = GameManager()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupConstraint()
    gameManager.delegate = self
    gameManager.startLogicTimer()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setText(text: String, color: UIColor = .black) {
      textLabel.text = text
      textLabel.textColor = color
  }

  func setTime(text: String) {
      timeLabel.text = text
  }

  func isEnableButton(isEnable: Bool) {
      leftButton.isEnabled = isEnable
      rightButton.isEnabled = isEnable
  }

  private func setupConstraint() {

      self.addSubview(textLabel)
      self.addSubview(timeLabel)
      self.addSubview(leftButton)
      self.addSubview(rightButton)

      NSLayoutConstraint.activate([
          timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
          timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

          textLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
          textLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
          textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
          leftButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
          leftButton.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10),
          leftButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 60),
          leftButton.heightAnchor.constraint(equalToConstant: 80),
          rightButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
          rightButton.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10),
          rightButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -60),
          rightButton.heightAnchor.constraint(equalToConstant: 80)
      ])
  }

  @objc func leftButtonAction(sender: UIButton!) {
    gameManager.checkedAnswer(button: .left)
  }

  @objc func rightButtonAction(sender: UIButton!) {
    gameManager.checkedAnswer(button: .right)
  }
}

extension CounterView: GameManagerProtocol {
  func setEnableButton(isEnable: Bool) {
    leftButton.isEnabled = isEnable
    rightButton.isEnabled = isEnable
  }

  func updateTime(time: String) {
    timeLabel.text = time
  }

  func updateText(text: String, color: UIColor) {
    textLabel.text = text
    textLabel.textColor = color
  }
}
