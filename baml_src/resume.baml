// // Define output schemas using classes
// class Person {
//   name string @description("The name of the person")
//   experience Experience[]
//   skills Skill[]
// }

// // class Name {
// //   first string
// //   last string
// // }

// class Experience {
//   title string
//   company string
// }

// class Skill {
//   name string
// }

// function ExtractResume(resume_text: string) -> Person {
//     client Gemini20Flash
//     prompt #"
//         Extract the following resume:
//         `
//         {{ resume_text }}

//         {{ ctx.output_format(prefix="Return your answer in the following format") }}
//     "#
// }

