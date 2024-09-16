// 
//  TabbarView.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation
import UIKit

protocol TabBarViewDelegate: class {
    func tabChanged(_ tabBarView: TabBarView, toIndex: Int)
    
}

public let orientationChanged = Notification.Name.init(rawValue: "orientationChanged")


class TabBarView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    // Mark: - Private variables
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        //.clear
        collectionView.backgroundColor = Colors.tabbarBackground.getUIColor()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        return blurView
    }()
    
    private var backgroundImageView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private var horizontalBarLine: UIView!
    
    private let cellId: String = "CustomCellId"
    
    
    
    //59
    private let fixedTabbarHeight: CGFloat = 85
    private var horizontalBarLineLeadingConstraint: NSLayoutConstraint?
    private var horizontalBarLineWidthConstraint: NSLayoutConstraint?
    public var delegate: TabBarViewDelegate?
    
    private var titleList = [String]()
    private var iconList = [Images]()
    
    // Mark: - Public variables
    public var selectedIconColor: UIColor = Colors.tabbarSelected.getUIColor()
    public var unSelectedIconColor: UIColor = Colors.tabbarUnselected.getUIColor()
    public var selectedTitleColor: UIColor = Colors.tabbarSelected.getUIColor()
    public var unSelectedTitleColor: UIColor = Colors.tabbarUnselected.getUIColor()
    public var horizontalBarLineColor: UIColor = Colors.tabbarSlider.getUIColor()
    public var itemHighlightedColor: UIColor = .clear
    
    public var isBlured: Bool = false {
        didSet {
            if isBlured { insertSubview(blurView, at: 0) }
        }
    }
    
    public var backgroundImage: UIImage? = nil {
        didSet {
            if !isBlured {
                insertSubview(backgroundImageView, at: 0)
            }
        }
    }
    
    public var barBackgroundColor: UIColor = .white {
        didSet {
            self.backgroundColor = barBackgroundColor
        }
    }
    
    public var isScrollEnabledForMoreThanFiveElements: Bool = false {
        didSet {
            if isScrollEnabledForMoreThanFiveElements {
                flowLayout.scrollDirection = .horizontal
                collectionView.alwaysBounceHorizontal = isScrollEnabledForMoreThanFiveElements
            }
        }
    }
    
    public var isGlowing: Bool = false {
        didSet {
            if isGlowing {
                itemHighlightedColor = .clear
            }
        }
    }
    public var glowColor: UIColor = .clear
    
    private var isRotated: Bool = false
    private let observerKeyPath: String = "contentSize"
    //acilan sayfanin hangisi oldugunu belirleyip o iconu renkli acabiliriz.
    private var lastSelectedItemIndexPath = IndexPath(row: 0, section: 0)
   
    
    // Mark: - Lifecyle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initalizeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initalizeView()
        
     
        
    }
    
    private lazy var emptyView: UIView = {
        
        let currentRect = self.bounds
        let newOrigin = CGPoint(x: currentRect.origin.x + 16, y: currentRect.origin.y)
        let newRect = CGRect(origin: newOrigin, size: CGSize(width: currentRect.width - 32, height: currentRect.height))
        let emptyView = UIView(frame: newRect)
        //.clear
        emptyView.backgroundColor = Colors.tabbarBackground.getUIColor()
        
        return emptyView
    }()
    
    fileprivate func initalizeView() {
        
       self.backgroundColor = barBackgroundColor
        addSubview(emptyView)
        addSubview(collectionView)
        collectionView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 42)
        collectionView.layer.masksToBounds = false
        collectionView.layer.shadowRadius = 4
        collectionView.layer.shadowOpacity = 1
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOffset = CGSize(width: 0 , height:3)
        collectionView.isScrollEnabled = false
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: fixedTabbarHeight),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
            //emptyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -20),
            //emptyView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        
        
        // Register cell
        collectionView.register(TabItemCell.self, forCellWithReuseIdentifier: cellId)
        
        
        // Add observer for fresh content size
        collectionView.addObserver(self, forKeyPath: observerKeyPath, options: [.new], context: nil)
        
        perform(#selector(selectFirstItem), with: nil, afterDelay: 0.5)
    }
    
    // Collection view content resize completed
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let cell = self.collectionView.visibleCells.first as? TabItemCell {
            if self.horizontalBarLineWidthConstraint!.constant != cell.bounds.width {
                self.horizontalBarLineWidthConstraint?.constant = cell.bounds.width
                self.horizontalBarLine.layoutIfNeeded()
                relocateHorizontalBarWith(indexPath: lastSelectedItemIndexPath)
            }
        }
    }
    
    public func setupIconsAndTitles(iconList: [Images], titleList: [String]) {
        self.iconList = iconList
        self.titleList = titleList
        collectionView.reloadData()
        
        setupHorizontalBar()
        
    }
    
    public func changeLineColor() {
        horizontalBarLine.backgroundColor = horizontalBarLineColor
    }
    
 
    private func setupHorizontalBar() {
        horizontalBarLine = UIView(frame: .zero)
        //barline ust kenarlarina radius ekleme
        horizontalBarLine.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner ], radius: CGFloat(9))
        horizontalBarLine.backgroundColor = horizontalBarLineColor
        horizontalBarLine.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarLine)
