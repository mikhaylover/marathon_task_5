//

import UIKit

class PopoverContentController: UIViewController {
    private let sizes: [CGSize] = [CGSize(width: 300, height: 280), CGSize(width: 300, height: 150)]

    private lazy var closeButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let button = UIButton(configuration: configuration)
        let config = UIImage.SymbolConfiguration(paletteColors: [.darkGray, .systemGray4])
        button.setImage(UIImage(systemName: "xmark.circle.fill")?.applyingSymbolConfiguration(config), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: sizes.map { "\(Int($0.height))pt" })
        control.addTarget(self, action: #selector(segmentControlChangeValue), for: .valueChanged)
        control.selectedSegmentIndex = 0
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.widthAnchor.constraint(equalToConstant: 32.0).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16.0).isActive = true

        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        setPreferredContentSize(segmentedControl: segmentedControl)
    }

    private func setPreferredContentSize(segmentedControl: UISegmentedControl) {
        preferredContentSize = sizes[segmentedControl.selectedSegmentIndex]
    }

    @objc 
    private func segmentControlChangeValue(sender: UISegmentedControl) {
        UIView.animate(
            withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction],
            animations: { [weak self] in
                self?.setPreferredContentSize(segmentedControl: sender)
            }
        )
    }

    @objc
    private func close() {
        dismiss(animated: true)
    }
}
