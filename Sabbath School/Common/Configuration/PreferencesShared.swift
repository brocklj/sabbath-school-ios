/*
 * Copyright (c) 2017 Adventech <info@adventech.io>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import UIKit

struct PreferencesShared {
    static var userDefaults: UserDefaults {
        return UserDefaults(suiteName: Constants.DefaultKey.appGroupName) ?? UserDefaults.standard
    }
    
    static func loggedIn() -> Bool {
        return PreferencesShared.currentUser() != nil
    }
    
    static func currentUser() -> Account? {
        guard let dictionary = PreferencesShared.userDefaults.value(forKey: Constants.DefaultKey.accountObject) as? Data else {
            return nil
        }

        let user: Account = try! JSONDecoder().decode(Account.self, from: dictionary)
        return user
    }

    static func currentLanguage() -> QuarterlyLanguage {
        guard let dictionary = PreferencesShared.userDefaults.value(forKey: Constants.DefaultKey.quarterlyLanguage) as? Data else {
            return QuarterlyLanguage(code: "en", name: "English")
        }

        let language: QuarterlyLanguage = try! JSONDecoder().decode(QuarterlyLanguage.self, from: dictionary)
        return language
    }
    
    static func currentQuarterly() -> String {
        guard let lastQuarterlyIndex = PreferencesShared.userDefaults.string(forKey: Constants.DefaultKey.lastQuarterlyIndex) else {
            return ""
        }
        return lastQuarterlyIndex
    }
}
