# Goal
Make all documentation in the docs folder project-agnostic so it can be applied to any project we work on, assuming we follow the same development practices across projects.

# Plan & Progress
- [x] Step 1: Create Documentation Inventory
  - Completed inventory of all documents
  - Identified project-specific patterns:
    1. Project-specific class names (e.g., RmyApi, ShoppingListDto)
    2. Project-specific collections (e.g., shopping_lists, households)
    3. Project-specific features (e.g., household management)
    4. Project-specific base classes (e.g., BeforeHouseholdSyncService)
  - Documents requiring updates:
    
    Firebase/Firestore (High Priority):
    - how_we_delete_firestore_documents.md (Project collections)
    - how_we_create_firestore_documents.md (RmyApi, shopping lists examples)
    - how_we_setup_firebase.md (Project configuration)
    - how_we_set_up_a_new_firestore_collection.md (Project collections)
    - how_we_sync_household_dependent_firestore_data.md (Household specific)
    - how_we_update_firestore_fields.md (Project examples)
    
    Views/UI (Medium Priority):
    - how_we_create_a_new_view.md (Project examples)
    - how_we_update_only_specific_parts_of_the_ui.md (Project examples)
    - how_we_pass_data_to_new_views.md (Project examples)
    
    Structure/Standards (Medium Priority):
    - how_we_structure_classes.md (Project patterns)
    - how_we_structure_dart_classes.md (Project patterns)
    - how_we_use_constants_and_globals.md (Project constants)
    - how_we_translate_strings.md (Project i18n)
    
    Configuration (Low Priority):
    - how_we_configure_emulators.md (Project setup)
    - how_we_run_our_app_locally.md (Project setup)
    
    GPT Prompts (Low Priority):
    - gpt_agent_instructions.md (Project references)
    - local_agent_instructions.md (Project references)
    - container_agent_instructions.md (Project references)

- [ ] Step 2: Process Firebase/Firestore Documents
  - Update collection/document naming conventions
  - Replace specific implementation details with generic patterns
  - Documents to process:
    - how_we_delete_firestore_documents.md
    - how_we_create_firestore_documents.md
    - how_we_setup_firebase.md
    - how_we_set_up_a_new_firestore_collection.md
    - how_we_sync_household_dependent_firestore_data.md
    - how_we_update_firestore_fields.md

- [ ] Step 3: Process View and UI Documents
  - Generalize view creation and structure docs
  - Update UI-related documentation
  - Documents to process:
    - how_we_create_a_new_view.md
    - how_we_update_only_specific_parts_of_the_ui.md
    - how_we_pass_data_to_new_views.md

- [ ] Step 4: Process Structure and Standards Documents
  - Update class structure documentation
  - Review coding standards
  - Documents to process:
    - how_we_structure_classes.md
    - how_we_structure_dart_classes.md
    - how_we_use_constants_and_globals.md
    - how_we_translate_strings.md

- [ ] Step 5: Process Configuration and Setup Documents
  - Update environment setup docs
  - Review local development guides
  - Documents to process:
    - how_we_configure_emulators.md
    - how_we_run_our_app_locally.md

- [ ] Step 6: Process GPT Prompts
  - Update agent instructions
  - Documents to process:
    - gpt_agent_instructions.md
    - local_agent_instructions.md
    - container_agent_instructions.md

- [ ] Step 7: Final Review
  - Cross-reference all documents
  - Verify consistency in terminology
  - Ensure no project-specific references remain 