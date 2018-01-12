// Copyright © 2017 Square1.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

/// A Segue subclass prepared for root UIViewController replacement.
public class SQ1ReplaceRootControllerSegue: UIStoryboardSegue {
  
  
  /// Performs a quick fadeout animation before root UIViewController replacement.
  public override func perform() {
    
    let duration = 0.3
    guard let window = UIApplication.shared.delegate?.window else { return }

    window?.insertSubview(destination.view, belowSubview: source.view)

    UIView.animate(withDuration: duration, animations: {
      self.source.view.alpha = 0.0
    }) { _ in
      window?.bringSubview(toFront: self.destination.view)
      window?.rootViewController = self.destination
    }
  }
}
