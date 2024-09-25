//
//  DefinationsView.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import UIKit
import SnapKit

enum DefinationsPageButton {
    case team
    case item
    case state
    
}

class DefinationsView: BaseView {
    let items = ["Ekip", "Ekipman", "Durum"]
    let itemState: [DefinationsPageButton] = [.team, .item, .state]

    private let pageTitleLabel = UILabel()
    private let segment: UISegmentedControl!
    private let tableView = UITableView()
    private let addButton = UIButton()
    
    var callback: Callback<DefinationsPageButton>?
    var teams: [Team] = [] // Ekipleri tutan dizi

    required init() {
        segment = UISegmentedControl(items: items)
        super.init()
        prepare()
        draw()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPresentationModel(model: DefinationsViewModel.PresentationModel) {
        self.teams = model.teams // Modelden ekipleri al
                self.tableView.reloadData() // Tabloyu güncelle
    }
}
struct Team {
    let name: String
    let code: String
}


extension DefinationsView {
    public func setAddButtonCallback(callback: @escaping Callback<DefinationsPageButton>)
    {
        self.callback = callback
        
    }
    
    @objc func buttonDidTapped(_ sender: UIButton) {
        callback?(itemState[segment.selectedSegmentIndex])
    }
    
    @objc func segmentedChanged() {
        
    }
}

extension DefinationsView {
    private func prepare() {
        pageTitleLabel.textColor = Colors.titleColor.getUIColor()
        pageTitleLabel.font = Fonts.SFProText.bold.getAsFont(with: 28)
        pageTitleLabel.text = "Tanımlamalar"
        pageTitleLabel.textAlignment = .left
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addButton.backgroundColor = Colors.primaryColor.getUIColor()
        addButton.setImage(Images.back.getUIImage(), for: .normal)
        addButton.layer.cornerRadius = 12
        addButton.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        tableView.backgroundColor = .clear
        
        segment.addTarget(self, action: #selector(segmentedChanged), for: .valueChanged)
        segment.selectedSegmentIndex = 0
    }
}
extension DefinationsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = Colors.titleColor.getUIColor()
        cell.textLabel?.text = "Ekip Adı"
        return cell
    }
}

    


extension DefinationsView {
    private func draw() {
        addArrangedSubview(pageTitleLabel)
        addArrangedSubview(segment)
        addArrangedSubview(tableView)
        addSubview(addButton)
        setSpacing(24)
        pageTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        segment.snp.makeConstraints { make in
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
        }
    }
}
