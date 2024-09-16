// 
//  BaseView.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

public typealias CallbackVoid = () -> ()
public typealias Callback<T> = (T) -> ()

class BaseView: UIView {
    private lazy var containerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = Colors.primaryColor.getUIColor()
        refreshControl.layer.zPosition = -1
        refreshControl.addTarget(self, action: #selector(willRefreshWhenPull(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    private var willRefreshWhenPullCallback: CallbackVoid?
    
    required public init() {
        super.init(frame: .zero)
        self.backgroundColor = Colors.backgroundColor.getUIColor()
        self.draw()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    func getContentView() -> UIView {
        return self
    }
    
    open func isFilled() -> Bool {
        return true
    }
    
    open func isScrollable() -> Bool {
        return false
    }
    
    open func useSafeArea() -> Bool {
        return true
    }
    
    public func scrollToTop() {
        containerScrollView.setContentOffset(.zero, animated: true)
    }
    
    public func addArrangedSubview(_ view: UIView) {
        self.containerStackView.addArrangedSubview(view)
    }
    
    public func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            self.containerStackView.addArrangedSubview(view)
        }
    }
    
    public func addSpacing(spacing: CGFloat, after arrangedSubview: UIView) {
        containerStackView.setCustomSpacing(spacing, after: arrangedSubview)
    }
    
    public func getBottomSafeAreaInset() -> CGFloat {
        return WindowContainer.window?.safeAreaInsets.bottom ?? 0
    }
}

extension BaseView {
    private func draw() {
        if isScrollable() {
            drawWithScroll()
        } else {
            drawJustStackView()
        }
    }
    
    private func drawJustStackView() {
        addSubview(containerStackView)
        NSLayoutConstraint.activate([
            self.safeAreaLayoutGuide.topAnchor.constraint(equalTo: containerStackView.topAnchor),
            self.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor)
        ])
        
        if isFilled() {
            if useSafeArea() {
                self.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor).isActive = true
            } else {
                self.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor).isActive = true
            }
        } else {
            if useSafeArea() {
                self.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: containerStackView.bottomAnchor).isActive = true
            } else {
                self.bottomAnchor.constraint(greaterThanOrEqualTo: containerStackView.bottomAnchor).isActive = true
            }
        }
    }
    
    private func drawWithScroll() {
        addSubview(containerScrollView)
        containerScrollView.fit(to: self)
        containerScrollView.addSubview(containerStackView)
        containerStackView.fit(to: containerScrollView.contentLayoutGuide)
        let heightConstraint = containerStackView.heightAnchor.constraint(equalTo: containerScrollView.frameLayoutGuide.heightAnchor, multiplier: 1.0)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        containerStackView.widthAnchor.constraint(equalTo: containerScrollView.frameLayoutGuide.widthAnchor, multiplier: 1.0).isActive = true
    }
}

extension BaseView {
    @objc
    private func willRefreshWhenPull(_ sender: Any) {
        self.willRefreshWhenPullCallback?()
    }
    
    public func setPullToRefresh(_ callback: CallbackVoid?) {
        self.willRefreshWhenPullCallback = callback
        self.containerScrollView.bounces = true
        self.containerScrollView.refreshControl = refreshControl
    }
    
    public func setPullToRefreshText(_ text: String) {
        refreshControl.attributedTitle = NSAttributedString(string: text, attributes: [.foregroundColor : Colors.titleColor.getUIColor()])
    }
    
    public func endRefresh() {
        refreshControl.endRefreshing()
    }
}

public extension UIView {
    
    func fit(to view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func fit(to layoutGuide: UILayoutGuide) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0),
            self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: 0),
            self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: 0),
            self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func addToConstraint(to view: UIView, inset: (top: CGFloat, leading: CGFloat, traling: CGFloat, bottom: CGFloat)) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.leading),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: inset.traling),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom)
        ])
    }
}
