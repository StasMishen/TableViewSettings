//
//  ViewController.swift
//  TableView
//
//  Created by Стас on 28.04.2021.
//

import UIKit

// Разделы настроек
struct Section {
    let title: String
    let options: [SettingOptionType]
}
// Формат строки (с переключателем или с переходом)
enum SettingOptionType {
    case staticCell(model: SettingOptions)
    case switchCell(model: SettingSwitchOptions)
}
// Строка с переключателем
struct SettingSwitchOptions {
    let title: String
    let icon: UIImage?
    let iconBackgrounColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}
// Строка с переходом
struct SettingOptions {
    let title: String
    let icon: UIImage?
    let iconBackgrounColor: UIColor
    let handler: (() -> Void)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Регестрирую таблицы
    private var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()

    var models = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Настройки"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }

    func configure() {
        // 1 раздел настроек
        models.append(Section(title: "", options: [
            .switchCell(model: SettingSwitchOptions(title: "Авиарежим", icon: UIImage(systemName: "airplane"), iconBackgrounColor: .systemOrange, handler: {

            }, isOn: false)
            ),
            .staticCell(model: SettingOptions(title: "Wi-Fi", icon: UIImage(systemName: "wifi"), iconBackgrounColor: .link){

            }),
            .staticCell(model: SettingOptions(title: "Bluetooth", icon: UIImage(named: "bluetooth"), iconBackgrounColor: .link){

            }),
            .staticCell(model: SettingOptions(title: "Сотовая связь", icon: UIImage(systemName: "antenna.radiowaves.left.and.right"), iconBackgrounColor: .systemGreen){

            }),
            .staticCell(model: SettingOptions(title: "Режим модема", icon: UIImage(systemName: "personalhotspot"), iconBackgrounColor: .systemGreen){

            }),
            .switchCell(model: SettingSwitchOptions(title: "VPN", icon: UIImage(named: "vpn"), iconBackgrounColor: .link, handler: {

            }, isOn: false)
            )
        ]))
        // 2 раздел настроек
        models.append(Section(title: "", options: [
            .staticCell(model: SettingOptions(title: "Уведолления", icon: UIImage(systemName: "note"), iconBackgrounColor: .systemRed){

            }),
            .staticCell(model: SettingOptions(title: "Звуки, тактильные сигналы", icon: UIImage(systemName: "speaker.wave.3"), iconBackgrounColor: .systemRed){

            }),
            .staticCell(model: SettingOptions(title: "Не беспокоить", icon: UIImage(systemName: "moon.fill"), iconBackgrounColor: .systemPurple){

            }),
            .staticCell(model: SettingOptions(title: "Экранное время", icon: UIImage(systemName: "hourglass"), iconBackgrounColor: .systemPurple){

            }),
        ]))
        // 3 раздел настроек и т/д
        models.append(Section(title: "", options: [
            .staticCell(model: SettingOptions(title: "Основные", icon: UIImage(systemName: "gear"), iconBackgrounColor: .systemGray){

            }),
            .staticCell(model: SettingOptions(title: "Пункт управления", icon: UIImage(systemName: "slider.horizontal.3"), iconBackgrounColor: .systemGray){

            }),
            .staticCell(model: SettingOptions(title: "Экран и яркость", icon: UIImage(systemName: "textformat.size"), iconBackgrounColor: .link){

            }),
            .staticCell(model: SettingOptions(title: "Экран «Домой»", icon: UIImage(systemName: "house"), iconBackgrounColor: .systemBlue){

            }),
        ]))
    }

    // Название секции
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    // Количество разделов (групп) в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    // Количество строк в разделе
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    // Формирую строки в зависимости от типа
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models [indexPath.section].options[indexPath.row]

        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingTableViewCell.identifier,
                for: indexPath
            ) as? SettingTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }

    }
    // Действие при нажатии на строку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models [indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler()

        }
    }

}

