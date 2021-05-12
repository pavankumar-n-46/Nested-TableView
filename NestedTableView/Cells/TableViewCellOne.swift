//
//  TableViewCellOne.swift
//  NestedTableView
//
//  Created by Pavan Kumar on 03/02/21.
//

import UIKit

final class TableViewCellOne: UITableViewCell {

    var helperDelegate: HeplerDelegate?
    var model: Goal?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private let menuSubsectionView: UIControl = {
        let view = UIControl()
        return view
    }()

    private let menuSubsectionLabel: UILabel = {
        let label = UILabel()
        let attrText = NSAttributedString(string: "",
                                          attributes: [.underlineStyle : NSUnderlineStyle.single.rawValue])
        label.attributedText = attrText
        label.font = UIFont(name: "Optima", size: 25)
        return label
    }()

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 2
        stackView.layer.borderColor =  #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
        stackView.axis = .vertical
        return stackView
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.register(TableViewCellTwo.self, forCellReuseIdentifier: TableViewCellTwo.description())
        return tableView
    }()

    @objc func handleActon() {
        self.tableView.isHidden = self.tableView.isHidden ? false : true
        UIView.transition(with: containerStackView,
                          duration: 0.3,
                          options: .curveEaseInOut) {
            self.containerStackView.setNeedsLayout()
            self.helperDelegate?.heightChanged()
        }
    }

}

private extension TableViewCellOne {
    func commonInit() {
        setUI()
        setSubViews()
        setConstraints()
    }

    func setUI() {
        tableView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        menuSubsectionView.addTarget(self, action: #selector(handleActon), for: .touchUpInside)
    }

    func setSubViews() {
        menuSubsectionView.addSubview(menuSubsectionLabel)

        containerStackView.addArrangedSubview(menuSubsectionView)
        containerStackView.addArrangedSubview(tableView)

        contentView.addSubview(containerStackView)
    }

    func setConstraints() {
        menuSubsectionLabel.edgesToSuperview(insets: .left(15))

        menuSubsectionView.height(50)
        tableView.topToBottom(of: menuSubsectionView)
        tableView.edgesToSuperview(excluding: .top)

        containerStackView.edgesToSuperview(insets: .uniform(15))
    }
}

//MARK: Configure
extension TableViewCellOne {
    func configure(withModel model: Goal) {
        self.model = model
        self.menuSubsectionLabel.text = model.title
    }
}

//MARK: Tableview delegates
extension TableViewCellOne: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.Actions.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellTwo.description(),
                                                       for: indexPath) as? TableViewCellTwo,
              let action = model?.Actions[indexPath.row]
        else { return UITableViewCell() }
        cell.configure(withModel: action)
        return cell
    }
}
