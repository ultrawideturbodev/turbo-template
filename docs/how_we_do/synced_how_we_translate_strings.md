# 🌐 How We Translate Strings

## 📖 Overview
We use Flutter's built-in internationalization system with ARB (Application Resource Bundle) files. Our app currently supports English (en) and Dutch (nl) languages.

## 📁 File Structure
- `lib/core/strings/intl_en.arb` - English translations
- `lib/core/strings/intl_nl.arb` - Dutch translations

## 🔄 Translation Process

1. ➕ **Adding New Strings**
   - Always add strings to both language files simultaneously
   - Start with English (`intl_en.arb`) as the source of truth
   - Then add the Dutch translation (`intl_nl.arb`)
   - Keep the same key order in both files for easier maintenance

2. 🔑 **String Keys**
   - Use camelCase for key names
   - Make keys descriptive of their content
   - Example: `welcomeMessage` instead of `message1`

3. 📝 **String Values**
   - Keep translations natural to each language
   - Don't do literal translations
   - Consider cultural context

4. 🔄 **Placeholders**
   - Use {variableName} for dynamic content
   - Example: `"helloUsername": "👋 Hello @{username}"`

5. 💻 **Usage in Code**
   - Access translations through `gStrings`
   - Example: `gStrings.welcomeMessage`

## 📋 Examples

```json
// English (intl_en.arb)
{
  "member": "Member",
  "pending": "Pending"
}

// Dutch (intl_nl.arb)
{
  "member": "Lid",
  "pending": "In afwachting"
}
```

## ✨ Best Practices

1. 🎯 **Consistency**
   - Use consistent terminology across the app
   - Keep similar structures for similar messages

2. 📌 **Context**
   - Add comments in the ARB files when context is needed
   - Example: `"pending": "In afwachting" // Used for invite status`

3. 🔧 **Maintenance**
   - Review both language files when adding new strings
   - Keep files synchronized
   - Remove unused strings

4. 🧪 **Testing**
   - Test the app in both languages
   - Check for text overflow
   - Verify placeholder replacements

## ⚠️ Common Pitfalls

1. 🚫 **Missing Translations**
   - Always add strings to both files
   - Check for typos in keys

2. 📊 **Inconsistent Formatting**
   - Keep the same format for dates, numbers, etc.
   - Use platform-specific formatting when appropriate

3. 🔒 **Hard-coded Strings**
   - Never use hard-coded strings in the UI
   - Always use `gStrings` for text

4. 📏 **Long Translations**
   - Consider text length differences between languages
   - Design UI to accommodate varying text lengths