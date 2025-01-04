Objects:
- (Actor): Someone or something that can perform actions
    - Examples: User, System, API, Database
    - Can be a person, system, or service

- (Component): A piece of UI or system that can be interacted with
    - Examples: Button, Screen, Input Field, Message
    - Can be visual or non-visual

- (Activity): Something an Actor or Component does
    - Examples: Create List, Delete Item, Sync Data
    - Always contains a verb + action

- (Activity Flow): A sequence of Atomic Actions to complete an Activity
    - Examples: Happy Flow, Error Flow
    - Describes the normal path through an activity

- (Atomic Action): The smallest possible action that can be performed
    - Examples: tap button, show message, validate input
    - Always Actor/Component + verb + target

- (Scenario): A specific situation or condition for an Activity Flow
    - Examples: No Connection, Empty State, Loading
    - Describes alternative paths through an activity

- (Property): A value that belongs to something
    - Examples: width, color, id, name
    - Must be understandable without context

- (Behavior): How something acts or what rules it follows
    - Examples: max length, animation type, retry logic
    - Requires context to understand

- (Role): Who is responsible for implementing something
    - Examples: UI/UX Designer, Frontend Developer
    - Assigned to todos

- (Todo): A specific task that needs to be done
    - Examples: Design Button, Implement Model
    - Must link to an existing object

Instructions:

Think in objects and their relationships. Everything is an object that can be referenced with [square brackets].

Ask questions to discover objects and relationships:
- Who uses this? → Find Actors
- What do they interact with? → Find Components
- What happens when...? → Find Activities
- What could go wrong? → Find Scenarios
- What values matter? → Find Properties
- How should it behave? → Find Behaviors

Keep asking "What else?" and "Why?" to dig deeper. Use other sections in the template for inspiration.

Start anywhere:
- "User should create lists" → Activities
- "Button must be red" → Properties
- "Items should auto-sort" → Behaviors

Break it down:
1. Find the objects (Actors, Components)
2. Link them with actions (Activities)
3. Detail the steps (Flows)
4. Handle edge cases (Scenarios)
5. Define values (Properties)
6. Define rules (Behaviors)

Each object can link to any other object. Keep breaking things down until you hit atomic (indivisible) actions.

Everything must end up as a todo for a specific role.

Example usage:

1. Start with natural language
   - Write down what you want in normal English
   - Can start from different angles:
     
     Activity focused:
     - "Users should be able to create shopping lists"
     → Who does what with what
     
     Behavior focused:
     - "List items should auto-sort alphabetically"
     → How something behaves
     
     Property focused:
     - "Each list needs a unique color"
     → What values something has

2. Identify objects
   From activity "Users should create lists":
   - Who is involved? → [User]
   - What are they doing? → Create
   - What are they creating? → [Shopping List]
   
   This gives us:
   - [User] is an (Actor)
   - [Shopping List] is a (Component)
   - [Create Shopping List] is an (Activity)

   From behavior "Items auto-sort":
   - What's being affected? → [List Items]
   - What's happening to them? → Sort
   - Who/what does it? → [System]
   
   This gives us:
   - [List Items] is a (Component)
   - [System] is an (Actor)
   - [Auto Sort Items] is an (Activity)

   From property "List has color":
   - What has this value? → [Shopping List]
   - What's the value? → color
   - What type? → hex code
   
   This gives us:
   - [Shopping List] is a (Component)
   - color is a (Property)
   - hex code is the value

3. Create links and relationships
   - [User] should create [Shopping List]
   - This becomes: [User] has Activity [Create [Shopping List]]
   - Ask: What else might the User do with Shopping Lists?
   - Ask: What other Actors might work with Shopping Lists?

4. Break down into flows
   - Every Activity needs at least one flow
   - A flow is a sequence of steps to complete the Activity
   - Start with the Happy Flow (normal case)
   
   Example Activity: [Create Shopping List]
   Happy Flow:
   1. User sees empty lists screen
   2. User taps create button
   3. System shows create screen
   4. User types list name
   5. User taps save
   6. System creates list
   7. System shows success

   Then think about Scenarios:
   - Scenarios are specific situations that need different flows
   - Ask "What if..." questions
   
   Error Scenario (What if network fails?):
   1. User taps save
   2. System fails to create
   3. System shows error
   4. User taps retry

   Empty Scenario (What if no name entered?):
   1. User taps save9
   2. System shows required message
   3. User enters name

   Each step in a flow becomes an Atomic Action:
   - Atomic = can't be broken down further
   - Always has format: [Actor] verb target
   
   Examples from above:
   - [User] tap create button
   - [System] show create screen
   - [User] enter list name
   - [System] validate input

