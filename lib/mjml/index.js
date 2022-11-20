import mjml2html, { components, assignComponents } from '../mjml-core/index.js'
import { dependencies, assignDependencies } from '../mjml-validator/index.js'
import presetCore from '../mjml-preset-core/index.js'

assignComponents(components, presetCore.components)
assignDependencies(dependencies, presetCore.dependencies)

export default mjml2html
