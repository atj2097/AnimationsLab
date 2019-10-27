//
//  ViewController.swift
//  AnimationsPractice
//
//  Created by Benjamin Stone on 10/8/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

var animationTimeConst = Double()
var animationDistConst = Double()

class ViewController: UIViewController {
    
    lazy var blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var timeStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.backgroundColor = .red
        stepper.addTarget(self, action: #selector(increaseAnimationTime(sender:)), for: .touchUpInside)
        return stepper
    }()
    
    lazy var distanceStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.backgroundColor = .blue
        stepper.addTarget(self, action: #selector(increaseAnimationDistance(sender:)), for: .touchUpInside)
        return stepper
    }()
    
    lazy var leftButton: UIButton = {
       let button = UIButton()
        button.setTitle("Left", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareLeft(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Right", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareRight(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonStackView: UIStackView = {
       let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 30
        return buttonStack
    }()
    
    lazy var upButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var downButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square down", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
        blueSquare.heightAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
        blueSquare.widthAnchor.constraint(equalToConstant: 200)
    }()
    
    lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
        blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()
    
    lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
        blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
        self.view.addSubview(timeStepper)
        self.view.addSubview(distanceStepper)
        self.view.addSubview(leftButton)
        self.view.addSubview(rightButton)
        animationDistConst = Double(150)
        animationTimeConst = Double(1)
        timeStepper.maximumValue = 10
        distanceStepper.maximumValue = 200
        setUpSteppers()
    }
    
    @IBAction func animateSquareUp(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset - CGFloat(animationDistConst)
        UIView.animate(withDuration: 2) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareDown(sender: UIButton) {
        let oldOffet = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffet + CGFloat(animationDistConst)
        UIView.animate(withDuration: animationTimeConst) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareLeft(sender: UIButton) {
        let oldOffet = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffet - CGFloat(animationDistConst)
        UIView.animate(withDuration: animationTimeConst) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func animateSquareRight(sender: UIButton) {
        let oldOffet = blueSquareCenterXConstraint.constant
        blueSquareCenterXConstraint.constant = oldOffet + CGFloat(animationDistConst)
        UIView.animate(withDuration: animationTimeConst) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func increaseAnimationDistance(sender: UIStepper) {
        let distance = sender.value
        animationDistConst = distance + animationDistConst
    }
    
    @IBAction func increaseAnimationTime(sender: UIStepper) {
        let animationTime = sender.value
        animationTimeConst = animationTime + animationTimeConst
    }
    
    
    private func addSubviews() {
        view.addSubview(blueSquare)
        addStackViewSubviews()
        view.addSubview(buttonStackView)
    }
    
    private func addStackViewSubviews() {
        buttonStackView.addSubview(upButton)
        buttonStackView.addSubview(downButton)
    }
    
    private func configureConstraints() {
        constrainBlueSquare()
        constrainUpButton()
        constrainDownButton()
        constrainButtonStackView()
    }
    
    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
    }
    
    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func constrainBlueSquare() {
        blueSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSquareHeightConstaint,
            blueSquareWidthConstraint,
            blueSquareCenterXConstraint,
            blueSquareCenterYConstraint
        ])
    }
    
    private func constrainButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func setUpSteppers() {
        timeStepper.translatesAutoresizingMaskIntoConstraints = false
        [timeStepper.trailingAnchor.constraint(equalTo: blueSquare.leadingAnchor, constant: -10),timeStepper.bottomAnchor.constraint(equalTo: downButton.topAnchor, constant: -50)].forEach({$0.isActive = true})
        distanceStepper.translatesAutoresizingMaskIntoConstraints = false
        [distanceStepper.trailingAnchor.constraint(equalTo: blueSquare.leadingAnchor, constant: -10),distanceStepper.bottomAnchor.constraint(equalTo: downButton.topAnchor, constant: -100)].forEach({$0.isActive = true})
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        [leftButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),leftButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),leftButton.heightAnchor.constraint(equalToConstant: 50),leftButton.widthAnchor.constraint(equalToConstant: 100)].forEach({$0.isActive = true})
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        [rightButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),rightButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),rightButton.heightAnchor.constraint(equalToConstant: 50),rightButton.widthAnchor.constraint(equalToConstant: 100)].forEach({$0.isActive = true})
    }
    
    
    
    
    
}


