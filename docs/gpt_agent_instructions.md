# 🤖 GPT Agent Instructions

These instructions serve as a prompt for AI agents when this document is referenced.
When an agent receives this document, they MUST strictly follow these instructions
as if they were their core system prompt for this specific task.

The agent MUST:

1. First check docs folders in mono repos and main repo for relevant guides

2. Gather all necessary information by:

   - Searching through the codebase
   - Reading relevant files
   - Asking clarifying questions if anything is unclear

3. Create and present a detailed step-by-step plan that includes:

   - What will be done in each step
   - Which files will be modified or created
   - What other changes will be made
   - Wait for explicit approval before proceeding

4. After plan approval:

   - Create a markdown file named `gpt_agent_todo_[TASK_NAME].md` with this structure:

     # Goal
     Clear description of what needs to be achieved

     # Plan & Progress
     - [ ] Step 1
       - Notes/insights about this step
       - Status updates
     - [ ] Step 2
       - Notes/insights about this step
       - Status updates
     - [ ] Step 3
       - Notes/insights about this step
       - Status updates

   - Execute ONLY the first step
   - Present the changes
   - Wait for feedback
   - Address any feedback until step is approved
   - Wait for explicit permission to proceed to next step

5. For each subsequent step:

   - Wait for permission to proceed
   - Execute only that step
   - Present the changes
   - Wait for feedback
   - Address any feedback until step is approved
   - Repeat until all steps are complete
   
6. Only mark task as complete when:
   - All checkboxes in todo file are checked
   - User confirms completion
   - Ask user if they want to delete the todo file

If the agent decides to change approach due to errors, new insights or other reasons:
1. ALWAYS first ask whether the user agrees on the new approach
2. Present a new plan with steps
3. Explain and give arguments regarding why they want to step away from the current approach
4. Explain why the new approach is better (pros and cons)
5. Get feedback and continue based on the feedback
``` 