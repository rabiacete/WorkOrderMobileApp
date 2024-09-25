//
//  WorkFlowView.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import UIKit
import SnapKit

class WorkFlowView: BaseView {
   
    var callback: ((WorkFlowViewCallback) -> Void)?

    
    private let pageTitleLabel = UILabel()
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private let addButton = UIButton()
    
    required init() {
        super.init()
        prepare()
        draw()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPresentationModel(model: WorkFlowViewModel.PresentationModel) {
        
    }
  
    
    public func setButtonCallback(_ callback: @escaping (WorkFlowViewCallback) -> Void) {
         self.callback = callback
     }
}

enum WorkFlowViewCallback {
    case openAddWorkFlowView
}
extension WorkFlowView {
    
}

extension WorkFlowView {
    private func prepare() {
        pageTitleLabel.textColor = Colors.titleColor.getUIColor()
        pageTitleLabel.font = Fonts.SFProText.bold.getAsFont(with: 28)
        pageTitleLabel.text = "İş Akışları"
        pageTitleLabel.textAlignment = .left
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addButton.backgroundColor = Colors.primaryColor.getUIColor()
        addButton.setImage(Images.back.getUIImage(), for: .normal)
        addButton.layer.cornerRadius = 12
        
        // Butona target ekliyoruz
                addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
                
        
        searchBar.backgroundColor = .clear
        
        tableView.backgroundColor = .clear
        
    }
    
    @objc private func addButtonTapped() {
            // Butona tıklanınca çalışacak kod
            callback?(.openAddWorkFlowView) // Callback üzerinden aksiyon bildirimi yapılıyor
        }
    
    
    
}
extension WorkFlowView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = Colors.titleColor.getUIColor()
        cell.textLabel?.text = "İş Emri"
        return cell
    }
}
extension WorkFlowView {
    private func draw() {
        addArrangedSubview(pageTitleLabel)
        addArrangedSubview(searchBar)
        addArrangedSubview(tableView)
        addSubview(addButton)
        setSpacing(24)
        pageTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        searchBar.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        addButton.snp.makeConstraints { make in
            make.height.width.equalTo(56)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-24)
        }}}
