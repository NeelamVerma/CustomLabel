//
//  CustomLabel.swift
//  CustomUiLabel
//
//  Created by Neelam Verma on 6/29/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.text = "sdjsljdlsd sds dsd"
    }
    
    
    func attach() {
        let fullString = NSMutableAttributedString(attributedString: self.attributedText!)
        let image1Attachment = NSTextAttachment()
        let img = UIImage(named: "icons8-play-50")?.maskWithColor(color: UIColor.red)
        print(self.font.pointSize)
        print(self.font.lineHeight)
        print(img?.size.height)


      let newImage = img?.addImagePadding(x: 4.0, y: self.font.descender)
        image1Attachment.image = newImage
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        // add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.insert(image1String, at: fullString.length - 1)
        let img1 = UIImage(named: "icons8-play-50")?.maskWithColor(color: UIColor.red)
        let newImage1 = img1?.addImagePadding1(x: 4.0, y: self.font.descender)
        let image1Attachment1 = NSTextAttachment()
        image1Attachment1.image = newImage1
        let image1String1 = NSAttributedString(attachment: image1Attachment1)
        fullString.insert(image1String1, at: 0)
        
        // draw the result in a label
        self.attributedText = fullString
    }
    
    // Only override draw() if you perform custom drawing.
    //An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.drawText(in: rect)
        
        let numberOflines = calculateMaxLines()
        print(getSeparatedLines())
        print(lastLineWidth)
        for i in 1..<numberOflines {
            drawLineFromPoint(start: CGPoint(x: 0.0 , y: CGFloat(i) * self.font.lineHeight), toPoint: CGPoint(x: self.intrinsicContentSize.width, y: CGFloat(i) * self.font.lineHeight), ofColor: UIColor.red, inView: self)
        }
        
        let MyRange = NSRange(location: (self.text?.count)! - 2, length: (self.text?.count)! - 1)
        let rect =  self.boundingRectForCharacterRange(range: MyRange)
        
        drawLineFromPoint(start: CGPoint(x: 0.0 , y: CGFloat(numberOflines) * self.font.lineHeight), toPoint: CGPoint(x: (rect?.maxX)!, y: CGFloat(numberOflines) * self.font.lineHeight), ofColor: UIColor.red, inView: self)
    }
    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        //design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)

        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 2.0
        view.layer.addSublayer(shapeLayer)
    }
    
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
    
    func getLinesArrayOfString(in label: UILabel) -> [String] {
        
        /// An empty string's array
        var linesArray = [String]()
        
        guard let text = label.text, let font = label.font else {return linesArray}
        
        let rect = label.frame
        
        let myFont: CTFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: myFont, range: NSRange(location: 0, length: attStr.length))
        
        let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: 100000), transform: .identity)
        
        let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        guard let lines = CTFrameGetLines(frame) as? [Any] else {return linesArray}
        
        for line in lines {
            let lineRef = line as! CTLine
            let lineRange: CFRange = CTLineGetStringRange(lineRef)
            print(lineRange)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString: String = (text as NSString).substring(with: range)
            linesArray.append(lineString)
        }
        return linesArray
    }
    
    
    func getSeparatedLines() -> [Any] {
        var lines = [Any]() /* capacity: 10 */
        let wordSeparators = CharacterSet.whitespacesAndNewlines
        var currentLine: String? = self.text
        let textLength: Int = (self.text?.count ?? 0)
        var rCurrentLine = NSRange(location: 0, length: textLength)
        var rWhitespace = NSRange(location: 0, length: 0)
        var rRemainingText = NSRange(location: 0, length: textLength)
        var done: Bool = false
        while !done {
            // determine the next whitespace word separator position
            rWhitespace.location = rWhitespace.location + rWhitespace.length
            rWhitespace.length = textLength - rWhitespace.location
            rWhitespace = (self.text! as NSString).rangeOfCharacter(from: wordSeparators, options: .caseInsensitive, range: rWhitespace)
            if rWhitespace.location == NSNotFound {
                rWhitespace.location = textLength
                done = true
            }
            let rTest = NSRange(location: rRemainingText.location, length: rWhitespace.location - rRemainingText.location)
            let textTest: String = (self.text! as NSString).substring(with: rTest)
            let userAttributes = [
                    NSAttributedString.Key.font: self.font!,
                ]
            let textSize: CGSize = textTest.size(withAttributes: userAttributes)
            let maxWidth = textSize.width
            if maxWidth > self.bounds.size.width {
                lines.append(currentLine?.trimmingCharacters(in: wordSeparators) ?? "")
                rRemainingText.location = rCurrentLine.location + rCurrentLine.length
                rRemainingText.length = textLength - rRemainingText.location
                continue
            }
            rCurrentLine = rTest
            currentLine = textTest
        }
        lines.append(currentLine?.trimmingCharacters(in: wordSeparators) ?? "")
        return lines
    }
    
    var lastLineWidth: CGFloat {
        let lines: [Any] = self.getSeparatedLines()
        if !lines.isEmpty {
            let lastLine: String = (lines.last as? String)!
            let userAttributes = [
                NSAttributedString.Key.font: self.font!,
                ]
            return (lastLine as NSString).size(withAttributes: userAttributes).width
        }
        return 0
    }


}

extension UILabel {
    func boundingRectForCharacterRange(range: NSRange) -> CGRect? {
        
        guard let attributedText = attributedText else { return nil }
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: intrinsicContentSize)
        
        textContainer.lineFragmentPadding = 0.0
        
        layoutManager.addTextContainer(textContainer)
        
        var glyphRange = NSRange()
        
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        
        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
    }
}


extension UIImage {
    
    func addImagePadding(x: CGFloat, y: CGFloat) -> UIImage? {
        let width: CGFloat = size.width + x
        let height: CGFloat = size.height + y
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let origin: CGPoint = CGPoint(x: (width - size.width) / 2, y: (height - size.height) / 2)
        draw(at: origin)
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithPadding
    }
    
    func addImagePadding1(x: CGFloat, y: CGFloat) -> UIImage? {
        let width: CGFloat = size.width + x
        let height: CGFloat = size.height + y
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let origin: CGPoint = CGPoint(x: 0.0, y: (height - size.height) / 2)
        draw(at: origin)
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithPadding
    }
    
    func maskWithColor(color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        let rect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
        
        color.setFill()
        self.draw(in: rect)
        
        context.setBlendMode(.sourceIn)
        context.fill(rect)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
}
