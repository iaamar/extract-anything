// Defining a data model.
class Schema {
  interface_code string @description(#"
    You dont need escape characters.

    Example:
    class Schema {
      name string
      age int
    }
  "#)
  return_type string
  other_code string
}

function GenerateBAML(content: string | image | audio | image[]) -> Schema @stream.not_null {
  client Gemini20Flash
  prompt #"
    {{ _.role('user') }}

    Generate BAML schema for the given content.

    {{ BAMLBackground() }}

    {{ ctx.output_format(prefix="Answer with this format:\n") }}

    {{ content }}
  "#
}


template_string BAMLBackground() ##"
  BAML allows you to define schemas for your data.
  Its almost like typescript, but with some differences.
  - no colons for example

  <Example Definition>
    // Define output schemas using classes
    class MyObject {
      // Optional string fields use ?
      // @description is optional, but if you include it, it goes after the field.
      name string? @description("The name of the object")
      
      // Arrays of primitives
      // arrays cannot be optional.
      tags string[]
      
      // Enums must be declared separately and are optional
      status MyEnum?
      
      // Union types
      type "success" | "error"
      
      // Primitive types
      count int
      enabled bool
      score float

      // nested objects
      nested MyObject2
    }

    // Enums are declared separately
    enum MyEnum {
      PENDING
      ACTIVE @description("Item is currently active")
      COMPLETE
    }

    // Type aliases
    type Foo = string | int

    // Recursive types
    class Article {
      title string
      content string
      sub_articles Article[]
    }

    // or with type alias
    type JSON = string | int | float | boolean | null | JSON[] | map<string, JSON>

    // Comments use double slashes
    // inline class definitions are not supported
  </Example Definition>

  Do NOT use numbers as confidence intervals if you need to use them. Prefer an enum with descriptions or literals like "high", "medium", "low".

  You must not use any of the following words as field names in your classes:
    * class
    * from
    * type
    * enum
    * function
    * test
  If you need to use of one these, append an underscore like `type_` or `from_`
  Every field must only contain 1 type

  Dedent all declarations. You must include at least once class to define the final schema.
"##

// Test the function with a sample resume. Open the VSCode playground to run this.
test vaibhav_resume {
  functions [GenerateBAML]
  args {
    content #"
      Vaibhav Gupta
      vbv@boundaryml.com

      Experience:
      - Founder at BoundaryML
      - CV Engineer at Google
      - CV Engineer at Microsoft

      Skills:
      - Rust
      - C++
    "#
  }
}
