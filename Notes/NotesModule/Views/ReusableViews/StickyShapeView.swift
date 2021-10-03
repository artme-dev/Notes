//
//  StickyShapeView.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import UIKit

class StickyShapeView: UIView {
    
    private var noteLayer = CAShapeLayer()
    private var curlLayer = CAShapeLayer()
    
    var cornerRadius: CGFloat = 8
    var curlInset: CGFloat = 2
    var curlSize = CGSize(width: 30, height: 30)
    
    var noteColor: CGColor? {
        get { return noteLayer.fillColor }
        set { noteLayer.fillColor = newValue }
    }
    var curlColor: CGColor? {
        get { return curlLayer.fillColor }
        set { curlLayer.fillColor = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        self.layer.addSublayer(noteLayer)
        self.layer.addSublayer(curlLayer)
        
        setColors()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShapesPaths()
    }
    private func updateShapesPaths() {
        curlLayer.path = createCurlPath(noteSize: frame.size, curlSize: curlSize).cgPath
        noteLayer.path = createNotePath(noteSize: frame.size, curlSize: curlSize).cgPath
    }
    
    private func setColors() {
        noteColor = UIColor.systemGray5.cgColor
        curlColor = UIColor.systemGray4.cgColor
    }
    
    private func createNotePath(noteSize: CGSize, curlSize: CGSize) -> UIBezierPath {
        let path = UIBezierPath()
        
        let bottomLeftArcCenter = CGPoint(x: cornerRadius,
                                          y: noteSize.height - cornerRadius)
        let leftSideStart = CGPoint(x: 0, y: bottomLeftArcCenter.y)
        path.move(to: leftSideStart)
        
        addTopLeftCorner(to: path, noteSize: noteSize, curlSize: curlSize)
        
        let rightSideStart = CGPoint(x: noteSize.width, y: curlSize.height)
        path.addLine(to: rightSideStart)
        
        addBottomRightCorner(to: path, noteSize: noteSize, curlSize: curlSize)
        
        path.addArc(withCenter: bottomLeftArcCenter,
                    radius: cornerRadius,
                    startAngle: (.pi) / 2,
                    endAngle: (.pi),
                    clockwise: true)
        
        path.close()
        return path
    }
    
    private func addTopLeftCorner(to path: UIBezierPath, noteSize: CGSize, curlSize: CGSize) {
        let topLeftArcCenter = CGPoint(x: cornerRadius,
                                       y: cornerRadius)
        
        let leftSideEnd = CGPoint(x: 0, y: topLeftArcCenter.y)
        let topSideEnd = CGPoint(x: noteSize.width - curlSize.width, y: 0)
        
        path.addLine(to: leftSideEnd)
        path.addArc(withCenter: topLeftArcCenter,
                    radius: cornerRadius,
                    startAngle: .pi,
                    endAngle: 3*(.pi)/2,
                    clockwise: true)
        path.addLine(to: topSideEnd)
    }
    
    private func addBottomRightCorner(to path: UIBezierPath, noteSize: CGSize, curlSize: CGSize) {
        let bottomRightArcCenter = CGPoint(x: noteSize.width - cornerRadius,
                                           y: noteSize.height - cornerRadius)
        
        let rightSideEnd = CGPoint(x: noteSize.width, y: bottomRightArcCenter.y)
        let bottomSideEnd = CGPoint(x: cornerRadius, y: noteSize.height)
        
        path.addLine(to: rightSideEnd)
        path.addArc(withCenter: bottomRightArcCenter,
                    radius: cornerRadius,
                    startAngle: 0,
                    endAngle: (.pi) / 2,
                    clockwise: true)
        path.addLine(to: bottomSideEnd)
    }
    
    private func createCurlPath(noteSize: CGSize, curlSize: CGSize) -> UIBezierPath {
        
        let actualCurlSize = CGSize(width: curlSize.width - 2 * curlInset,
                                    height: curlSize.height - 2 * curlInset)
        
        let curlPath = UIBezierPath()
        
        let startPoint = CGPoint(x: noteSize.width - curlSize.width + curlInset,
                                 y: curlInset)
        let cornerTopPoint = CGPoint(x: startPoint.x,
                                     y: startPoint.y + actualCurlSize.height - cornerRadius)
        let cornerArcCenter = CGPoint(x: cornerTopPoint.x + cornerRadius,
                                      y: cornerTopPoint.y)
        let endPoint = CGPoint(x: startPoint.x + actualCurlSize.width,
                               y: startPoint.y + actualCurlSize.height)
        
        curlPath.move(to: startPoint)
        curlPath.addLine(to: cornerTopPoint)
        curlPath.addArc(withCenter: cornerArcCenter,
                        radius: cornerRadius,
                        startAngle: (.pi),
                        endAngle: (.pi)/2,
                        clockwise: false)
        curlPath.addLine(to: endPoint)
        
        curlPath.close()
        
        return curlPath
    }
}
