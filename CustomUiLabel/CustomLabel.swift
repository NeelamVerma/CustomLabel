//
//  CustomLabel.swift
//  CustomUiLabel
//
//  Created by Neelam Verma on 6/29/19.
//  Copyright © 2019 Neelam Verma. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    func attach(withColor: UIColor) {
        let fullString = NSMutableAttributedString(attributedString: self.attributedText!)
//        let image1Attachment = NSTextAttachment()
//        let img = UIColor.red.image(CGSize(width: 10, height: 10))
//        image1Attachment.bounds = CGRect(x: 100.0, y: 0, width: 10, height: 10)
//        image1Attachment.image = img
//        let str = NSAttributedString(attachment: image1Attachment)
//        fullString.append(str)
        //  with padding
        
        let img = UIImage(named: "icons8-play-50")?.maskWithColor(color: withColor)
        print(self.font.pointSize)
        print(self.font.lineHeight)
        print(img?.size.height)


      let newImage = img?.resizedImage(newSize: CGSize(width: self.font.pointSize, height: self.font.pointSize)).addHorizontalImagePadding(x: 20.0, y: self.font.descender)
        
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = newImage
        let image1String = NSAttributedString(attachment: image1Attachment)
        
        // add the NSTextAttachment wrapper to our full string, then add some more text.
        fullString.insert(image1String, at: fullString.length - 1)
        let img1 = UIImage(named: "icons8-play-50")?.maskWithColor(color: withColor)
        let newImage1 = img1?.resizedImage(newSize: CGSize(width: self.font.pointSize, height: self.font.pointSize)).addHorizontalImagePadding1(x: 20.0, y: self.font.descender)
        let image1Attachment1 = NSTextAttachment()
        image1Attachment1.image = newImage1
        let image1String1 = NSAttributedString(attachment: image1Attachment1)
        fullString.insert(image1String1, at: 0)
 
        
        // draw the result in a label
        self.attributedText = fullString
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let new = NSMutableAttributedString(attributedString: self.attributedText!)
        new.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSRange(location: 0, length: (attributedText?.length)!))
        self.attributedText = new
        
    self.attributedText?.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: (attributedText?.length)!), options: [], using: { (value, range, stop) in
        
            if (value is NSTextAttachment){
                let attachment: NSTextAttachment? = (value as? NSTextAttachment)
                
                if ((attachment?.image) != nil) {
                    print("touchesBegan")
                    let mutableAttr = attributedText!.mutableCopy() as! NSMutableAttributedString
                    let newImage = attachment?.image?.maskWithColor(color: UIColor.blue)
                    let image1Attachment = NSTextAttachment()
                    image1Attachment.image = newImage
                    let image1String = NSAttributedString(attachment: image1Attachment)
                    //Remove the attachment
                    mutableAttr.replaceCharacters(in: range, with: image1String)
                    attributedText = mutableAttr
                    //arrayOfRanges.append(range)
                }else{
                    print("No image attched")
                }
            }
        })
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let new = NSMutableAttributedString(attributedString: self.attributedText!)
        new.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: (attributedText?.length)!))
        self.attributedText = new
        
        self.attributedText?.enumerateAttribute(NSAttributedString.Key.attachment, in: NSRange(location: 0, length: (attributedText?.length)!), options: [], using: { (value, range, stop) in
            
            if (value is NSTextAttachment){
                let attachment: NSTextAttachment? = (value as? NSTextAttachment)
                
                if ((attachment?.image) != nil) {
                    print("touchesEnded")
                    let mutableAttr = attributedText!.mutableCopy() as! NSMutableAttributedString
                    let newImage = attachment?.image?.maskWithColor(color: UIColor.black)
                    let image1Attachment = NSTextAttachment()
                    image1Attachment.image = newImage
                    let image1String = NSAttributedString(attachment: image1Attachment)
                    //Remove the attachment
                    mutableAttr.replaceCharacters(in: range, with: image1String)
                    attributedText = mutableAttr
                    //arrayOfRanges.append(range)
                }else{
                    print("No image attched")
                }
            }
        })
    }
    
    // Only override draw() if you perform custom drawing.
    //An empty implementation adversely affects performance during animation.
    /*
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
    */
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
    
    func addHorizontalImagePadding(x: CGFloat, y: CGFloat) -> UIImage? {
        let width: CGFloat = size.width + x
        let height: CGFloat = size.height + y
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        let origin: CGPoint = CGPoint(x: x, y: (height - size.height) / 2)
        draw(at: origin)
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithPadding
    }
    
    func addHorizontalImagePadding1(x: CGFloat, y: CGFloat) -> UIImage? {
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
    
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        return image
    }
    
    func resizedImage(newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}


extension UIColor {
    func image(_ size: CGSize = CGSize(width: 10, height: 10)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
