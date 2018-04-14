//: A UIKit based Playground for presenting user interface

import PlaygroundSupport
import UIKit

class ChatCell: UITableViewCell {
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        let icon = UIImage(named: "icons8-Sheep on Bike")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = icon

        return imageView
    }()

    lazy var messageBackground: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        backgroundView.layer.cornerRadius = 10
        return backgroundView
    }()

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.textColor = .white

        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutViews()
    }

    func layoutViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(messageBackground)
        messageBackground.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            iconImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5),
            messageBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            messageBackground.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            messageBackground.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            messageBackground.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -70),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: messageBackground.trailingAnchor, constant: -5),
            messageLabel.topAnchor.constraint(equalTo: messageBackground.topAnchor, constant: 5),
            messageLabel.bottomAnchor.constraint(equalTo: messageBackground.bottomAnchor, constant: -5),
            messageLabel.leadingAnchor.constraint(equalTo: messageBackground.leadingAnchor, constant: 5)

            ])
    }
}

class MyViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorColor = .clear
        table.allowsSelection = false
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 50

        return table
    }()

    private let loremPhrases = ["Lorem ipsum",
                                "dolor sit amet",
                                "consectetur adipiscing elit",
                                "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."]

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: "cell")

        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
            ])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatCell

        cell.messageLabel.text = randomPhrase()

        return cell
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Chat"
    }

    private func randomPhrase() -> String {
        let rand = Int(arc4random_uniform(4))
        return loremPhrases[0...rand].joined(separator: " ")
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

/*
Image provide by icons8! https://icons8.com/icon/16107/sheep-on-bike
 */