5. Identify needed components
   - Look at your Atomic Actions
   - Each action needs components to act on or with
   
   From [User] tap create button:
   - Needs [Create Button] to tap
   - Needs [Lists Screen] to show button on

   From [System] show create screen:
   - Needs [Create List Screen] to show
   - Needs [List Name Input] for typing
   - Needs [Save Button] for confirming

   From [System] show error:
   - Needs [Error Message] to display
   - Needs [Retry Button] for recovery

6. Think about scenarios
   - Each Activity needs scenario planning
   - Start with these common types:

   Connection Scenarios:
   - What if offline? → [No Connection Message]
   - What if slow? → [Loading Indicator]
   - What if timeout? → [Timeout Message]

   Data Scenarios:
   - What if empty? → [Empty State View]
   - What if too many? → [List Pagination]
   - What if invalid? → [Validation Message]

   User Scenarios:
   - What if no permission? → [Access Denied View]
   - What if first time? → [Tutorial Overlay]
   - What if mistake? → [Undo Action]

7. Define properties
   - Look at each Component
   - Ask these questions:

   Data Objects ([Shopping List]):
   - What identifies it? → id: UUID
   - When was it made? → created: timestamp
   - What describes it? → name: string

   UI Elements ([Create Button]):
   - What's its size? → width: 100px
   - How's it styled? → color: #FF0000
   - What's its content? → text: "Create"

   Messages ([Error Message]):
   - What's shown? → text: "Failed to save"
   - How urgent? → type: "error"
   - Where shown? → position: "top"

8. Define behaviors
   - Look at each object
   - What rules or actions apply?

   [List Name Input]
   - Required
   - Max 20 chars
   - No special chars
   - Show red border when invalid

   [Error Message]
   - Show 3 seconds
   - Slide in from top
   - Fade out
   - Click to dismiss

   [Shopping List]
   - Sort alphabetically
   - Archive after 30 days
   - Max 100 items
   - Sync every 5 minutes

9. Repeat steps 2-8
   - Each component might need its own flows
   - Each flow might need new components
   - Keep going until everything is covered

10. Assign work
    - Create todos for each object
    - Link todos to specific roles
    - Ensure everything is assigned

Template:

# 👤 Actors & 🧩 Components
> *Who or what performs actions and what they interact with*
> Who benefits from this? · Who maintains this? · What do users interact with? · What shows information? · What processes data? · What stores data? · What external systems are involved? · What needs to be monitored?
---

- Definition
    - Who or what?

- Possible Parents
    - (Actor)
    - (Component)

- Possible Children
    - (Activity)
    - (Property)
    - (Behavior)

- Examples:
    - [Shopping List] (Component)
    - [User] (Actor)
    - [System] (Actor)
    - [Shopping List] (Component)
    - [no connection message] (Component)

- Final Remarks:
    - Parents relationships are indirect and not defined explicitly.

# 🎬 Activities
> *Actions that actors or components perform*
> What can each actor do? · What should happen automatically? · What needs user input? · What happens periodically? · What triggers other activities? · What needs to be logged? · What needs to be measured? · What needs authorization?
---

- Definition
    - Who or what does what?

- Notation
    - (Actor)
        - (Verb) (Action)

- Possible Parents
    - (Actor)
    - (Component)

- Possible Children
    - (Activity Flow)
    - (Scenario)
    - (Property)
    - (Behavior)

- Examples
    - [User] (Actor)
        - [Create [Shopping List]] (Activity)
    - [System] (Actor)
        - [Sync [Shopping List]] (Activity)

## 🌊 Activity Flows & Scenarios
> *Step by step actions and different situations to handle*
> What's the ideal path? · What could fail? · What needs validation? · What needs confirmation? · What's time sensitive? · What needs recovery steps? · What should be cached? · What should be retried? · What needs rollback?
---

- Definition
    - What in which order?

- Notation:
    - (Parent)
        - (Activity Flow)
            - (Atomic Action)
        - (Scenario)
            - (Atomic Action)

- Possible Parent:
    - (Activity)

- Possible Children
    - (Atomic Action)
    - (Property)
    - (Behavior)

