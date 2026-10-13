import CoreGraphics
import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation

guard CommandLine.arguments.count == 3,
      let url = URL(string: CommandLine.arguments[1]),
      url.scheme == "https",
      url.host != nil else {
    fputs("Usage: swift generate_qr.swift https://example.com/ output.svg\n", stderr)
    exit(1)
}

let output = URL(fileURLWithPath: CommandLine.arguments[2])
let filter = CIFilter.qrCodeGenerator()
filter.message = Data(url.absoluteString.utf8)
filter.correctionLevel = "M"

guard let image = filter.outputImage else {
    fputs("Could not encode QR code.\n", stderr)
    exit(1)
}

let bounds = image.extent.integral
let width = Int(bounds.width)
let height = Int(bounds.height)
let context = CIContext()
let colorSpace = CGColorSpaceCreateDeviceRGB()
var pixels = [UInt8](repeating: 0, count: width * height * 4)
pixels.withUnsafeMutableBytes { buffer in
    context.render(image, toBitmap: buffer.baseAddress!, rowBytes: width * 4,
                   bounds: bounds, format: .RGBA8, colorSpace: colorSpace)
}

let margin = 4
var segments: [String] = []
for y in 0..<height {
    var x = 0
    while x < width {
        if pixels[(y * width + x) * 4] >= 128 {
            x += 1
            continue
        }
        let start = x
        while x < width && pixels[(y * width + x) * 4] < 128 {
            x += 1
        }
        segments.append("M\(start + margin) \(y + margin)h\(x - start)v1h-\(x - start)z")
    }
}

let size = width + margin * 2
let svg = """
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 \(size) \(size)" shape-rendering="crispEdges">
  <rect width="\(size)" height="\(size)" fill="#fff"/>
  <path fill="#000" d="\(segments.joined())"/>
</svg>
"""

do {
    try svg.write(to: output, atomically: true, encoding: .utf8)
    print("Wrote \(output.path) (\(width)×\(height) modules, four-module margin)")
} catch {
    fputs("Could not write SVG: \(error)\n", stderr)
    exit(1)
}
