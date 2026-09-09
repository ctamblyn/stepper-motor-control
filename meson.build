project('coding-standards')

typst = find_program('typst', required: true)

input = files('src/stepper-motor-control.typ')
output = 'stepper-motor-control.pdf'

custom_target(
  input: input,
  output: output,
  command: [
    typst,
    'compile',
    '@INPUT@',
    '@OUTPUT@',
  ],
  build_by_default: true,
)
