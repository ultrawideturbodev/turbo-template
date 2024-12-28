# 🔍 Self QA Checklist

## 🔧 Methods

- [ ] Show logging with log.debug('Example') where sensible to do so for debugging / crash reporting purposes.
- [ ] Send analytics where sensible to do.
- [ ] Document methods per dart documentation best practices where sensible to do so.
- [ ] Show busy states when needed and feedback to the user when needed.
- [ ] Consider adding timeouts where needed.
- [ ] Add try catch and proper error handling where needed.
- [ ] Show user feedback in the forms of dialogs and notifications where needed.
- [ ] Add translations for Strings in user facing communication.
- [ ] Make big methods smaller where possible.
- [ ] Rename methods properly.
- [ ] Check security and privacy concerns.
- [ ] Improve performance where needed, think of 0n optimisations, using isolates and other proven methods to avoid (UI) lag.

## 🏗️ Classes
- [ ] Dispose of streams, notifiers, listeners and other states where needed.
- [ ] Implement proper file structure

```
// 📍 LOCATOR ------------------------------------------------------------------------------- \\
// 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
// 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
// 👂 LISTENERS ----------------------------------------------------------------------------- \\
// ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
// 🎩 STATE --------------------------------------------------------------------------------- \\
// 🛠 UTIL ---------------------------------------------------------------------------------- \\
// 🧲 FETCHERS ------------------------------------------------------------------------------ \\
// 🏗️ HELPERS ------------------------------------------------------------------------------- \\
// 🪄 MUTATORS ------------------------------------------------------------------------------ \\
```

- [ ] Double check and ensure correct usage of public / private methods, variables and classes
- [ ] Ensure proper method naming
- [ ] Sort things alphabetically where possible for quicker reference
- [ ] Remove unused variables, imports and methods
- [ ] Ensure single responsibility principles are followed as much as as possible
- [ ] Abstract or centralise common code where possible