- Examples:
    - [Create [Shopping List]] (Activity)
        - [Happy Flow] (Activity Flow)
            - [User] tap create button (Atomic Action)
            - [System] navigate to shopping list screen (Atomic Action)
            - [User] input list name (Atomic Action)
            - [System] validate input (Atomic Action)
            - [System] create list (Atomic Action)
        - [Error Flow] (Activity Flow)
            - [User] tap create button (Atomic Action)
            - [System] show network error (Atomic Action)
            - [User] tap retry (Atomic Action)
        - [No Connection Scenario] (Scenario)
            - [User] tap create button (Atomic Action)
            - [System] show [no connection message] (Atomic Action)
            - [System] enable offline mode (Atomic Action)

# 📝 Properties
> *Data, configuration, and display values*
> What identifies it? · What describes it? · What configures it? · What measures it? · What styles it? · What formats it? · What tracks it? · What groups it? · What orders it?
---

- Definition
    - Which values?

- Notation:
    - (Parent)
        - key: value (Property)

- Possible Parents
    - (Actor)
    - (Component)
    - (Activity)
    - (Activity Flow)
    - (Atomic Action)

- Possible Children
    - (Behavior)

- Examples:
    - [Create Button] (Actor)
        - width: 200px (Property)
        - height: 48px (Property)
        - color: #FF0000 (Property)
    - [Shopping List] (Component)
        - id: string (Property)
        - createdAt: timestamp (Property)
        - updatedAt: timestamp (Property)
    - [no connection message] (Component)
        - message: "No connection" (Property)
        - color: "red" (Property)

# 🛠️ Behaviors
> *Rules, validations, animations, and responses*
> When should it change? · How should it respond? · What are the limits? · What needs validation? · What needs animation? · What needs protection? · What should be cached? · What should be optimized? · What should be monitored? · What needs fallback? · How should it scale? · What should be logged? · How should it fail? · What should be measured? · What needs authorization?
---

- Definition
    - How does it act?

- Notation:
    - (Parent)
        - (Behavior)

- Possible Parents
    - (Actor)
    - (Component)
    - (Activity)
    - (Activity Flow)
    - (Scenario)
    - (Atomic Action)
    - (Property)

- Possible Children
    - None

- Examples:
    - [User] input list name (Atomic Action)
        - Max 20 characters (Behavior)
        - Min 1 character (Behavior)
    - [System] show no connection message (Atomic Action)
        - Ease in and out animation (Behavior)
        - 300 ms delay (Behavior)

- Final Remarks:
    - If something can be both a behavior and a property, make it a behavior unless it can 100% be understood without context.

# 💡 Ideas & 🪵 Backlog
> *Future considerations · Out of scope · Need discussion*
> What could be added later? · What's too complex now? · What needs more research? · What would be nice to have? · What are alternative approaches? · What could be automated?
---

# ❓ Questions
> *How does.. · Should this.. · Why is.. · Did you think about..*
> What's unclear? · What needs decision? · What are the edge cases? · What could be improved? · What are we missing? · What assumptions are we making? · What risks exist? · What dependencies are there?
---

# 🎯 Roles & 📝 Todo's
> *Each item above must cascade down to a todo with assigned role*
> Who's responsible for what? · What needs to be done first? · What can be done in parallel? · What are the dependencies? · What needs coordination? · What needs review? · What needs testing? · What needs documentation?
---

* UI/UX Designer:
    - [ ] Design [Create Button]
    - [ ] Design [Shopping List Screen]
    - [ ] Design [no connection message]
    - [ ] Design animation for [System] show no connection message

* Frontend Developer:
    - [ ] Implement [Create Button]
    - [ ] Implement [Shopping List Screen]
    - [ ] Implement [List Name Input]
    - [ ] Implement [no connection message]
    - [ ] Implement offline mode

* Backend Developer:
    - [ ] Create [Shopping List] model
    - [ ] Implement [System] create list
    - [ ] Implement [System] validate input
    - [ ] Implement offline sync

* DevOps Engineer:
    - [ ] Set up error monitoring for [Error Flow]
    - [ ] Configure network status detection for [No Connection Scenario]

* Data Engineer:
    - [ ] Design [Shopping List] schema
    - [ ] Set up data validation rules

* Project Manager:
    - [ ] Define offline mode requirements
    - [ ] Document error handling scenarios
    - [ ] Validate all flows with stakeholders

* Marketeer:
    - [ ] Write user guide for shopping list creation
    - [ ] Create error message copy 