//leftAnchor
        horizontalBarLineLeadingConstraint = horizontalBarLine.leftAnchor.constraint(equalTo: leftAnchor)
        
        horizontalBarLineLeadingConstraint!.isActive = true
        
        horizontalBarLineWidthConstraint = horizontalBarLine.widthAnchor.constraint(equalToConstant: bounds.width/CGFloat(titleList.count)/4)
        horizontalBarLineWidthConstraint?.isActive = true

        horizontalBarLine.topAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        horizontalBarLine.heightAnchor.constraint(equalToConstant: 8).isActive = true
    }
    
    private func applyGlow(toView: UIView, withColor: UIColor) {
        
        toView.layer.shadowPath = CGPath(roundedRect: toView.bounds, cornerWidth: 5, cornerHeight: 5, transform: nil)
        toView.layer.shadowColor = withColor.cgColor
        toView.layer.shadowOffset = CGSize.zero
        toView.layer.shadowRadius = 10
        toView.layer.shadowOpacity = 1
    }
    
    private func removeGlowAnimation(fromView: UIView) {
        
        fromView.layer.shadowPath = nil
        fromView.layer.shadowColor = UIColor.clear.cgColor
        fromView.layer.shadowOffset = CGSize.zero
        fromView.layer.shadowRadius = 0
        fromView.layer.shadowOpacity = 0
    }
    
    @objc private func selectFirstItem() {
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        relocateHorizontalBarWith(indexPath: IndexPath(row: 0, section: 0))
    }
    
    @objc private func handleOrientationChange() {
        // Reload collection view content to handle content size change
        // When it's finish reloading resize horizontal bar size and position
        // (We can get correct size from content size observer)
        self.flowLayout.invalidateLayout()
        self.collectionView.reloadData()
        self.isRotated = true
    }
    // bar cizgisinin pozisyonunu degistirir
      func relocateHorizontalBarWith(indexPath: IndexPath) {
        if let cellAttribs = self.collectionView.layoutAttributesForItem(at: indexPath) {
            let cellFrame = cellAttribs.frame
            let cellFrameInSuperview = collectionView.convert(cellFrame, to: collectionView.superview)
            horizontalBarLineLeadingConstraint?.constant = cellFrameInSuperview.minX + bounds.width/8
            horizontalBarLineWidthConstraint = horizontalBarLine.widthAnchor.constraint(equalToConstant: bounds.width/CGFloat(titleList.count)/3)
            horizontalBarLineWidthConstraint?.isActive = true
            UIView.animate(withDuration: 0.4, delay: 0.0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 2,
                           options: .curveEaseOut, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    
    public func showBadgeFor(cell index: Int, with text: String) {
        let indexPath = IndexPath(item: index, section: 0)
        if let cell = collectionView.cellForItem(at: indexPath) as? TabItemCell {
            cell.badgeText = text
        }
    }
    
    // Mark: - Deleaget & Datasource functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tabItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TabItemCell
        tabItemCell.itemHighlightedColor = itemHighlightedColor
        tabItemCell.selectedIconColor = selectedIconColor
        tabItemCell.unSelectedIconColor = unSelectedIconColor
        tabItemCell.selectedTitleColor = selectedTitleColor
        tabItemCell.unSelectedTitleColor = unSelectedTitleColor
        tabItemCell.iconView.image = iconList[indexPath.item].getUIImage().withRenderingMode(.alwaysTemplate)
        tabItemCell.titleLabel.text = titleList[indexPath.item]
        return tabItemCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return isScrollEnabledForMoreThanFiveElements ? CGSize(width: frame.width / 3, height: 70) : CGSize(width: frame.width / CGFloat(titleList.count), height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // change position and animate horizontalBarLine
        relocateHorizontalBarWith(indexPath: indexPath)
        
        // Remove glow layer from the view
        collectionView.visibleCells.forEach {
            if isGlowing { removeGlowAnimation(fromView: $0.contentView) }
        }
        // Apply glow animation if enabled
        if let currentCell = collectionView.cellForItem(at: indexPath) as? TabItemCell {
            currentCell.badgeText = nil
            if self.isGlowing { self.applyGlow(toView: currentCell.contentView, withColor: self.glowColor) }
        }
        lastSelectedItemIndexPath = indexPath
        delegate?.tabChanged(self, toIndex: indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        relocateHorizontalBarWith(indexPath: lastSelectedItemIndexPath)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        collectionView.removeObserver(self, forKeyPath: observerKeyPath)
    }
    
}

// Mark: - CollectionView cell
class TabItemCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let iconView = UIImageView()
    var selectedIconColor: UIColor = Colors.tabbarSelected.getUIColor()
    var unSelectedIconColor: UIColor = Colors.tabbarUnselected.getUIColor()
    var selectedTitleColor: UIColor = Colors.tabbarSelected.getUIColor()
    var unSelectedTitleColor: UIColor = Colors.tabbarUnselected.getUIColor()
    
    var itemHighlightedColor: UIColor = .clear
    var badgeText: String? = nil {
        didSet {
            if badgeText == nil {
                badgeLabel.isHidden = true
            } else {
                badgeLabel.alpha = 0
                badgeLabel.isHidden = false
                UIView.animate(withDuration: 0.5, delay: 0,
                               usingSpringWithDamping: 1,
                               initialSpringVelocity: 2,
                               options: .curveEaseIn, animations: {
                    self.badgeLabel.text = self.badgeText
                    self.badgeLabel.alpha = 1.0
                }, completion: nil)
            }
        }
    }
    
    private var badgeLabel: UIBadgeLabel = {
        let label = UIBadgeLabel(frame: .zero)
        label.backgroundColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .white
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            badgeText = nil
            iconView.tintColor = isSelected ? selectedIconColor : unSelectedIconColor
            titleLabel.textColor = isSelected ? selectedTitleColor : unSelectedTitleColor
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? itemHighlightedColor : .clear
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconView.tintColor = unSelectedIconColor
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        addSubview(badgeLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 11)
        titleLabel.textColor = unSelectedTitleColor
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            //25
            iconView.widthAnchor.constraint(equalToConstant: 33),
            iconView.heightAnchor.constraint(equalToConstant: 33),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            
            badgeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 40),
            badgeLabel.heightAnchor.constraint(equalToConstant: 15),
            badgeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            badgeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        badgeLabel.layer.cornerRadius = 5
        badgeLabel.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UIBadgeLabel: UILabel {
    
    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        return CGSize(width: originalSize.width + 8, height: originalSize.height)
    }
}

extension UIView {

   func roundCorners(corners:CACornerMask, radius: CGFloat) {
      self.layer.cornerRadius = radius
      self.layer.maskedCorners = corners
   }
}
