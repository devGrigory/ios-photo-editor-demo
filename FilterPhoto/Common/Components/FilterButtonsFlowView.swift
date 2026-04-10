//
//  FilterButtonsFlowView.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - Delegate
protocol FilterButtonsFlowViewDelegate: AnyObject {
    func filterView(_ view: FilterButtonsFlowView, didSelect filter: Filter)
}

// MARK: - Filter Buttons Flow View
final class FilterButtonsFlowView: UIView {
    
    // MARK: - Configuration
    var spacing: CGFloat = 12
    var minHorizontalPadding: CGFloat = 14
    var verticalPadding: CGFloat = 10
    
    // MARK: - Delegate
    weak var delegate: FilterButtonsFlowViewDelegate?
    
    // MARK: - Data
    private var filters: [Filter] = []
    
    // MARK: - UI
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public API
    func configure(with filters: [Filter]) {
        self.filters = filters
        rebuild()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        rebuild()
    }
    
    // MARK: - Build Layout
    private func rebuild() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        guard bounds.width > 0 else { return }
        
        let rows = computeRows(totalWidth: bounds.width)
        
        for row in rows {
            let rowView = makeRow(row)
            stackView.addArrangedSubview(rowView)
        }
    }
    
    // MARK: - Layout Logic
    private func computeRows(totalWidth: CGFloat) -> [[Filter]] {
        var rows: [[Filter]] = [[]]
        var currentWidth: CGFloat = 0
        
        for filter in filters {
            
            let filterNameWidth = textSize(title: filter.title).width
            
            if currentWidth + filterNameWidth + (rows.last!.isEmpty ? 0 : spacing) > totalWidth {
                rows.append([filter])
                currentWidth = filterNameWidth
            } else {
                rows[rows.count - 1].append(filter)
                currentWidth += filterNameWidth + spacing
            }
        }
        return rows
    }
    
    private func makeRow(_ row: [Filter]) -> UIStackView {
        
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.spacing = spacing
        rowStack.alignment = .leading
        
        let totalButtonWidth = row
            .map { textSize(title: $0.title).width }
            .reduce(0, +)
        
        let extraSpace = max(bounds.width - totalButtonWidth - CGFloat(row.count - 1) * spacing, 0)
        let extraEachSide = extraSpace / CGFloat(max(row.count * 2, 1))
        
        for filter in row {
            
            let button = UIButton(type: .system)
            
            button.setTitle(filter.title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            button.titleLabel?.lineBreakMode = .byClipping
            
            button.layer.cornerRadius = 18
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.systemGray4.cgColor
            
            button.backgroundColor = .white
            button.setTitleColor(.label, for: .normal)
            
            button.clipsToBounds = true
            
            button.contentEdgeInsets = UIEdgeInsets(
                top: verticalPadding,
                left: minHorizontalPadding + extraEachSide,
                bottom: verticalPadding,
                right: minHorizontalPadding + extraEachSide
            )
            
            button.tag = filters.firstIndex(where: { $0.id == filter.id }) ?? 0
            
            button.addTarget(self, action: #selector(didTapFilter(_:)), for: .touchUpInside)
            
            rowStack.addArrangedSubview(button)
        }
        
        return rowStack
    }
    
    // MARK: - Helpers
    private func textSize(title: String) -> CGSize {
        let font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        let attributes = [NSAttributedString.Key.font: font]
        let size = (title as NSString).size(withAttributes: attributes)
        
        return CGSize(
            width: size.width + minHorizontalPadding * 2,
            height: size.height + verticalPadding * 2
        )
    }
    
    // MARK: - Actions
    @objc private func didTapFilter(_ sender: UIButton) {
        let index = sender.tag
        guard filters.indices.contains(index) else { return }
        
        delegate?.filterView(self, didSelect: filters[index])
        
        rebuild()
    }
}
