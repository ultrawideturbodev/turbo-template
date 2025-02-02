# Example Data Models

This directory contains example data models that demonstrate best practices for structuring Firestore data models in YAML format.

## Structure

Each model is defined in a YAML file with the following structure:

```yaml
name: ExampleDto
description: Clear description of what this model represents
locations:
  - path/to/collection/{$id}
fields:
  fieldName:
    type: string|number|boolean|array|map|timestamp|reference
    required: true|false
    nullable: true|false
    description: Clear description of the field's purpose
    example: "Example value"
    ref: string|AnotherDto  # For arrays and maps
    enums:  # For string fields with fixed values
      - value1
      - value2
```

## Best Practices

1. **Naming**
   - Use clear, descriptive names ending in `Dto`
   - Use camelCase for field names
   - Be consistent with naming across related models

2. **Types**
   - Use appropriate types for fields
   - For arrays and maps, always specify the `ref` type
   - Use timestamps for dates
   - Use references for document links

3. **Validation**
   - Always specify `required` and `nullable`
   - Use enums for fields with fixed values
   - Provide realistic example values
   - Document any special conditions or constraints

4. **Documentation**
   - Write clear descriptions
   - Include all possible locations
   - Document relationships between models
   - Explain any complex business logic

5. **Organization**
   - Group related models in subdirectories
   - Keep models focused and single-purpose
   - Follow the principle of separation of concerns

## Examples

The `coffeeFarms` and `machineConfig` directories contain example models that demonstrate these practices. Key features demonstrated include:

- Basic CRUD model structure
- Relationships between models
- Array and map handling
- Enum usage
- Timestamp fields
- Required vs optional fields
- Nullable vs non-nullable fields 