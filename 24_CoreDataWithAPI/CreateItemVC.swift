//
//  CreateItemVC.swift
//  24_CoreDataWithAPI
//
//  Created by Nandhika T M on 12/12/24.
//

import UIKit

class CreateItemVC: UIViewController
{
    //let titleLabel = UILabel()
    let nameL = UILabel()
    let descL = UILabel()
    let skuL = UILabel()
    let rateL = UILabel()
    
    var goBackButton = UIButton()
    var name = UITextField()
    var desc = UITextField()
    var sku = UITextField()
    var rate = UITextField()
    
    var submit = UIButton()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "ITEM CREATION"
        
        view.backgroundColor = .systemBackground
        
        view.contentMode = .scaleToFill
        
        setUpCreation()
    }
    
    func setUpCreation()
    {
        /*titleLabel.text = "ITEM CREATION"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)*/
        
        goBackButton.setTitle("Back", for: .normal)
        goBackButton.tintColor = .systemBlue
        goBackButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        goBackButton.addTarget(self, action: #selector(goBackButtonPressed), for: .touchUpInside)
        view.addSubview(goBackButton)
        
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.layer.cornerRadius = 10
        submit.setTitle("Submit", for: .normal)
        submit.backgroundColor = .systemBlue
        submit.tintColor = .black
        submit.isEnabled = true
        submit.addTarget(
            self,
            action: #selector(submitPressed),
            for: .touchUpInside
        )
        
        [name, desc, sku, rate].forEach
        {
            textfield in
            textfield.translatesAutoresizingMaskIntoConstraints = false
            textfield.backgroundColor = .white
            textfield.textColor = .black
            textfield.textAlignment = .center
            textfield.layer.cornerRadius = 10
            textfield.layer.borderWidth = 0.7
            textfield.layer.borderColor = UIColor.black.cgColor
            textfield.widthAnchor.constraint(equalToConstant: 200).isActive = true
            view.addSubview(textfield)
        }
        
        [nameL, descL, skuL, rateL].forEach
        {
            label in
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .black
            view.addSubview(label)
            label.font = .systemFont(ofSize: 18)
            label.adjustsFontSizeToFitWidth = true
        }
        
        nameL.text = "Name: "
        descL.text = "Description: "
        skuL.text = "SKU: "
        rateL.text = "Selling Price: "
        
        let nameHorizontal = UIStackView(arrangedSubviews: [nameL, name])
        let descHorizontal = UIStackView(arrangedSubviews: [descL, desc])
        let rateHorizontal = UIStackView(arrangedSubviews: [rateL, rate])
        let skuHorizontal = UIStackView(arrangedSubviews: [skuL, sku])
        
        [nameHorizontal, descHorizontal, rateHorizontal, skuHorizontal].forEach
        {
            stackView in
            stackView.axis = .horizontal
            stackView.distribution = .fill
            stackView.spacing = 40
            stackView.alignment = .fill
            stackView.layer.masksToBounds = true
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.widthAnchor.constraint(equalToConstant: 350).isActive = true
            stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            view.addSubview(stackView)
        }
        
        let stackView = UIStackView(
            arrangedSubviews: [nameHorizontal, descHorizontal, skuHorizontal, rateHorizontal]
        )
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.layer.masksToBounds = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            
            goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            goBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submit.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)

            /*titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)*/
        ])
    }
    
    @objc func goBackButtonPressed()
    {
        dismiss(
            animated: true,
            completion: nil
        )
    }
    
    @objc func submitPressed()
    {
        
    }
}
