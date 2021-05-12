//
//  TableViewCellOne.swift
//  NestedTableView
//
//  Created by Pavan Kumar on 03/02/21.
//

import UIKit

final class TableViewCellTwo: UITableViewCell {

    var model: Action?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private let menuSubsectionLabel: UILabel = {
        let label = UILabel()
        let attrText = NSAttributedString(string: "",
                                          attributes: [.underlineStyle : NSUnderlineStyle.single.rawValue])
        label.attributedText = attrText
        label.font = UIFont(name: "Optima", size: 25)
        return label
    }()
}

private extension TableViewCellTwo {
    func commonInit() {
        setUI()
        setSubViews()
        setConstraints()
    }

    func setUI() {

    }

    func setSubViews() {
        contentView.addSubview(menuSubsectionLabel)
    }

    func setConstraints() {
        menuSubsectionLabel.edgesToSuperview(insets: .left(30))
    }
}

//MARK: Configure
extension TableViewCellTwo {
    func configure(withModel model: Action) {
        self.model = model
        self.menuSubsectionLabel.text = model.title
    }
}
